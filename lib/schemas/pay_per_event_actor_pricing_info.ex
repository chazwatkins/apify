defmodule Apify.PayPerEventActorPricingInfo do
  @moduledoc """
  Provides struct and type for a PayPerEventActorPricingInfo
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          apifyMarginPercentage: number | nil,
          createdAt: DateTime.t() | nil,
          minimalMaxTotalChargeUsd: number | nil,
          notifiedAboutChangeAt: DateTime.t() | nil,
          notifiedAboutFutureChangeAt: DateTime.t() | nil,
          pricingModel: String.t() | nil,
          pricingPerEvent: Apify.PayPerEventActorPricingInfoPricingPerEvent.t() | nil,
          reasonForChange: String.t() | nil,
          startedAt: DateTime.t() | nil
        }

  defstruct [
    :__info__,
    :apifyMarginPercentage,
    :createdAt,
    :minimalMaxTotalChargeUsd,
    :notifiedAboutChangeAt,
    :notifiedAboutFutureChangeAt,
    :pricingModel,
    :pricingPerEvent,
    :reasonForChange,
    :startedAt
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      apifyMarginPercentage: :number,
      createdAt: {:string, :date_time},
      minimalMaxTotalChargeUsd: :number,
      notifiedAboutChangeAt: {:string, :date_time},
      notifiedAboutFutureChangeAt: {:string, :date_time},
      pricingModel: {:const, "PAY_PER_EVENT"},
      pricingPerEvent: {Apify.PayPerEventActorPricingInfoPricingPerEvent, :t},
      reasonForChange: {:string, :generic},
      startedAt: {:string, :date_time}
    ]
  end
end
