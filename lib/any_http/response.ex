defmodule AnyHttp.Response do
  @moduledoc """
  Defines a generic struct to encapsulate a HTTP response.
  """

  defstruct [:status, :headers, :body]

  ## Typespecs

  @type t :: %__MODULE__{
          status: pos_integer(),
          headers: [{binary(), binary()}],
          body: nil | binary()
        }
end
