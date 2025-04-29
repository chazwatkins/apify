defmodule Apify.ScheduleCreateActions do
  @moduledoc """
  Provides struct and type for a ScheduleCreateActions
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actorId: String.t(),
          runInput: Apify.ScheduleCreateActionsRunInput.t() | nil,
          runOptions: Apify.ScheduleCreateActionsRunOptions.t() | nil,
          type: String.t()
        }

  defstruct [:__info__, :actorId, :runInput, :runOptions, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actorId: {:string, :generic},
      runInput: {Apify.ScheduleCreateActionsRunInput, :t},
      runOptions: {Apify.ScheduleCreateActionsRunOptions, :t},
      type: {:string, :generic}
    ]
  end
end
