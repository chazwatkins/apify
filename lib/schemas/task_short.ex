defmodule Apify.TaskShort do
  @moduledoc """
  Provides struct and type for a TaskShort
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actId: String.t(),
          actName: String.t(),
          actUsername: String.t(),
          createdAt: String.t(),
          id: String.t(),
          modifiedAt: String.t(),
          name: String.t(),
          stats: Apify.TaskShortStats.t() | nil,
          userId: String.t(),
          username: String.t() | nil
        }

  defstruct [
    :__info__,
    :actId,
    :actName,
    :actUsername,
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
      actId: {:string, :generic},
      actName: {:string, :generic},
      actUsername: {:string, :generic},
      createdAt: {:string, :generic},
      id: {:string, :generic},
      modifiedAt: {:string, :generic},
      name: {:string, :generic},
      stats: {Apify.TaskShortStats, :t},
      userId: {:string, :generic},
      username: {:string, :generic}
    ]
  end
end
