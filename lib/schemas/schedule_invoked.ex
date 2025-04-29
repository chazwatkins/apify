defmodule Apify.ScheduleInvoked do
  @moduledoc """
  Provides struct and type for a ScheduleInvoked
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          createdAt: String.t(),
          level: String.t(),
          message: String.t()
        }

  defstruct [:__info__, :createdAt, :level, :message]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [createdAt: {:string, :generic}, level: {:string, :generic}, message: {:string, :generic}]
  end
end
