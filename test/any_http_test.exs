defmodule AnyHttpTest do
  use ExUnit.Case, async: true

  describe "HTTP functions" do
    test "exposes a function request/4" do
      function_exported?(AnyHttp, :head, 4)
    end

    test "exposes a function request/5" do
      function_exported?(AnyHttp, :head, 5)
    end

    test "exposes a function head/2" do
      function_exported?(AnyHttp, :head, 2)
    end

    test "exposes a function head/3" do
      function_exported?(AnyHttp, :head, 3)
    end

    test "exposes a function get/3" do
      function_exported?(AnyHttp, :get, 3)
    end

    test "exposes a function get/4" do
      function_exported?(AnyHttp, :get, 4)
    end

    test "exposes a function post/3" do
      function_exported?(AnyHttp, :post, 3)
    end

    test "exposes a function post/4" do
      function_exported?(AnyHttp, :post, 4)
    end

    test "exposes a function put/3" do
      function_exported?(AnyHttp, :put, 3)
    end

    test "exposes a function put/4" do
      function_exported?(AnyHttp, :put, 4)
    end

    test "exposes a function patch/3" do
      function_exported?(AnyHttp, :patch, 3)
    end

    test "exposes a function patch/4" do
      function_exported?(AnyHttp, :patch, 4)
    end

    test "exposes a function delete/3" do
      function_exported?(AnyHttp, :delete, 3)
    end

    test "exposes a function delete/4" do
      function_exported?(AnyHttp, :delete, 4)
    end
  end
end
