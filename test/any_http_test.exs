defmodule AnyHttpTest do
  use ExUnit.Case, async: true

  alias AnyHttp, as: Subject

  test "implements the AnyHttp.Client behaviour" do
    assert AnyHttp.Client in Keyword.get(Subject.__info__(:attributes), :behaviour, [])
  end

  test "exposes a function head/2" do
    function_exported?(Subject, :head, 2)
  end

  test "exposes a function head/3" do
    function_exported?(Subject, :head, 3)
  end

  test "exposes a function get/3" do
    function_exported?(Subject, :get, 3)
  end

  test "exposes a function get/4" do
    function_exported?(Subject, :get, 4)
  end

  test "exposes a function post/3" do
    function_exported?(Subject, :post, 3)
  end

  test "exposes a function post/4" do
    function_exported?(Subject, :post, 4)
  end

  test "exposes a function put/3" do
    function_exported?(Subject, :put, 3)
  end

  test "exposes a function put/4" do
    function_exported?(Subject, :put, 4)
  end

  test "exposes a function patch/3" do
    function_exported?(Subject, :patch, 3)
  end

  test "exposes a function patch/4" do
    function_exported?(Subject, :patch, 4)
  end

  test "exposes a function delete/3" do
    function_exported?(Subject, :delete, 3)
  end

  test "exposes a function delete/4" do
    function_exported?(Subject, :delete, 4)
  end
end
