defmodule AnyHttp.Types do
  @moduledoc """
  Defines the typespecs for the library.
  """

  ## Typespecs

  @type url :: binary() | URI.t()

  @type headers :: [{binary(), binary()}]

  @type body :: any()

  @type response :: AnyHttp.Response.t()

  @type opts :: [{atom(), any()}]
end
