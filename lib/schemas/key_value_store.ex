defmodule Apify.KeyValueStore do
  @moduledoc """
  Provides struct and type for a KeyValueStore
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          accessedAt: String.t(),
          actId: String.t() | nil,
          actRunId: String.t() | nil,
          consoleUrl: String.t(),
          createdAt: String.t(),
          id: String.t(),
          modifiedAt: String.t(),
          name: String.t(),
          stats: Apify.KeyValueStoreStats.t() | nil,
          userId: String.t() | nil,
          username: String.t() | nil
        }

  defstruct [
    :__info__,
    :accessedAt,
    :actId,
    :actRunId,
    :consoleUrl,
    :createdAt,
    :id,
    :modifiedAt,
    :name,
    :stats,
    :userId,
    :username
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      accessedAt: {:string, :generic},
      actId: {:string, :generic},
      actRunId: {:string, :generic},
      consoleUrl: {:string, :generic},
      createdAt: {:string, :generic},
      id: {:string, :generic},
      modifiedAt: {:string, :generic},
      name: {:string, :generic},
      stats: {Apify.KeyValueStoreStats, :t},
      userId: {:string, :generic},
      username: {:string, :generic}
    ]
  end
end
