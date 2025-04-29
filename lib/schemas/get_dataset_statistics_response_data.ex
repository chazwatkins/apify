defmodule Apify.GetDatasetStatisticsResponseData do
  @moduledoc """
  Provides struct and type for a GetDatasetStatisticsResponseData
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          fieldStatistics: Apify.GetDatasetStatisticsResponseDataFieldStatistics.t() | nil
        }

  defstruct [:__info__, :fieldStatistics]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [fieldStatistics: {Apify.GetDatasetStatisticsResponseDataFieldStatistics, :t}]
  end
end
