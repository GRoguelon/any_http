defmodule AnyHttp.Adapters.HackneyTest do
  use AnyHttp.ConnCase

  alias AnyHttp.Adapters.Hackney, as: HackneyAdapter
  alias AnyHttp.Response

  @req_body "Hello World!"
  @resp_body "Bye World!"

  setup_all do
    Application.put_env(:any_http, :client_adapter, HackneyAdapter)
  end

  test "ensures that the adapter is AnyHttp.Adapters.Hackney" do
    assert AnyHttp.adapter() == HackneyAdapter
  end

  describe "request/5" do
    test "with method HEAD and no adapter options returns a Response", %{bypass: bypass, url: url} do
      Bypass.expect_once(bypass, "HEAD", "/hello_world", &Plug.Conn.resp(&1, 200, ""))

      assert {:ok, response} = HackneyAdapter.request(:head, url <> "/hello_world", nil, nil)
      assert %Response{status: 200, body: nil} = response
      assert Map.fetch!(response.headers, "server") == ["Cowboy"]
    end

    test "with method GET and no adapter options returns a Response", %{bypass: bypass, url: url} do
      Bypass.expect_once(bypass, "GET", "/hello_world", fn conn ->
        {:ok, @req_body, %Plug.Conn{}} = Plug.Conn.read_body(conn)

        Plug.Conn.resp(conn, 200, @resp_body)
      end)

      assert {:ok, response} = HackneyAdapter.request(:get, url <> "/hello_world", nil, @req_body)
      assert %Response{status: 200, body: @resp_body} = response
      assert Map.fetch!(response.headers, "server") == ["Cowboy"]
    end

    test "with method POST and no adapter options returns a Response", %{bypass: bypass, url: url} do
      Bypass.expect_once(bypass, "POST", "/hello_world", fn conn ->
        {:ok, @req_body, %Plug.Conn{}} = Plug.Conn.read_body(conn)

        Plug.Conn.resp(conn, 201, @resp_body)
      end)

      assert {:ok, response} =
               HackneyAdapter.request(:post, url <> "/hello_world", nil, @req_body)

      assert %Response{status: 201, body: @resp_body} = response
      assert Map.fetch!(response.headers, "server") == ["Cowboy"]
    end

    test "with method PUT and no adapter options returns a Response", %{bypass: bypass, url: url} do
      Bypass.expect_once(bypass, "PUT", "/hello_world", fn conn ->
        {:ok, @req_body, %Plug.Conn{}} = Plug.Conn.read_body(conn)

        Plug.Conn.resp(conn, 200, @resp_body)
      end)

      assert {:ok, response} = HackneyAdapter.request(:put, url <> "/hello_world", nil, @req_body)
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
               HackneyAdapter.request(:patch, url <> "/hello_world", nil, @req_body)

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
             HackneyAdapter.request(:delete, url <> "/hello_world", nil, @req_body)

    assert %Response{status: 200, body: @resp_body} = response
    assert Map.fetch!(response.headers, "server") == ["Cowboy"]
  end
end
