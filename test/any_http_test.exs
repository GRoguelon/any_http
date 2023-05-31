defmodule AnyHttpTest do
  use ExUnit.Case
  doctest AnyHttp

  test "greets the world" do
    assert AnyHttp.hello() == :world
  end
end
