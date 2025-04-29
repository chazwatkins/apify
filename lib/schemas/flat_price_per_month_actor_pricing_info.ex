defmodule Apify.FlatPricePerMonthActorPricingInfo do
  @moduledoc """
  Provides struct and type for a FlatPricePerMonthActorPricingInfo
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          apifyMarginPercentage: number | nil,
          createdAt: DateTime.t() | nil,
          notifiedAboutChangeAt: DateTime.t() | nil,
          notifiedAboutFutureChangeAt: DateTime.t() | nil,
          pricePerUnitUsd: number | nil,
          pricingModel: String.t() | nil,
          reasonForChange: String.t() | nil,
          startedAt: DateTime.t() | nil,
          trialMinutes: number | nil
        }

  defstruct [
    :__info__,
    :apifyMarginPercentage,
    :createdAt,
    :notifiedAboutChangeAt,
    :notifiedAboutFutureChangeAt,
    :pricePerUnitUsd,
    :pricingModel,
    :reasonForChange,
    :startedAt,
    :trialMinutes
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      apifyMarginPercentage: :number,
      createdAt: {:string, :date_time},
      notifiedAboutChangeAt: {:string, :date_time},
      notifiedAboutFutureChangeAt: {:string, :date_time},
      pricePerUnitUsd: :number,
      pricingModel: {:const, "FLAT_PRICE_PER_MONTH"},
      reasonForChange: {:string, :generic},
      startedAt: {:string, :date_time},
      trialMinutes: :number
    ]
  end
end
