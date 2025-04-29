defmodule Apify.ServiceUsage do
  @moduledoc """
  Provides struct and type for a ServiceUsage
  """
  use Apify.Encoder

  @type t :: %__MODULE__{SERVICE_USAGE_ITEM: Apify.UsageItem.t(), __info__: map}

  defstruct [:SERVICE_USAGE_ITEM, :__info__]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [SERVICE_USAGE_ITEM: {Apify.UsageItem, :t}]
  end
end
