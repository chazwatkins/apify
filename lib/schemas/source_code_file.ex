defmodule Apify.SourceCodeFile do
  @moduledoc """
  Provides struct and type for a SourceCodeFile
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, content: String.t(), format: String.t(), name: String.t()}

  defstruct [:__info__, :content, :format, :name]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [content: {:string, :generic}, format: {:enum, ["BASE64", "TEXT"]}, name: {:string, :generic}]
  end
end
