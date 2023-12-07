defmodule AnyHttp.Client do
  @moduledoc """
  Defines the behaviour for the HTTP adapters to implement.
  """

  alias AnyHttp, as: T

  ## Behaviour callbacks

  @callback request(
              method :: T.method(),
              url :: T.url(),
              headers :: T.headers(),
              body :: T.body(),
              adapter_opts :: T.adapter_opts()
            ) :: T.response() | no_return()
end
