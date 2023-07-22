defmodule AnyHttp.Types do
  @moduledoc """
  Defines the typespecs for the library.
  """

  ## Typespecs

  @typedoc "Represents an URL."
  @type url :: binary() | URI.t()

  @typedoc "Represents the headers of a request."
  @type headers :: [{binary(), binary()}]

  @typedoc "Represents the body of a request."
  @type body :: any()

  @typedoc "Represents the response of a request."
  @type response :: AnyHttp.Response.t()

  @typedoc "Represents the options passed to the adapter."
  @type opts :: [{atom(), any()}]

  @typedoc "Represents the result of a request. It can be either a success or an error."
  @type result :: {:ok, response()} | {:error, term()}
end
