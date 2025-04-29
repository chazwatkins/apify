defmodule Apify.GetListOfSchedulesResponseDataItems do
  @moduledoc """
  Provides struct and type for a GetListOfSchedulesResponseDataItems
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actions: [Apify.GetListOfSchedulesResponseDataItemsActions.t()],
          createdAt: String.t(),
          cronExpression: String.t(),
          id: String.t(),
          isEnabled: boolean,
          isExclusive: boolean,
          lastRunAt: String.t(),
          modifiedAt: String.t(),
          name: String.t(),
          nextRunAt: String.t(),
          timezone: String.t(),
          userId: String.t()
        }

  defstruct [
    :__info__,
    :actions,
    :createdAt,
    :cronExpression,
    :id,
    :isEnabled,
    :isExclusive,
    :lastRunAt,
    :modifiedAt,
    :name,
    :nextRunAt,
    :timezone,
    :userId
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actions: [{Apify.GetListOfSchedulesResponseDataItemsActions, :t}],
      createdAt: {:string, :generic},
      cronExpression: {:string, :generic},
      id: {:string, :generic},
      isEnabled: :boolean,
      isExclusive: :boolean,
      lastRunAt: {:string, :generic},
      modifiedAt: {:string, :generic},
      name: {:string, :generic},
      nextRunAt: {:string, :generic},
      timezone: {:string, :generic},
      userId: {:string, :generic}
    ]
  end
end
