defmodule Apify.ScheduleResponseDataActions do
  @moduledoc """
  Provides struct and type for a ScheduleResponseDataActions
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actorId: String.t(),
          id: String.t(),
          runInput: Apify.ScheduleResponseDataActionsRunInput.t() | nil,
          runOptions: Apify.ScheduleResponseDataActionsRunOptions.t() | nil,
          type: String.t()
        }

  defstruct [:__info__, :actorId, :id, :runInput, :runOptions, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actorId: {:string, :generic},
      id: {:string, :generic},
      runInput: {Apify.ScheduleResponseDataActionsRunInput, :t},
      runOptions: {Apify.ScheduleResponseDataActionsRunOptions, :t},
      type: {:string, :generic}
    ]
  end
end
