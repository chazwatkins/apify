defmodule Apify.AccountLimits do
  @moduledoc """
  Provides struct and type for a AccountLimits
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          current: Apify.Current.t(),
          limits: Apify.Limits.t(),
          monthlyUsageCycle: Apify.MonthlyUsageCycle.t()
        }

  defstruct [:__info__, :current, :limits, :monthlyUsageCycle]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      current: {Apify.Current, :t},
      limits: {Apify.Limits, :t},
      monthlyUsageCycle: {Apify.MonthlyUsageCycle, :t}
    ]
  end
end
