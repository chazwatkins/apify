defmodule Apify.RequestQueueShort do
  @moduledoc """
  Provides struct and type for a RequestQueueShort
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          accessedAt: String.t(),
          actId: String.t() | nil,
          actRunId: String.t() | nil,
          createdAt: String.t(),
          expireAt: String.t(),
          hadMultipleClients: boolean,
          handledRequestCount: number,
          id: String.t(),
          modifiedAt: String.t(),
          name: String.t(),
          pendingRequestCount: number,
          totalRequestCount: number,
          userId: String.t(),
          username: String.t()
        }

  defstruct [
    :__info__,
    :accessedAt,
    :actId,
    :actRunId,
    :createdAt,
    :expireAt,
    :hadMultipleClients,
    :handledRequestCount,
    :id,
    :modifiedAt,
    :name,
    :pendingRequestCount,
    :totalRequestCount,
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
      createdAt: {:string, :generic},
      expireAt: {:string, :generic},
      hadMultipleClients: :boolean,
      handledRequestCount: :number,
      id: {:string, :generic},
      modifiedAt: {:string, :generic},
      name: {:string, :generic},
      pendingRequestCount: :number,
      totalRequestCount: :number,
      userId: {:string, :generic},
      username: {:string, :generic}
    ]
  end
end
