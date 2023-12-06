defmodule AnyHttp.Client do
  @moduledoc """
  Defines the behaviour for the HTTP adapters to implement.
  """

  alias AnyHttp, as: T
  alias AnyHttp.Response

  ## Behaviour callbacks

  @callback request(
              method :: T.method(),
              url :: T.url(),
              headers :: T.headers(),
              body :: T.body(),
              client_opts :: T.adapter_opts()
            ) :: Response.t() | no_return()
end
