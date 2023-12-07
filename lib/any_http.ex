defmodule AnyHttp do
  @moduledoc """
  Provides an interface which dispatches the function to the right adapter.

  ## Configuration

  Defines in your application the following configuration depending of the adapter you choose:

      config :any_http, :client_adapter, AnyHttp.Adapters.Req
  """

  alias AnyHttp.Response

  ## Typespecs

  @type method :: :head | :get | :post | :put | :patch | :delete

  @type url :: URI.t() | binary()

  if System.version() |> Version.parse!() |> then(&(&1.major >= 1 and &1.minor < 14)) do
    @type headers :: nil | Enumerable.t()
  else
    @type headers :: nil | Enumerable.t({binary(), binary() | [binary()]})
  end

  @type body :: nil | binary()

  @type adapter_opts :: Keyword.t()

  @type response :: {:ok, Response.t()} | {:error, Exception.t()}

  ## Public functions

  @spec request(method(), url(), headers(), body(), adapter_opts()) :: response()
  def request(method, url, headers, body, adapter_opts \\ [])

  def request(method, %URI{} = uri, headers, body, adapter_opts) do
    request(method, URI.to_string(uri), headers, body, adapter_opts)
  end

  def request(method, url, headers, body, adapter_opts) do
    headers = headers && Enum.to_list(headers)

    adapter().request(method, url, headers, body, adapter_opts)
  end

  @doc """
  Makes a HEAD request to the given URL.
  """
  @spec head(url(), headers(), adapter_opts()) :: response()
  def head(url, headers \\ nil, opts \\ []) do
    request(:head, url, headers, nil, opts)
  end

  @doc """
  Makes a GET request to the given URL.
  """
  @spec get(url(), headers(), body(), adapter_opts()) :: response()
  def get(url, headers \\ nil, body \\ nil, opts \\ []) do
    request(:get, url, headers, body, opts)
  end

  @doc """
  Makes a POST request to the given URL.
  """
  @spec post(url(), headers(), body(), adapter_opts()) :: response()
  def post(url, headers \\ nil, body \\ nil, opts \\ []) do
    request(:post, url, headers, body, opts)
  end

  @doc """
  Makes a PUT request to the given URL.
  """
  @spec put(url(), headers(), body(), adapter_opts()) :: response()
  def put(url, headers \\ nil, body \\ nil, opts \\ []) do
    request(:put, url, headers, body, opts)
  end

  @doc """
  Makes a PATCH request to the given URL.
  """
  @spec patch(url(), headers(), body(), adapter_opts()) :: response()
  def patch(url, headers \\ nil, body \\ nil, opts \\ []) do
    request(:patch, url, headers, body, opts)
  end

  @doc """
  Makes a DELETE request to the given URL.
  """
  @spec delete(url(), headers(), body(), adapter_opts()) :: response()
  def delete(url, headers \\ nil, body \\ nil, opts \\ []) do
    request(:delete, url, headers, body, opts)
  end

  @doc false
  @spec adapter() :: module()
  def adapter do
    Application.get_env(:any_http, :client_adapter) || raise("Missing :client_adapter config")
  end

  @spec to_rfc1123_date(NaiveDateTime.t()) :: charlist()
  def to_rfc1123_date(naive_datetime, format \\ :binary)

  def to_rfc1123_date(%NaiveDateTime{} = naive_datetime, :binary) do
    naive_datetime |> to_rfc1123_date(:charlist) |> List.to_string()
  end

  def to_rfc1123_date(%NaiveDateTime{} = naive_datetime, :charlist) do
    naive_datetime |> NaiveDateTime.to_erl() |> :httpd_util.rfc1123_date()
  end

  @spec from_rfc1123_date!(binary() | charlist()) :: NaiveDateTime.t() | no_return()
  def from_rfc1123_date!(value) when is_binary(value) do
    value |> String.to_charlist() |> from_rfc1123_date!()
  end

  def from_rfc1123_date!(value) do
    case :httpd_util.convert_request_date(value) do
      {{_year, _month, _day}, {_hour, _minute, _second}} = erl_date ->
        NaiveDateTime.from_erl!(erl_date)

      :bad_date ->
        raise ArgumentError, "invalid value, expected valid RFC1123 date, got: `#{value}`"
    end
  end
end
