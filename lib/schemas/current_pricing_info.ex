defmodule Apify.CurrentPricingInfo do
  @moduledoc """
  Provides struct and type for a CurrentPricingInfo
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, pricingModel: String.t()}

  defstruct [:__info__, :pricingModel]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [pricingModel: {:string, :generic}]
  end
end
