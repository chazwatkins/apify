defmodule Apify.GetListOfSchedulesResponseDataItemsActions do
  @moduledoc """
  Provides struct and type for a GetListOfSchedulesResponseDataItemsActions
  """
  use Apify.Encoder

  @type t :: %__MODULE__{__info__: map, actorId: String.t(), id: String.t(), type: String.t()}

  defstruct [:__info__, :actorId, :id, :type]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [actorId: {:string, :generic}, id: {:string, :generic}, type: {:string, :generic}]
  end
end
