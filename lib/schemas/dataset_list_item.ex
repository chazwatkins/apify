defmodule Apify.DatasetListItem do
  @moduledoc """
  Provides struct and type for a DatasetListItem
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          accessedAt: String.t(),
          actId: String.t() | nil,
          actRunId: String.t() | nil,
          cleanItemCount: number,
          createdAt: String.t(),
          id: String.t(),
          itemCount: number,
          modifiedAt: String.t(),
          name: String.t(),
          userId: String.t()
        }

  defstruct [
    :__info__,
    :accessedAt,
    :actId,
    :actRunId,
    :cleanItemCount,
    :createdAt,
    :id,
    :itemCount,
    :modifiedAt,
    :name,
    :userId
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      accessedAt: {:string, :generic},
      actId: {:string, :generic},
      actRunId: {:string, :generic},
      cleanItemCount: :number,
      createdAt: {:string, :generic},
      id: {:string, :generic},
      itemCount: :number,
      modifiedAt: {:string, :generic},
      name: {:string, :generic},
      userId: {:string, :generic}
    ]
  end
end
