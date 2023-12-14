defmodule AnyHttp do
  @moduledoc """
  Provides an interface which dispatches the function to the right adapter.

  ## Configuration

  Defines in your application the following configuration depending of the adapter you choose:

      config :any_http, :client_adapter, AnyHttp.Adapters.Req
  """

  alias AnyHttp.Response

  ## Typespecs

  @type method :: :head | :get | :post | :put | :patch | :delete

  @type url :: URI.t() | binary()

  if System.version() |> Version.parse!() |> then(&(&1.major >= 1 and &1.minor < 14)) do
    @type headers :: nil | Enumerable.t()
  else
    @type headers :: nil | Enumerable.t({binary(), binary() | [binary()]})
  end

  @type body :: nil | binary()

  @type adapter_opts :: Keyword.t()

  @type response :: {:ok, Response.t()} | {:error, Exception.t()}

  ## Module attributes

  @default_schemes ~w[http https]

  ## Public functions

  @spec request(method(), url(), headers(), body(), adapter_opts()) :: response()
  def request(method, url, headers, body, adapter_opts \\ [])

  def request(method, url, headers, body, adapter_opts) do
    url = parse_url!(url)
    headers = headers && Enum.to_list(headers)

    adapter().request(method, url, headers, body, adapter_opts)
  end

  @doc """
  Makes a HEAD request to the given URL.
  """
  @spec head(url(), headers(), adapter_opts()) :: response()
  def head(url, headers \\ nil, opts \\ []) do
    request(:head, url, headers, nil, opts)
  end

  @doc """
  Makes a GET request to the given URL.
  """
  @spec get(url(), headers(), body(), adapter_opts()) :: response()
  def get(url, headers \\ nil, body \\ nil, opts \\ []) do
    request(:get, url, headers, body, opts)
  end

  @doc """
  Makes a POST request to the given URL.
  """
  @spec post(url(), headers(), body(), adapter_opts()) :: response()
  def post(url, headers \\ nil, body \\ nil, opts \\ []) do
    request(:post, url, headers, body, opts)
  end

  @doc """
  Makes a PUT request to the given URL.
  """
  @spec put(url(), headers(), body(), adapter_opts()) :: response()
  def put(url, headers \\ nil, body \\ nil, opts \\ []) do
    request(:put, url, headers, body, opts)
  end

  @doc """
  Makes a PATCH request to the given URL.
  """
  @spec patch(url(), headers(), body(), adapter_opts()) :: response()
  def patch(url, headers \\ nil, body \\ nil, opts \\ []) do
    request(:patch, url, headers, body, opts)
  end

  @doc """
  Makes a DELETE request to the given URL.
  """
  @spec delete(url(), headers(), body(), adapter_opts()) :: response()
  def delete(url, headers \\ nil, body \\ nil, opts \\ []) do
    request(:delete, url, headers, body, opts)
  end

  @doc false
  @spec adapter() :: module()
  def adapter do
    Application.get_env(:any_http, :client_adapter) || raise("Missing :client_adapter config")
  end

  ## Private functions

  @spec parse_url!(URI.t()) :: binary() | no_return()
  defp parse_url!(%URI{} = uri) do
    uri |> validate_scheme!() |> URI.to_string()
  end

  @spec parse_url!(binary()) :: binary() | no_return()
  defp parse_url!(url) when is_binary(url) do
    url |> URI.parse() |> parse_url!()
  end

  @spec validate_scheme!(URI.t()) :: URI.t() | no_return()
  defp validate_scheme!(%URI{} = uri) do
    case uri.scheme do
      nil ->
        raise ArgumentError, "scheme is required for url: #{URI.to_string(uri)}"

      scheme when scheme in @default_schemes ->
        uri

      scheme ->
        raise ArgumentError, "invalid scheme \"#{scheme}\" for url: #{URI.to_string(uri)}"
    end
  end
end
