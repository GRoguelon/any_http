defmodule AnyHttp.Response do
  @moduledoc """
  Defines a generic struct to encapsulate a HTTP response.
  """

  defstruct [:status, :headers, :body]

  ## Typespecs

  @type status :: 100..599

  @type headers :: AnyHttp.headers()

  @type body :: nil | binary()

  @type t :: %__MODULE__{
          status: status(),
          headers: headers(),
          body: body()
        }
end
