defmodule Apify.UsageItem do
  @moduledoc """
  Provides struct and type for a UsageItem
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          amountAfterVolumeDiscountUsd: number,
          baseAmountUsd: number,
          baseUnitPriceUsd: number,
          priceTiers: [Apify.PriceTiers.t()],
          quantity: number
        }

  defstruct [
    :__info__,
    :amountAfterVolumeDiscountUsd,
    :baseAmountUsd,
    :baseUnitPriceUsd,
    :priceTiers,
    :quantity
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      amountAfterVolumeDiscountUsd: :number,
      baseAmountUsd: :number,
      baseUnitPriceUsd: :number,
      priceTiers: [{Apify.PriceTiers, :t}],
      quantity: :number
    ]
  end
end
