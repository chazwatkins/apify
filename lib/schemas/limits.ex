defmodule Apify.Limits do
  @moduledoc """
  Provides struct and type for a Limits
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          dataRetentionDays: number,
          maxActorCount: number,
          maxActorMemoryGbytes: number,
          maxActorTaskCount: number,
          maxConcurrentActorJobs: number,
          maxMonthlyActorComputeUnits: number,
          maxMonthlyExternalDataTransferGbytes: number,
          maxMonthlyProxySerps: number,
          maxMonthlyResidentialProxyGbytes: number,
          maxMonthlyUsageUsd: number,
          maxTeamAccountSeatCount: number
        }

  defstruct [
    :__info__,
    :dataRetentionDays,
    :maxActorCount,
    :maxActorMemoryGbytes,
    :maxActorTaskCount,
    :maxConcurrentActorJobs,
    :maxMonthlyActorComputeUnits,
    :maxMonthlyExternalDataTransferGbytes,
    :maxMonthlyProxySerps,
    :maxMonthlyResidentialProxyGbytes,
    :maxMonthlyUsageUsd,
    :maxTeamAccountSeatCount
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      dataRetentionDays: :number,
      maxActorCount: :number,
      maxActorMemoryGbytes: :number,
      maxActorTaskCount: :number,
      maxConcurrentActorJobs: :number,
      maxMonthlyActorComputeUnits: :number,
      maxMonthlyExternalDataTransferGbytes: :number,
      maxMonthlyProxySerps: :number,
      maxMonthlyResidentialProxyGbytes: :number,
      maxMonthlyUsageUsd: :number,
      maxTeamAccountSeatCount: :number
    ]
  end
end
