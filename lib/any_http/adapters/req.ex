if Code.ensure_loaded?(Req) do
  defmodule AnyHttp.Adapters.Req do
    @moduledoc """
    Defines the adapter for the `req` library.
    """

    alias AnyHttp, as: T
    alias AnyHttp.Response

    ## Behaviours

    @behaviour AnyHttp.Client

    ## Public functions

    @impl true
    @spec request(T.method(), T.url(), T.headers(), T.body(), T.adapter_opts()) :: Response.t()
    def request(method, url, headers, body, client_opts \\ []) do
      Req.new(method: method, url: url)
      |> add_req_headers(headers)
      |> add_req_body(body, method)
      |> add_req_opts(client_opts)
      |> Req.request!()
      |> parse_result()
    end

    ## Private functions

    @spec add_req_headers(req, headers) :: req when req: Req.Request.t(), headers: T.headers()
    defp add_req_headers(%Req.Request{} = req, headers) when is_list(headers) and headers != [] do
      Req.Request.merge_options(req, headers: headers)
    end

    defp add_req_headers(%Req.Request{} = req, _headers), do: req

    @spec add_req_body(req, body, method) :: req
          when req: Req.Request.t(), body: T.body(), method: T.method()
    defp add_req_body(%Req.Request{} = req, body, method)
         when not is_nil(body) and method != :head do
      Req.Request.merge_options(req, body: body)
    end

    defp add_req_body(%Req.Request{} = req, _body, _method), do: req

    @spec add_req_opts(req, adapter_opts) :: req
          when req: Req.Request.t(), adapter_opts: T.adapter_opts()
    defp add_req_opts(%Req.Request{} = req, opts) do
      if Keyword.keyword?(opts) and opts != [] do
        Req.Request.merge_options(req, opts)
      else
        req
      end
    end

    @spec parse_result(Req.Response.t()) :: Response.t()
    defp parse_result(%Req.Response{} = response) do
      %Response{status: response.status, headers: response.headers, body: response.body}
    end
  end
end
