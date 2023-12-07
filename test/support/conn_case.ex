defmodule AnyHttp.ConnCase do
  @moduledoc """
  Provides a base to test the HTTP adapters
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      import AnyHttp.ConnCase
    end
  end

  setup do
    bypass = Bypass.open()

    {:ok, bypass: bypass, url: "http://localhost:#{bypass.port}"}
  end

  ## Helper functions

  def get_header(headers, key) do
    headers
    |> Stream.filter(fn {header_key, _value} -> header_key == key end)
    |> Enum.map(&elem(&1, 1))
  end
end
