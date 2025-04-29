defmodule Apify.MonthlyServiceUsage do
  @moduledoc """
  Provides struct and type for a MonthlyServiceUsage
  """
  use Apify.Encoder

  @type t :: %__MODULE__{USAGE_ITEM: Apify.UsageItem.t(), __info__: map}

  defstruct [:USAGE_ITEM, :__info__]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [USAGE_ITEM: {Apify.UsageItem, :t}]
  end
end
