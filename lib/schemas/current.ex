defmodule Apify.Current do
  @moduledoc """
  Provides struct and type for a Current
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          activeActorJobCount: number,
          actorCount: number,
          actorMemoryGbytes: number,
          actorTaskCount: number,
          monthlyActorComputeUnits: number,
          monthlyExternalDataTransferGbytes: number,
          monthlyProxySerps: number,
          monthlyResidentialProxyGbytes: number,
          monthlyUsageUsd: number,
          teamAccountSeatCount: number
        }

  defstruct [
    :__info__,
    :activeActorJobCount,
    :actorCount,
    :actorMemoryGbytes,
    :actorTaskCount,
    :monthlyActorComputeUnits,
    :monthlyExternalDataTransferGbytes,
    :monthlyProxySerps,
    :monthlyResidentialProxyGbytes,
    :monthlyUsageUsd,
    :teamAccountSeatCount
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      activeActorJobCount: :number,
      actorCount: :number,
      actorMemoryGbytes: :number,
      actorTaskCount: :number,
      monthlyActorComputeUnits: :number,
      monthlyExternalDataTransferGbytes: :number,
      monthlyProxySerps: :number,
      monthlyResidentialProxyGbytes: :number,
      monthlyUsageUsd: :number,
      teamAccountSeatCount: :number
    ]
  end
end
