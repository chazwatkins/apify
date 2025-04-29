defmodule Apify.UpdateStoreRequest do
  @moduledoc """
  Provides struct and type for a UpdateStoreRequest
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, name: String.t()}

  defstruct [:__info__, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [name: {:string, :generic}]
  end
end
