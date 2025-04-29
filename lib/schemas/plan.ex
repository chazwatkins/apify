defmodule Apify.Plan do
  @moduledoc """
  Provides struct and type for a Plan
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          availableAddOns: [String.t()],
          availableProxyGroups: Apify.AvailableProxyGroups.t(),
          dataRetentionDays: number,
          description: String.t(),
          enabledPlatformFeatures: [[map]],
          id: String.t(),
          isEnabled: boolean,
          maxActorCount: number,
          maxActorMemoryGbytes: number,
          maxActorTaskCount: number,
          maxMonthlyActorComputeUnits: number,
          maxMonthlyExternalDataTransferGbytes: number,
          maxMonthlyProxySerps: number,
          maxMonthlyResidentialProxyGbytes: number,
          maxMonthlyUsageUsd: number,
          monthlyBasePriceUsd: number,
          monthlyUsageCreditsUsd: number,
          supportLevel: String.t(),
          teamAccountSeatCount: number,
          usageDiscountPercent: number
        }

  defstruct [
    :__info__,
    :availableAddOns,
    :availableProxyGroups,
    :dataRetentionDays,
    :description,
    :enabledPlatformFeatures,
    :id,
    :isEnabled,
    :maxActorCount,
    :maxActorMemoryGbytes,
    :maxActorTaskCount,
    :maxMonthlyActorComputeUnits,
    :maxMonthlyExternalDataTransferGbytes,
    :maxMonthlyProxySerps,
    :maxMonthlyResidentialProxyGbytes,
    :maxMonthlyUsageUsd,
    :monthlyBasePriceUsd,
    :monthlyUsageCreditsUsd,
    :supportLevel,
    :teamAccountSeatCount,
    :usageDiscountPercent
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      availableAddOns: [string: :generic],
      availableProxyGroups: {Apify.AvailableProxyGroups, :t},
      dataRetentionDays: :number,
      description: {:string, :generic},
      enabledPlatformFeatures: [[:map]],
      id: {:string, :generic},
      isEnabled: :boolean,
      maxActorCount: :number,
      maxActorMemoryGbytes: :number,
      maxActorTaskCount: :number,
      maxMonthlyActorComputeUnits: :number,
      maxMonthlyExternalDataTransferGbytes: :number,
      maxMonthlyProxySerps: :number,
      maxMonthlyResidentialProxyGbytes: :number,
      maxMonthlyUsageUsd: :number,
      monthlyBasePriceUsd: :number,
      monthlyUsageCreditsUsd: :number,
      supportLevel: {:string, :generic},
      teamAccountSeatCount: :number,
      usageDiscountPercent: :number
    ]
  end
end
