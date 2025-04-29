defmodule Apify.PriceTiers do
  @moduledoc """
  Provides struct and type for a PriceTiers
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          discountPercent: number,
          priceUsd: number,
          quantityAbove: number,
          tierQuantity: number,
          unitPriceUsd: number
        }

  defstruct [:__info__, :discountPercent, :priceUsd, :quantityAbove, :tierQuantity, :unitPriceUsd]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      discountPercent: :number,
      priceUsd: :number,
      quantityAbove: :number,
      tierQuantity: :number,
      unitPriceUsd: :number
    ]
  end
end
