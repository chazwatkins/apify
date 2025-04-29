defmodule Apify.Task do
  @moduledoc """
  Provides struct and type for a Task
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actId: String.t(),
          createdAt: String.t(),
          id: String.t(),
          input: Apify.TaskInput.t() | nil,
          modifiedAt: String.t(),
          name: String.t(),
          options: Apify.TaskOptions.t() | nil,
          removedAt: String.t() | nil,
          stats: Apify.TaskStats.t() | nil,
          userId: String.t(),
          username: String.t() | nil
        }

  defstruct [
    :__info__,
    :actId,
    :createdAt,
    :id,
    :input,
    :modifiedAt,
    :name,
    :options,
    :removedAt,
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
      createdAt: {:string, :generic},
      id: {:string, :generic},
      input: {Apify.TaskInput, :t},
      modifiedAt: {:string, :generic},
      name: {:string, :generic},
      options: {Apify.TaskOptions, :t},
      removedAt: {:string, :generic},
      stats: {Apify.TaskStats, :t},
      userId: {:string, :generic},
      username: {:string, :generic}
    ]
  end
end
