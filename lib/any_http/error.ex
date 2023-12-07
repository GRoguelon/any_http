defmodule AnyHttp.Error do
  defexception [:type, :message, :original]

  ## Typespecs

  @type type :: :tls_unknown_ca

  @type t :: %__MODULE__{
          __exception__: true,
          type: type(),
          message: binary(),
          original: term()
        }

  ## Callback functions

  @impl true
  @spec exception(term()) :: t()
  def exception(
        {:failed_connect,
         [{:to_address, {_host, _port}}, {:inet, [:inet], {:tls_alert, {:unknown_ca, reason}}}]} =
          original
      ) do
    %__MODULE__{
      type: :tls_unknown_ca,
      message: List.to_string(reason),
      original: original
    }
  end

  @impl true
  @spec message(t()) :: binary()
  def message(%__MODULE__{message: message}) do
    message
  end
end
