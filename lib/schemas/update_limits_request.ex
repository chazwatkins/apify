defmodule Apify.UpdateLimitsRequest do
  @moduledoc """
  Provides struct and type for a UpdateLimitsRequest
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          dataRetentionDays: number | nil,
          maxMonthlyUsageUsd: number | nil
        }

  defstruct [:__info__, :dataRetentionDays, :maxMonthlyUsageUsd]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [dataRetentionDays: :number, maxMonthlyUsageUsd: :number]
  end
end
