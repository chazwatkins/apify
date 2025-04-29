defmodule Apify.WebhookShortLastDispatch do
  @moduledoc """
  Provides struct and type for a WebhookShortLastDispatch
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, finishedAt: String.t() | nil, status: String.t() | nil}

  defstruct [:__info__, :finishedAt, :status]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [finishedAt: {:string, :generic}, status: {:string, :generic}]
  end
end
