defmodule AnyHttp do
  @moduledoc """
  Provides an interface which dispatches the function to the right adapter.

  ## Configuration

  Defines in your application the following configuration depending of the adapter you choose:

      config :any_http, :client_adapter, AnyHttp.Adapters.Req
  """

  @behaviour AnyHttp.Client

  @impl true
  def head(url, headers, opts \\ []), do: adapter().head(url, headers, opts)

  @impl true
  def get(url, headers, body \\ nil, opts \\ []), do: adapter().get(url, headers, body, opts)

  @impl true
  def post(url, headers, body \\ nil, opts \\ []), do: adapter().post(url, headers, body, opts)

  @impl true
  def put(url, headers, body \\ nil, opts \\ []), do: adapter().put(url, headers, body, opts)

  @impl true
  def patch(url, headers, body \\ nil, opts \\ []), do: adapter().patch(url, headers, body, opts)

  @impl true
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
