defmodule Apify.ErrorResponseError do
  @moduledoc """
  Provides struct and type for a ErrorResponseError
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, message: String.t(), type: String.t()}

  defstruct [:__info__, :message, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [message: {:string, :generic}, type: {:string, :generic}]
  end
end
