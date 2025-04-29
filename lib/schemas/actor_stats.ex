defmodule Apify.ActorStats do
  @moduledoc """
  Provides struct and type for a ActorStats
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          lastRunStartedAt: String.t(),
          totalBuilds: number,
          totalMetamorphs: number,
          totalRuns: number,
          totalUsers: number,
          totalUsers30Days: number,
          totalUsers7Days: number,
          totalUsers90Days: number
        }

  defstruct [
    :__info__,
    :lastRunStartedAt,
    :totalBuilds,
    :totalMetamorphs,
    :totalRuns,
    :totalUsers,
    :totalUsers30Days,
    :totalUsers7Days,
    :totalUsers90Days
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      lastRunStartedAt: {:string, :generic},
      totalBuilds: :number,
      totalMetamorphs: :number,
      totalRuns: :number,
      totalUsers: :number,
      totalUsers30Days: :number,
      totalUsers7Days: :number,
      totalUsers90Days: :number
    ]
  end
end
