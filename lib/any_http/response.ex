defmodule AnyHttp.Response do
  @moduledoc """
  Defines a generic struct to encapsulate a HTTP response.
  """

  @enforce_keys [:status]
  defstruct [:status, headers: nil, body: nil]

  ## Typespecs

  @type status :: 100..599

  @type headers :: nil | AnyHttp.headers()

  @type body :: nil | binary()

  @type t :: %__MODULE__{status: status(), headers: headers(), body: body()}
end
