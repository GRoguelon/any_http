defmodule AnyHttp do
  @moduledoc """
  Provides an interface which dispatches the function to the right adapter.

  ## Configuration

  Defines in your application the following configuration depending of the adapter you choose:

      config :any_http, :client_adapter, AnyHttp.Adapters.Req
  """

  ## Typespecs

  @type url :: AnyHttp.Types.url()

  @type headers :: AnyHttp.Types.headers()

  @type body :: AnyHttp.Types.body()

  @type response :: AnyHttp.Types.response()

  @type opts :: AnyHttp.Types.opts()

  ## Behaviours

  @behaviour AnyHttp.Client

  ## Public functions

  @doc """
  Makes a HEAD request to the given URL.
  """
  @impl true
  @spec head(url(), headers(), opts()) :: {:ok, response()} | {:error, term()}
  def head(url, headers, opts \\ []), do: adapter().head(url, headers, opts)

  @doc """
  Makes a GET request to the given URL.
  """
  @impl true
  @spec get(url(), headers(), body(), opts()) :: {:ok, response()} | {:error, term()}
  def get(url, headers, body \\ nil, opts \\ []), do: adapter().get(url, headers, body, opts)

  @doc """
  Makes a POST request to the given URL.
  """
  @impl true
  @spec post(url(), headers(), body(), opts()) :: {:ok, response()} | {:error, term()}
  def post(url, headers, body \\ nil, opts \\ []), do: adapter().post(url, headers, body, opts)

  @doc """
  Makes a PUT request to the given URL.
  """
  @impl true
  @spec put(url(), headers(), body(), opts()) :: {:ok, response()} | {:error, term()}
  def put(url, headers, body \\ nil, opts \\ []), do: adapter().put(url, headers, body, opts)

  @doc """
  Makes a PATCH request to the given URL.
  """
  @impl true
  @spec patch(url(), headers(), body(), opts()) :: {:ok, response()} | {:error, term()}
  def patch(url, headers, body \\ nil, opts \\ []), do: adapter().patch(url, headers, body, opts)

  @doc """
  Makes a DELETE request to the given URL.
  """
  @impl true
  @spec delete(url(), headers(), body(), opts()) :: {:ok, response()} | {:error, term()}
  def delete(url, headers, body \\ nil, opts \\ []),
    do: adapter().delete(url, headers, body, opts)

  # Defines the adapter function which can checked at compilation time.
  if Application.compile_env(:any_http, :compiled_adapter, false) do
    @adapter Application.compile_env(:any_http, :client_adapter)

    if is_nil(@adapter) do
      raise("Please set the `:client_adapter` configuration option in your `config.exs` file.")
    end

    @doc false
    @spec adapter() :: module()
    def adapter, do: @adapter
  else
    @doc false
    @spec adapter() :: module()
    def adapter, do: Application.get_env(:any_http, :client_adapter, AnyHttp.Req)
  end
end
