defmodule Apify.ChargeRunRequest do
  @moduledoc """
  Provides struct and type for a ChargeRunRequest
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, eventCount: number, eventName: String.t()}

  defstruct [:__info__, :eventCount, :eventName]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [eventCount: :number, eventName: {:string, :generic}]
  end
end
