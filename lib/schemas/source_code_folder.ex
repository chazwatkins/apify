defmodule Apify.SourceCodeFolder do
  @moduledoc """
  Provides struct and type for a SourceCodeFolder
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, folder: true, name: String.t()}

  defstruct [:__info__, :folder, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [folder: {:const, true}, name: {:string, :generic}]
  end
end
