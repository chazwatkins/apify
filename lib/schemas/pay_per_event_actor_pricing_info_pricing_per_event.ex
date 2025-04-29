defmodule Apify.PayPerEventActorPricingInfoPricingPerEvent do
  @moduledoc """
  Provides struct and type for a PayPerEventActorPricingInfoPricingPerEvent
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actorChargeEvents:
            Apify.PayPerEventActorPricingInfoPricingPerEventActorChargeEvents.t() | nil
        }

  defstruct [:__info__, :actorChargeEvents]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [actorChargeEvents: {Apify.PayPerEventActorPricingInfoPricingPerEventActorChargeEvents, :t}]
  end
end
