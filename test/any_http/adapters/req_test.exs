defmodule AnyHttp.Adapters.ReqTest do
  use AnyHttp.ConnCase

  alias AnyHttp.Adapters.Req, as: Subject
  alias AnyHttp.Response

  @value :crypto.strong_rand_bytes(16) |> Base.url_encode64(padding: false)

  describe "with url as string" do
    test "head/2 returns 243 status" do
      url = test_server_add(:head, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: _headers, body: nil}} = Subject.head(url, nil)
    end

    test "get/2 returns 243 status" do
      url = test_server_add(:get, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: _headers, body: ""}} =
               Subject.get(url, nil, nil)
    end

    test "get/2 with body returns 243 status" do
      url = test_server_add(:get, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: _headers, body: @value}} =
               Subject.get(url, nil, @value)
    end

    test "post/2 with body returns 243 status" do
      url = test_server_add(:post, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: _headers, body: @value}} =
               Subject.post(url, nil, @value)
    end

    test "put/2 with body returns 243 status" do
      url = test_server_add(:put, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: _headers, body: @value}} =
               Subject.put(url, nil, @value)
    end

    test "patch/2 with body returns 243 status" do
      url = test_server_add(:patch, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: _headers, body: @value}} =
               Subject.patch(url, nil, @value)
    end

    test "delete/2 with body returns 243 status" do
      url = test_server_add(:delete, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: _headers, body: @value}} =
               Subject.delete(url, nil, @value)
    end
  end

  describe "with url as URI" do
    test "head/2 returns 243 status" do
      url = test_server_add(:head, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: _headers, body: nil}} =
               Subject.head(URI.new!(url), nil)
    end

    test "get/2 returns 243 status" do
      url = test_server_add(:get, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: _headers, body: ""}} =
               Subject.get(URI.new!(url), nil, nil)
    end

    test "get/2 with body returns 243 status" do
      url = test_server_add(:get, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: _headers, body: @value}} =
               Subject.get(URI.new!(url), nil, @value)
    end

    test "post/2 with body returns 243 status" do
      url = test_server_add(:post, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: _headers, body: @value}} =
               Subject.post(URI.new!(url), nil, @value)
    end

    test "put/2 with body returns 243 status" do
      url = test_server_add(:put, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: _headers, body: @value}} =
               Subject.put(URI.new!(url), nil, @value)
    end

    test "patch/2 with body returns 243 status" do
      url = test_server_add(:patch, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: _headers, body: @value}} =
               Subject.patch(URI.new!(url), nil, @value)
    end

    test "delete/2 with body returns 243 status" do
      url = test_server_add(:delete, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: _headers, body: @value}} =
               Subject.delete(URI.new!(url), nil, @value)
    end
  end

  @headers %{"my-custom-req" => @value}

  describe "with headers as map" do
    test "head/2 returns 243 status" do
      url = test_server_add(:head, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: nil}} =
               Subject.head(url, @headers)

      assert get_header(headers, "content-length") == ["0"]
      assert get_header(headers, "my-custom-resp") == [@value]
    end

    test "get/2 returns 243 status" do
      url = test_server_add(:get, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: ""}} =
               Subject.get(url, @headers)

      assert get_header(headers, "content-length") == ["0"]
      assert get_header(headers, "my-custom-resp") == [@value]
    end

    test "get/2 with body returns 243 status" do
      url = test_server_add(:get, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.get(url, @headers, @value)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "my-custom-resp") == [@value]
    end

    test "post/2 with body returns 243 status" do
      url = test_server_add(:post, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.post(url, @headers, @value)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "my-custom-resp") == [@value]
    end

    test "put/2 with body returns 243 status" do
      url = test_server_add(:put, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.put(url, @headers, @value)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "my-custom-resp") == [@value]
    end

    test "patch/2 with body returns 243 status" do
      url = test_server_add(:patch, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.patch(url, @headers, @value)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "my-custom-resp") == [@value]
    end

    test "delete/2 with body returns 243 status" do
      url = test_server_add(:delete, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.delete(url, @headers, @value)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "my-custom-resp") == [@value]
    end
  end

  @headers [{"my-custom-req", @value}]

  describe "with headers as list" do
    test "head/2 returns 243 status" do
      url = test_server_add(:head, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: nil}} =
               Subject.head(url, @headers)

      assert get_header(headers, "content-length") == ["0"]
      assert get_header(headers, "my-custom-resp") == [@value]
    end

    test "get/2 returns 243 status" do
      url = test_server_add(:get, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: ""}} =
               Subject.get(url, @headers)

      assert get_header(headers, "content-length") == ["0"]
      assert get_header(headers, "my-custom-resp") == [@value]
    end

    test "get/2 with body returns 243 status" do
      url = test_server_add(:get, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.get(url, @headers, @value)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "my-custom-resp") == [@value]
    end

    test "post/2 with body returns 243 status" do
      url = test_server_add(:post, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.post(url, @headers, @value)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "my-custom-resp") == [@value]
    end

    test "put/2 with body returns 243 status" do
      url = test_server_add(:put, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.put(url, @headers, @value)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "my-custom-resp") == [@value]
    end

    test "patch/2 with body returns 243 status" do
      url = test_server_add(:patch, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.patch(url, @headers, @value)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "my-custom-resp") == [@value]
    end

    test "delete/2 with body returns 243 status" do
      url = test_server_add(:delete, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.delete(url, @headers, @value)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "my-custom-resp") == [@value]
    end
  end

  @req_opts [compressed: true, raw: true]

  describe "with req options" do
    test "head/2 returns 243 status" do
      url = test_server_add(:head, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: nil}} =
               Subject.head(url, nil, @req_opts)

      assert get_header(headers, "content-length") == ["0"]
      assert get_header(headers, "content-encoding") == ["gzip"]
    end

    test "get/2 returns 243 status" do
      url = test_server_add(:get, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: ""}} =
               Subject.get(url, nil, @value, @req_opts)

      assert get_header(headers, "content-length") == ["0"]
      assert get_header(headers, "content-encoding") == ["gzip"]
    end

    test "get/2 with body returns 243 status" do
      url = test_server_add(:get, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.get(url, nil, @value, @req_opts)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "content-encoding") == ["gzip"]
    end

    test "post/2 with body returns 243 status" do
      url = test_server_add(:post, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.post(url, nil, @value, @req_opts)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "content-encoding") == ["gzip"]
    end

    test "put/2 with body returns 243 status" do
      url = test_server_add(:put, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.put(url, nil, @value, @req_opts)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "content-encoding") == ["gzip"]
    end

    test "patch/2 with body returns 243 status" do
      url = test_server_add(:patch, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.patch(url, nil, @value, @req_opts)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "content-encoding") == ["gzip"]
    end

    test "delete/2 with body returns 243 status" do
      url = test_server_add(:delete, &http_handler/1)

      assert {:ok, %Response{status: 243, headers: headers, body: @value}} =
               Subject.delete(url, nil, @value, @req_opts)

      assert get_header(headers, "content-length") == ["22"]
      assert get_header(headers, "content-encoding") == ["gzip"]
    end
  end

  ## Private functions

  def http_handler(conn) do
    {:ok, body, conn} = Plug.Conn.read_body(conn)

    conn
    |> Plug.Conn.get_req_header("my-custom-req")
    |> case do
      [value] ->
        Plug.Conn.put_resp_header(conn, "my-custom-resp", value)

      [] ->
        conn
    end
    |> Plug.Conn.get_req_header("accept-encoding")
    |> case do
      ["gzip, deflate"] ->
        if is_binary(body) and body != "" do
          conn
          |> Plug.Conn.put_resp_header("content-encoding", "gzip")
          |> Plug.Conn.send_resp(243, to_string(for <<c::8 <- :zlib.gzip(body)>>, do: c))
        else
          Plug.Conn.send_resp(conn, 243, "")
        end

      [] ->
        Plug.Conn.send_resp(conn, 243, body)
    end
  end
end
