defmodule Apify.GetListOfKeyValueStoresResponse do
  @moduledoc """
  Provides struct and type for a GetListOfKeyValueStoresResponse
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, data: Apify.GetListOfKeyValueStoresResponseData.t()}

  defstruct [:__info__, :data]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [data: {Apify.GetListOfKeyValueStoresResponseData, :t}]
  end
end
