defmodule Apify.EventData do
  @moduledoc """
  Provides struct and type for a EventData
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, actorId: String.t(), actorRunId: String.t()}

  defstruct [:__info__, :actorId, :actorRunId]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [actorId: {:string, :generic}, actorRunId: {:string, :generic}]
  end
end
