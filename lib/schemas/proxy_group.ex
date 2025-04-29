defmodule Apify.ProxyGroup do
  @moduledoc """
  Provides struct and type for a ProxyGroup
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          availableCount: number,
          description: String.t(),
          name: String.t()
        }

  defstruct [:__info__, :availableCount, :description, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [availableCount: :number, description: {:string, :generic}, name: {:string, :generic}]
  end
end
