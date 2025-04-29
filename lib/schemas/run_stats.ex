defmodule Apify.RunStats do
  @moduledoc """
  Provides struct and type for a RunStats
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          computeUnits: number,
          cpuAvgUsage: number | nil,
          cpuCurrentUsage: number | nil,
          cpuMaxUsage: number | nil,
          durationMillis: number | nil,
          inputBodyLen: number | nil,
          memAvgBytes: number | nil,
          memCurrentBytes: number | nil,
          memMaxBytes: number | nil,
          metamorph: number | nil,
          migrationCount: number | nil,
          netRxBytes: number | nil,
          netTxBytes: number | nil,
          restartCount: number,
          resurrectCount: number,
          runTimeSecs: number | nil
        }

  defstruct [
    :__info__,
    :computeUnits,
    :cpuAvgUsage,
    :cpuCurrentUsage,
    :cpuMaxUsage,
    :durationMillis,
    :inputBodyLen,
    :memAvgBytes,
    :memCurrentBytes,
    :memMaxBytes,
    :metamorph,
    :migrationCount,
    :netRxBytes,
    :netTxBytes,
    :restartCount,
    :resurrectCount,
    :runTimeSecs
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      computeUnits: :number,
      cpuAvgUsage: :number,
      cpuCurrentUsage: :number,
      cpuMaxUsage: :number,
      durationMillis: :number,
      inputBodyLen: :number,
      memAvgBytes: :number,
      memCurrentBytes: :number,
      memMaxBytes: :number,
      metamorph: :number,
      migrationCount: :number,
      netRxBytes: :number,
      netTxBytes: :number,
      restartCount: :number,
      resurrectCount: :number,
      runTimeSecs: :number
    ]
  end
end
