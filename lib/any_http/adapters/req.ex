if Code.ensure_loaded?(Req) do
  defmodule AnyHttp.Adapters.Req do
    @moduledoc """
    Defines the adapter for the `req` library.
    """

    alias AnyHttp.Response

    ## Typespecs

    @type url :: AnyHttp.Types.url()

    @type headers :: AnyHttp.Types.headers()

    @type body :: AnyHttp.Types.body()

    @type response :: AnyHttp.Types.response()

    @type req_opts :: keyword()

    ## Behaviours

    @behaviour AnyHttp.Client

    ## Public functions

    @impl true
    @spec head(url(), headers(), req_opts()) :: {:ok, response()} | {:error, term()}
    def head(url, headers, opts \\ []) do
      req_opts = do_req_opts(url, headers, nil, opts)
      result = Req.head(url, req_opts)

      parse_result(result)
    end

    @impl true
    @spec get(url(), headers(), body(), req_opts()) :: {:ok, response()} | {:error, term()}
    def get(url, headers, body \\ nil, opts \\ []) do
      req_opts = do_req_opts(url, headers, body, opts)
      result = Req.get(url, req_opts)

      parse_result(result)
    end

    @impl true
    @spec post(url(), headers(), body(), req_opts()) :: {:ok, response()} | {:error, term()}
    def post(url, headers, body, opts \\ []) do
      req_opts = do_req_opts(url, headers, body, opts)
      result = Req.post(url, req_opts)

      parse_result(result)
    end

    @impl true
    @spec put(url(), headers(), body(), req_opts()) :: {:ok, response()} | {:error, term()}
    def put(url, headers, body, opts \\ []) do
      req_opts = do_req_opts(url, headers, body, opts)
      result = Req.put(url, req_opts)

      parse_result(result)
    end

    @impl true
    @spec patch(url(), headers(), body(), req_opts()) :: {:ok, response()} | {:error, term()}
    def patch(url, headers, body, opts \\ []) do
      req_opts = do_req_opts(url, headers, body, opts)
      result = Req.patch(url, req_opts)

      parse_result(result)
    end

    @impl true
    @spec delete(url(), headers(), body(), req_opts()) :: {:ok, response()} | {:error, term()}
    def delete(url, headers, body \\ nil, opts \\ []) do
      req_opts = do_req_opts(url, headers, body, opts)
      result = Req.delete(url, req_opts)

      parse_result(result)
    end

    ## Private functions

    @spec parse_result({:ok, Req.Response.t()} | {:error, Exception.t()}) :: {:ok, response()}
    defp parse_result({:ok, %Req.Response{} = response}) do
      {:ok, %Response{status: response.status, headers: response.headers, body: response.body}}
    end

    @spec do_req_opts(url(), headers(), body(), req_opts()) :: req_opts()
    defp do_req_opts(_url, headers, body, opts) do
      opts |> filter_req_opts() |> process_headers(headers) |> process_body(body)
    end

    @allow_list ~w[connect_options compressed decode_body pool_timeout receive_timeout]a

    @spec filter_req_opts(any()) :: req_opts()
    defp filter_req_opts(opts) when is_list(opts) do
      Keyword.take(opts, @allow_list)
    end

    defp filter_req_opts(_opts) do
      []
    end

    @spec process_headers(req_opts(), nil | headers()) :: req_opts()
    defp process_headers(opts, headers) when is_list(headers) and headers != [] do
      [{:headers, headers} | opts]
    end

    defp process_headers(opts, _headers) do
      opts
    end

    @spec process_body(req_opts(), body()) :: req_opts()
    defp process_body(opts, body) when not is_nil(body) do
      [{:body, body} | opts]
    end

    defp process_body(opts, _body) do
      opts
    end
  end
end
