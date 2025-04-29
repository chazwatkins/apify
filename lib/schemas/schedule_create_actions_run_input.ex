defmodule Apify.ScheduleCreateActionsRunInput do
  @moduledoc """
  Provides struct and type for a ScheduleCreateActionsRunInput
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, body: String.t() | nil, contentType: String.t() | nil}

  defstruct [:__info__, :body, :contentType]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [body: {:string, :generic}, contentType: {:string, :generic}]
  end
end
