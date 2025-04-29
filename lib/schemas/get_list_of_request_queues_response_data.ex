defmodule Apify.GetListOfRequestQueuesResponseData do
  @moduledoc """
  Provides struct and type for a GetListOfRequestQueuesResponseData
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          count: number,
          desc: boolean,
          items: [Apify.RequestQueueShort.t()],
          limit: number,
          offset: number,
          total: number
        }

  defstruct [:__info__, :count, :desc, :items, :limit, :offset, :total]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      count: :number,
      desc: :boolean,
      items: [{Apify.RequestQueueShort, :t}],
      limit: :number,
      offset: :number,
      total: :number
    ]
  end
end
