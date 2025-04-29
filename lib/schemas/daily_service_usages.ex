defmodule Apify.DailyServiceUsages do
  @moduledoc """
  Provides struct and type for a DailyServiceUsages
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          date: String.t(),
          serviceUsage: Apify.ServiceUsage.t(),
          totalUsageCreditsUsd: number
        }

  defstruct [:__info__, :date, :serviceUsage, :totalUsageCreditsUsd]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      date: {:string, :generic},
      serviceUsage: {Apify.ServiceUsage, :t},
      totalUsageCreditsUsd: :number
    ]
  end
end
