if Code.ensure_loaded?(:hackney) do
  defmodule AnyHttp.Adapters.Hackney do
    @moduledoc """
    Defines the adapter for the `hackney` library.
    """

    alias AnyHttp, as: T
    alias AnyHttp.Error
    alias AnyHttp.Response

    ## Behaviours

    @behaviour AnyHttp.Client

    ## Public functions

    @impl true
    @spec request(T.method(), T.url(), T.headers(), T.body(), T.adapter_opts()) :: T.response()
    def request(method, url, headers, body, adapter_opts \\ []) do
      headers = headers || []
      body = body || ""

      result = :hackney.request(method, url, headers, body, adapter_opts)

      parse_result(result)
    end

    ## Private functions

    @spec parse_result({:ok, tuple()} | {:error, atom()}) ::
            {:ok, Response.t()} | {:error, Error.t()}
    defp parse_result(result) do
      case result do
        {:ok, status, headers} ->
          headers = parse_headers(headers)

          {:ok, %Response{status: status, headers: headers, body: nil}}

        {:ok, status, headers, body} ->
          headers = parse_headers(headers)
          body = parse_body(body)

          {:ok, %Response{status: status, headers: headers, body: body}}

        {:error, {:tls_alert, {:unknown_ca, message}} = error} ->
          {:error, Error.exception({:unknown_ca, List.to_string(message), error})}

        {:error, :econnrefused} ->
          {:error, Error.exception({:conn_refused, "connection refused", :econnrefused})}

        {:error, :nxdomain} ->
          {:error, Error.exception({:nxdomain, "non-existing domain", :nxdomain})}

        {:error, unknown_error} ->
          {:error, Error.exception({:unknown_error, "unknown error", unknown_error})}
      end
    end

    @spec parse_body(binary() | reference()) :: nil | binary()
    defp parse_body(body_ref) when is_reference(body_ref) do
      {:ok, body} = :hackney.body(body_ref)

      parse_body(body)
    end

    defp parse_body(body) when is_binary(body) and body != "" do
      body
    end

    defp parse_body(_body), do: nil

    @spec parse_headers([{binary(), binary()}]) :: Response.headers()
    defp parse_headers(headers) do
      Enum.group_by(headers, fn {key, _value} -> key end, fn {_key, value} -> value end)
    end
  end
end
