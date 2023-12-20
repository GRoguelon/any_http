defmodule AnyHttp.Adapters.Httpc do
  @moduledoc """
  Defines the adapter for the `:httpc` Erlang module.
  """

  alias AnyHttp, as: T
  alias AnyHttp.Error
  alias AnyHttp.Response

  ## Behaviours

  @behaviour AnyHttp.Client

  ## Module attributes

  @protocol_versions ~w[tlsv1.2 tlsv1.3]a

  @options [body_format: :binary, full_result: true]

  @content_type String.to_charlist("content-type")

  ## Typespecs

  @type url :: charlist()

  @type header :: {charlist(), charlist()}

  @type headers :: [header()]

  @type content_type :: charlist()

  @type http_version :: charlist()

  @type status_code :: 100..599

  @type status_line :: charlist()

  @type body :: binary()

  @type httpc_response :: {{http_version(), status_code(), status_line()}, headers(), body()}

  @type httpc_error :: term()

  ## Public functions

  @impl true
  @spec request(T.method(), T.url(), T.headers(), T.body(), T.adapter_opts()) :: T.response()
  def request(method, url, headers, body, adapter_opts \\ [])

  def request(:get, _url, _headers, body, _adapter_opts) when not is_nil(body) do
    raise ArgumentError,
          "the Erlang :httpc library doesn't allow to send a body with the method get"
  end

  def request(method, url, headers, body, adapter_opts) do
    http_options = Keyword.merge(http_options(url), adapter_opts)

    url
    |> add_httpc_url()
    |> add_httpc_headers(headers)
    |> add_httpc_body(body, method)
    |> then(&:httpc.request(method, &1, http_options, @options))
    |> parse_result()
  end

  ## Private functions

  @spec add_httpc_url(binary()) :: {url()}
  defp add_httpc_url(url) when is_binary(url) do
    {String.to_charlist(url)}
  end

  @spec add_httpc_headers({url()}, T.headers()) :: {url(), headers()}
  defp add_httpc_headers(request, headers) when not is_nil(headers) do
    headers = dump_headers(headers)

    Tuple.append(request, headers)
  end

  defp add_httpc_headers(request, _headers), do: Tuple.append(request, [])

  @spec add_httpc_body({url(), headers()}, T.body(), T.method()) ::
          {url(), headers(), content_type(), binary()}
  defp add_httpc_body({_url, headers} = request, body, method)
       when is_binary(body) and method != :head do
    content_type =
      get_first_header(headers, @content_type) ||
        raise ArgumentError, "Unable to find the content-type header, required with a body"

    request |> Tuple.append(content_type) |> Tuple.append(body)
  end

  defp add_httpc_body(request, _body, _method), do: request

  @spec parse_result({:ok, httpc_response()}) :: {:ok, Response.t()}
  defp parse_result({:ok, {{_http_version, status_code, _status_line}, headers, body}}) do
    response = %Response{
      status: status_code,
      headers: parse_headers(headers),
      body: parse_body(body)
    }

    {:ok, response}
  end

  @spec parse_result({:error, httpc_error()}) :: {:error, Error.t()}
  defp parse_result(
         {:error,
          {:failed_connect,
           [{:to_address, {_host, _port}}, {:inet, [:inet], {:tls_alert, {:unknown_ca, message}}}]} =
            error}
       ) do
    {:error, Error.exception({:unknown_ca, List.to_string(message), error})}
  end

  defp parse_result({:error, :socket_closed_remotely = error}) do
    {:error, Error.exception({:conn_refused, "connection refused", error})}
  end

  defp parse_result(
         {:error,
          {:failed_connect, [{:to_address, {_host, _port}}, {:inet, [:inet], :nxdomain}]} = error}
       ) do
    {:error, Error.exception({:nxdomain, "non-existing domain", error})}
  end

  defp parse_result({:error, {:bad_scheme, scheme}}) do
    raise ArgumentError, ~s<invalid scheme "#{scheme}" for url>
  end

  defp parse_result({:error, unknown_error}) do
    {:error, Error.exception({:unknown_error, "unknown error", unknown_error})}
  end

  @spec parse_body(term()) :: Response.body()
  defp parse_body(body) when is_binary(body) and body == "", do: nil
  defp parse_body(body), do: body

  @spec parse_headers(headers()) :: Response.headers()
  defp parse_headers(headers) do
    Enum.group_by(
      headers,
      fn {key, _value} -> List.to_string(key) end,
      fn {_key, value} -> List.to_string(value) end
    )
  end

  @spec dump_headers(T.headers()) :: headers()
  defp dump_headers(headers) do
    headers
    |> Enum.map(fn
      {key, values} when is_list(values) ->
        Enum.map(values, fn value -> {String.to_charlist(key), String.to_charlist(value)} end)

      {key, value} ->
        {String.to_charlist(key), String.to_charlist(value)}
    end)
    |> List.flatten()
  end

  @spec get_first_header(headers(), charlist()) :: nil | charlist()
  defp get_first_header(headers, name) do
    Enum.find_value(headers, fn
      {header_name, header_value} when is_binary(header_value) ->
        header_name == name && header_value

      {header_name, [header_value | _]} when is_binary(header_value) ->
        header_name == name && header_value

      {header_name, header_value} ->
        header_name == name && header_value
    end)
  end

  @spec http_options(binary()) :: Keyword.t()
  defp http_options(url) do
    ssl_options = :tls_certificate_check.options(url)

    [ssl: [{:versions, @protocol_versions} | ssl_options]]
  end
end
