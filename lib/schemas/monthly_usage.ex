defmodule Apify.MonthlyUsage do
  @moduledoc """
  Provides struct and type for a MonthlyUsage
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          dailyServiceUsages: [Apify.DailyServiceUsages.t()],
          monthlyServiceUsage: Apify.MonthlyServiceUsage.t(),
          totalUsageCreditsUsdAfterVolumeDiscount: number,
          totalUsageCreditsUsdBeforeVolumeDiscount: number,
          usageCycle: Apify.UsageCycle.t()
        }

  defstruct [
    :__info__,
    :dailyServiceUsages,
    :monthlyServiceUsage,
    :totalUsageCreditsUsdAfterVolumeDiscount,
    :totalUsageCreditsUsdBeforeVolumeDiscount,
    :usageCycle
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      dailyServiceUsages: [{Apify.DailyServiceUsages, :t}],
      monthlyServiceUsage: {Apify.MonthlyServiceUsage, :t},
      totalUsageCreditsUsdAfterVolumeDiscount: :number,
      totalUsageCreditsUsdBeforeVolumeDiscount: :number,
      usageCycle: {Apify.UsageCycle, :t}
    ]
  end
end
