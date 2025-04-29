defmodule Apify.GetListOfActorsResponseData do
  @moduledoc """
  Provides struct and type for a GetListOfActorsResponseData
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          count: number | nil,
          desc: boolean | nil,
          items: [Apify.ActorShort.t()] | nil,
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
      items: [{Apify.ActorShort, :t}],
      limit: :number,
      offset: :number,
      total: :number
    ]
  end
end
