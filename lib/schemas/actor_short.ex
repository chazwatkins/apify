defmodule Apify.ActorShort do
  @moduledoc """
  Provides struct and type for a ActorShort
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          createdAt: String.t(),
          id: String.t(),
          modifiedAt: String.t(),
          name: String.t(),
          username: String.t()
        }

  defstruct [:__info__, :createdAt, :id, :modifiedAt, :name, :username]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      createdAt: {:string, :generic},
      id: {:string, :generic},
      modifiedAt: {:string, :generic},
      name: {:string, :generic},
      username: {:string, :generic}
    ]
  end
end
