defmodule Apify.UpdateTaskRequest do
  @moduledoc """
  Provides struct and type for a UpdateTaskRequest
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actId: String.t(),
          createdAt: String.t(),
          id: String.t(),
          input: Apify.UpdateTaskRequestInput.t() | nil,
          modifiedAt: String.t(),
          name: String.t(),
          options: Apify.UpdateTaskRequestOptions.t() | nil,
          removedAt: String.t() | nil,
          stats: Apify.UpdateTaskRequestStats.t() | nil,
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
      input: {Apify.UpdateTaskRequestInput, :t},
      modifiedAt: {:string, :generic},
      name: {:string, :generic},
      options: {Apify.UpdateTaskRequestOptions, :t},
      removedAt: {:string, :generic},
      stats: {Apify.UpdateTaskRequestStats, :t},
      userId: {:string, :generic},
      username: {:string, :generic}
    ]
  end
end
