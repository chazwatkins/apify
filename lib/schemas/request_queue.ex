defmodule Apify.RequestQueue do
  @moduledoc """
  Provides struct and type for a RequestQueue
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          accessedAt: String.t(),
          consoleUrl: String.t(),
          createdAt: String.t(),
          hadMultipleClients: boolean,
          handledRequestCount: number,
          id: String.t(),
          modifiedAt: String.t(),
          name: String.t() | nil,
          pendingRequestCount: number,
          totalRequestCount: number,
          userId: String.t()
        }

  defstruct [
    :__info__,
    :accessedAt,
    :consoleUrl,
    :createdAt,
    :hadMultipleClients,
    :handledRequestCount,
    :id,
    :modifiedAt,
    :name,
    :pendingRequestCount,
    :totalRequestCount,
    :userId
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      accessedAt: {:string, :generic},
      consoleUrl: {:string, :generic},
      createdAt: {:string, :generic},
      hadMultipleClients: :boolean,
      handledRequestCount: :number,
      id: {:string, :generic},
      modifiedAt: {:string, :generic},
      name: {:string, :generic},
      pendingRequestCount: :number,
      totalRequestCount: :number,
      userId: {:string, :generic}
    ]
  end
end
