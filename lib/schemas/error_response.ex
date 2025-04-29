defmodule Apify.ErrorResponse do
  @moduledoc """
  Provides struct and type for a ErrorResponse
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, error: Apify.ErrorResponseError.t()}

  defstruct [:__info__, :error]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [error: {Apify.ErrorResponseError, :t}]
  end
end
