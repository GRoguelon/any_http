defmodule AnyHttp.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import AnyHttp.ConnCase
    end
  end

  setup _tags do
    # pid = Ecto.Adapters.SQL.Sandbox.start_owner!(ExApi.Repo, shared: not tags[:async])
    # on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)
    # {:ok, conn: Phoenix.ConnTest.build_conn()}
    :ok
  end

  ## Helper functions

  def test_server_add(method, path \\ "/", handler) do
    TestServer.add(path, via: method, to: handler)

    TestServer.url()
  end

  def get_header(headers, key) do
    headers
    |> Stream.filter(fn {header_key, _value} -> header_key == key end)
    |> Enum.map(&elem(&1, 1))
  end
end
