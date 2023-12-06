defmodule AnyHttp.Adapters.ReqTest do
  use AnyHttp.ConnCase

  alias AnyHttp.Adapters.Req, as: Subject
  alias AnyHttp.Response

  @value :crypto.strong_rand_bytes(16) |> Base.url_encode64(padding: false)
end
