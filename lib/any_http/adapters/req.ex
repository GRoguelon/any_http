if Code.ensure_loaded?(Req) do
  defmodule AnyHttp.Adapters.Req do
    @moduledoc """
    Defines the adapter for the `req` library.
    """

    alias AnyHttp, as: T
    alias AnyHttp.Error
    alias AnyHttp.Response

    ## Behaviours

    @behaviour AnyHttp.Client

    ## Typespec

    @type request :: Req.Request.t()

    ## Module attributes

    @default_opts [decode_body: false]

    ## Public functions

    @impl true
    @spec request(T.method(), T.url(), T.headers(), T.body(), T.adapter_opts()) :: T.response()
    def request(method, url, headers, body, adapter_opts \\ []) do
      adapter_opts = Keyword.merge(@default_opts, adapter_opts)

      Req.new(method: method, url: url)
      |> add_req_headers(headers)
      |> add_req_body(body, method)
      |> add_req_opts(adapter_opts)
      |> Req.request()
      |> parse_result()
    end

    ## Private functions

    @spec add_req_headers(request(), T.headers()) :: request()
    defp add_req_headers(req, headers) when not is_nil(headers) do
      Req.update(req, headers: headers)
    end

    defp add_req_headers(req, _headers), do: req

    @spec add_req_body(request(), T.body(), T.method()) :: request()
    defp add_req_body(req, body, method) when not is_nil(body) and method != :head do
      Req.update(req, body: body)
    end

    defp add_req_body(req, _body, _method), do: req

    @spec add_req_opts(request(), T.adapter_opts()) :: request()
    defp add_req_opts(req, opts) do
      if Keyword.keyword?(opts) do
        Req.Request.merge_options(req, opts)
      else
        req
      end
    end

    @spec parse_result({:ok, Req.Response.t()}) :: {:ok, Response.t()}
    defp parse_result({:ok, %Req.Response{status: status, headers: headers, body: body}}) do
      {:ok,
       %Response{
         status: status,
         headers: headers,
         body: parse_body(body)
       }}
    end

    @spec parse_result({:error, Exception.t()}) :: {:error, Error.t()}
    defp parse_result({:error, %Mint.TransportError{reason: :closed} = exception}) do
      {:error,
       %Error{
         type: :socket_closed,
         message: Exception.message(exception),
         original: exception
       }}
    end

    defp parse_result({:error, %Mint.TransportError{reason: :nxdomain} = exception}) do
      {:error,
       %Error{
         type: :nxdomain,
         message: Exception.message(exception),
         original: exception
       }}
    end

    defp parse_result(
           {:error,
            %Mint.TransportError{reason: {:tls_alert, {:unknown_ca, message}}} = exception}
         ) do
      {:error,
       %Error{
         type: :unknown_ca,
         message: List.to_string(message),
         original: exception
       }}
    end

    defp parse_result({:error, unknown_error}) do
      {:error, Error.exception({:unknown_error, "unknown error", unknown_error})}
    end

    @spec parse_body(any()) :: any()
    defp parse_body(body) when is_binary(body) and body == "", do: nil
    defp parse_body(body), do: body
  end
end
