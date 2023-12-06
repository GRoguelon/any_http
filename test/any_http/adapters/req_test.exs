defmodule AnyHttp.Adapters.ReqTest do
  use AnyHttp.ConnCase

  alias AnyHttp.Adapters.Req, as: Subject
  alias AnyHttp.Response

  @req_body "Hello World!"
  @resp_body "Bye World!"

  describe "request/5" do
    test "with method HEAD and no adapter options returns a Response", %{bypass: bypass, url: url} do
      Bypass.expect_once(bypass, "HEAD", "/hello_world", &Plug.Conn.resp(&1, 200, ""))

      assert %Response{status: 200, body: nil} =
               Subject.request(:head, url <> "/hello_world", nil, nil)
    end

    test "with method GET and no adapter options returns a Response", %{bypass: bypass, url: url} do
      Bypass.expect_once(bypass, "GET", "/hello_world", fn conn ->
        {:ok, @req_body, %Plug.Conn{}} = Plug.Conn.read_body(conn)

        Plug.Conn.resp(conn, 200, @resp_body)
      end)

      assert %Response{status: 200, body: @resp_body} =
               Subject.request(:get, url <> "/hello_world", nil, @req_body)
    end

    test "with method POST and no adapter options returns a Response", %{bypass: bypass, url: url} do
      Bypass.expect_once(bypass, "POST", "/hello_world", fn conn ->
        {:ok, @req_body, %Plug.Conn{}} = Plug.Conn.read_body(conn)

        Plug.Conn.resp(conn, 201, @resp_body)
      end)

      assert %Response{status: 201, body: @resp_body} =
               Subject.request(:post, url <> "/hello_world", nil, @req_body)
    end

    test "with method PUT and no adapter options returns a Response", %{bypass: bypass, url: url} do
      Bypass.expect_once(bypass, "PUT", "/hello_world", fn conn ->
        {:ok, @req_body, %Plug.Conn{}} = Plug.Conn.read_body(conn)

        Plug.Conn.resp(conn, 200, @resp_body)
      end)

      assert %Response{status: 200, body: @resp_body} =
               Subject.request(:put, url <> "/hello_world", nil, @req_body)
    end

    test "with method PATCH and no adapter options returns a Response", %{
      bypass: bypass,
      url: url
    } do
      Bypass.expect_once(bypass, "PATCH", "/hello_world", fn conn ->
        {:ok, @req_body, %Plug.Conn{}} = Plug.Conn.read_body(conn)

        Plug.Conn.resp(conn, 200, @resp_body)
      end)

      assert %Response{status: 200, body: @resp_body} =
               Subject.request(:patch, url <> "/hello_world", nil, @req_body)
    end
  end

  test "with method DELETE and no adapter options returns a Response", %{bypass: bypass, url: url} do
    Bypass.expect_once(bypass, "DELETE", "/hello_world", fn conn ->
      {:ok, @req_body, %Plug.Conn{}} = Plug.Conn.read_body(conn)

      Plug.Conn.resp(conn, 200, @resp_body)
    end)

    assert %Response{status: 200, body: @resp_body} =
             Subject.request(:delete, url <> "/hello_world", nil, @req_body)
  end
end
