defmodule Apify.WebhookUpdateCondition do
  @moduledoc """
  Provides struct and type for a WebhookUpdateCondition
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actorId: String.t() | nil,
          actorRunId: String.t() | nil,
          actorTaskId: String.t() | nil
        }

  defstruct [:__info__, :actorId, :actorRunId, :actorTaskId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actorId: {:string, :generic},
      actorRunId: {:string, :generic},
      actorTaskId: {:string, :generic}
    ]
  end
end
