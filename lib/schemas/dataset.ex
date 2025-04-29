defmodule Apify.Dataset do
  @moduledoc """
  Provides struct and type for a Dataset
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          accessedAt: String.t(),
          actId: String.t() | nil,
          actRunId: String.t() | nil,
          cleanItemCount: number,
          consoleUrl: String.t(),
          createdAt: String.t(),
          fields: [String.t()] | nil,
          id: String.t(),
          itemCount: number,
          modifiedAt: String.t(),
          name: String.t(),
          schema: map | nil,
          stats: Apify.DatasetStats.t() | nil,
          userId: String.t()
        }

  defstruct [
    :__info__,
    :accessedAt,
    :actId,
    :actRunId,
    :cleanItemCount,
    :consoleUrl,
    :createdAt,
    :fields,
    :id,
    :itemCount,
    :modifiedAt,
    :name,
    :schema,
    :stats,
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
      consoleUrl: {:string, :generic},
      createdAt: {:string, :generic},
      fields: [string: :generic],
      id: {:string, :generic},
      itemCount: :number,
      modifiedAt: {:string, :generic},
      name: {:string, :generic},
      schema: :map,
      stats: {Apify.DatasetStats, :t},
      userId: {:string, :generic}
    ]
  end
end
