defmodule Apify.PricePerDatasetItemActorPricingInfo do
  @moduledoc """
  Provides struct and type for a PricePerDatasetItemActorPricingInfo
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
          unitName: String.t() | nil
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
    :unitName
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
      pricingModel: {:const, "PRICE_PER_DATASET_ITEM"},
      reasonForChange: {:string, :generic},
      startedAt: {:string, :date_time},
      unitName: {:string, :generic}
    ]
  end
end
