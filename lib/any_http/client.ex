defmodule AnyHttp.Client do
  @moduledoc """
  Defines the behaviour for the HTTP adapters to implement.
  """

  ## Typespecs

  @type url :: AnyHttp.Types.url()

  @type headers :: AnyHttp.Types.headers()

  @type body :: AnyHttp.Types.body()

  @type response :: AnyHttp.Types.response()

  @type opts :: AnyHttp.Types.opts()

  ## Behaviour callbacks

  @callback head(url(), headers()) :: {:ok, response()}

  @callback head(url(), headers(), opts()) :: {:ok, response()}

  @callback get(url(), headers(), body()) :: {:ok, response()}

  @callback get(url(), headers(), body(), opts()) :: {:ok, response()}

  @callback post(url(), headers(), body()) :: {:ok, response()}

  @callback post(url(), headers(), body(), opts()) :: {:ok, response()}

  @callback put(url(), headers(), body()) :: {:ok, response()}

  @callback put(url(), headers(), body(), opts()) :: {:ok, response()}

  @callback patch(url(), headers(), body()) :: {:ok, response()}

  @callback patch(url(), headers(), body(), opts()) :: {:ok, response()}

  @callback delete(url(), headers(), body()) :: {:ok, response()}

  @callback delete(url(), headers(), body(), opts()) :: {:ok, response()}
end
