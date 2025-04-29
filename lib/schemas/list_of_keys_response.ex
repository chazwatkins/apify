defmodule Apify.ListOfKeysResponse do
  @moduledoc """
  Provides struct and type for a ListOfKeysResponse
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          count: number,
          exclusiveStartKey: String.t() | nil,
          isTruncated: boolean,
          items: [Apify.Items.t()],
          limit: number,
          nextExclusiveStartKey: String.t() | nil
        }

  defstruct [
    :__info__,
    :count,
    :exclusiveStartKey,
    :isTruncated,
    :items,
    :limit,
    :nextExclusiveStartKey
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      count: :number,
      exclusiveStartKey: {:string, :generic},
      isTruncated: :boolean,
      items: [{Apify.Items, :t}],
      limit: :number,
      nextExclusiveStartKey: {:string, :generic}
    ]
  end
end
