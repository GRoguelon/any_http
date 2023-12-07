defmodule AnyHttp.Error do
  require Logger

  @derive {Inspect, except: [:original]}
  defexception [:type, :message, :original]

  ## Typespecs

  @type type :: :nxdomain | :socket_closed | :unknown_ca | :unknown_error

  @type t :: %__MODULE__{
          __exception__: true,
          type: type(),
          message: binary(),
          original: term()
        }

  ## Module attributes

  @github_new_issue "https://github.com/GRoguelon/any_http/issues/new"

  ## Callback functions

  @impl true
  @spec exception(term()) :: t()
  def exception({type, message, original}) do
    if type == :unknown_error do
      Logger.warning(
        "Unknown error: #{inspect(original)}\n\n" <>
          "If you get this message, create an issue on #{@github_new_issue} and put the " <>
          "content of this message as description."
      )
    end

    %__MODULE__{
      type: type,
      message: message,
      original: original
    }
  end

  @impl true
  @spec message(t()) :: binary()
  def message(%__MODULE__{message: message}) do
    message
  end
end
