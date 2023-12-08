defmodule AnyHttpTest do
  use ExUnit.Case, async: true

  @date ~N[2023-12-07 18:06:28.313171]
  @date_as_str "Thu, 07 Dec 2023 18:06:28 GMT"
  @date_as_char ~c"Thu, 07 Dec 2023 18:06:28 GMT"

  describe "to_rfc1123_date/2" do
    test "returns a valid RFC1123 date as charlist" do
      assert AnyHttp.to_rfc1123_date(@date, :charlist) == @date_as_char
    end

    test "returns a valid RFC1123 date as binary" do
      assert AnyHttp.to_rfc1123_date(@date, :binary) == @date_as_str
    end
  end

  describe "from_rfc1123_date!/1" do
    test "returns a valid RFC1123 date as charlist" do
      naive_datetime = AnyHttp.from_rfc1123_date!(@date_as_char)

      assert @date |> NaiveDateTime.truncate(:second) |> NaiveDateTime.compare(naive_datetime) ==
               :eq
    end
  end

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
