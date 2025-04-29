defmodule Apify.RequestWithoutId do
  @moduledoc """
  Provides struct and type for a RequestWithoutId
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          method: String.t(),
          uniqueKey: String.t(),
          url: String.t()
        }

  defstruct [:__info__, :method, :uniqueKey, :url]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [method: {:string, :generic}, uniqueKey: {:string, :generic}, url: {:string, :generic}]
  end
end
