defmodule AnyHttp.Adapters.HttpcTest do
  use AnyHttp.ConnCase

  alias AnyHttp.Adapters.Httpc, as: HttpcAdapter
  alias AnyHttp.Response

  @req_body "Hello World!"
  @resp_body "Bye World!"

  @headers %{"content-type" => "text/plain;charset=UTF-8"}

  setup_all do
    Application.put_env(:any_http, :client_adapter, HttpcAdapter)
  end

  test "ensures that the adapter is AnyHttp.Adapters.Httpc" do
    assert AnyHttp.adapter() == HttpcAdapter
  end

  describe "request/5" do
    test "with method HEAD and no adapter options returns a Response", %{bypass: bypass, url: url} do
      Bypass.expect_once(bypass, "HEAD", "/hello_world", &Plug.Conn.resp(&1, 200, ""))

      assert {:ok, response} = HttpcAdapter.request(:head, url <> "/hello_world", nil, nil)
      assert %Response{status: 200, body: nil} = response
      assert Map.fetch!(response.headers, "server") == ["Cowboy"]
    end

    test "with method GET and a body raises an ArgumentError exception", %{url: url} do
      msg = "the Erlang :httpc library doesn't allow to send a body with the method get"

      assert_raise(ArgumentError, msg, fn ->
        HttpcAdapter.request(:get, url <> "/hello_world", @headers, @req_body)
      end)
    end

    test "with method GET and no adapter options returns a Response", %{bypass: bypass, url: url} do
      Bypass.expect_once(bypass, "GET", "/hello_world", fn conn ->
        Plug.Conn.resp(conn, 200, @resp_body)
      end)

      assert {:ok, response} = HttpcAdapter.request(:get, url <> "/hello_world", nil, nil)
      assert %Response{status: 200, body: @resp_body} = response
      assert Map.fetch!(response.headers, "server") == ["Cowboy"]
    end

    test "with method POST and no adapter options returns a Response", %{bypass: bypass, url: url} do
      Bypass.expect_once(bypass, "POST", "/hello_world", fn conn ->
        {:ok, @req_body, %Plug.Conn{}} = Plug.Conn.read_body(conn)

        Plug.Conn.resp(conn, 201, @resp_body)
      end)

      assert {:ok, response} =
               HttpcAdapter.request(:post, url <> "/hello_world", @headers, @req_body)

      assert %Response{status: 201, body: @resp_body} = response
      assert Map.fetch!(response.headers, "server") == ["Cowboy"]
    end

    test "with method PUT and no adapter options returns a Response", %{bypass: bypass, url: url} do
      Bypass.expect_once(bypass, "PUT", "/hello_world", fn conn ->
        {:ok, @req_body, %Plug.Conn{}} = Plug.Conn.read_body(conn)

        Plug.Conn.resp(conn, 200, @resp_body)
      end)

      assert {:ok, response} =
               HttpcAdapter.request(:put, url <> "/hello_world", @headers, @req_body)

      assert %Response{status: 200, body: @resp_body} = response
      assert Map.fetch!(response.headers, "server") == ["Cowboy"]
    end

    test "with method PATCH and no adapter options returns a Response", %{
      bypass: bypass,
      url: url
    } do
      Bypass.expect_once(bypass, "PATCH", "/hello_world", fn conn ->
        {:ok, @req_body, %Plug.Conn{}} = Plug.Conn.read_body(conn)

        Plug.Conn.resp(conn, 200, @resp_body)
      end)

      assert {:ok, response} =
               HttpcAdapter.request(:patch, url <> "/hello_world", @headers, @req_body)

      assert %Response{status: 200, body: @resp_body} = response
      assert Map.fetch!(response.headers, "server") == ["Cowboy"]
    end
  end

  test "with method DELETE and no adapter options returns a Response", %{bypass: bypass, url: url} do
    Bypass.expect_once(bypass, "DELETE", "/hello_world", fn conn ->
      {:ok, @req_body, %Plug.Conn{}} = Plug.Conn.read_body(conn)

      Plug.Conn.resp(conn, 200, @resp_body)
    end)

    assert {:ok, response} =
             HttpcAdapter.request(:delete, url <> "/hello_world", @headers, @req_body)

    assert %Response{status: 200, body: @resp_body} = response
    assert Map.fetch!(response.headers, "server") == ["Cowboy"]
  end
end
