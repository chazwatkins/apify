defmodule Apify.GetListOfKeyValueStoresResponseData do
  @moduledoc """
  Provides struct and type for a GetListOfKeyValueStoresResponseData
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          count: number | nil,
          desc: boolean | nil,
          items: [Apify.KeyValueStore.t()] | nil,
          limit: number | nil,
          offset: number | nil,
          total: number | nil
        }

  defstruct [:__info__, :count, :desc, :items, :limit, :offset, :total]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      count: :number,
      desc: :boolean,
      items: [{Apify.KeyValueStore, :t}],
      limit: :number,
      offset: :number,
      total: :number
    ]
  end
end
