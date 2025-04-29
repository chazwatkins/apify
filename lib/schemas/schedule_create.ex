defmodule Apify.ScheduleCreate do
  @moduledoc """
  Provides struct and type for a ScheduleCreate
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actions: [Apify.ScheduleCreateActions.t()] | nil,
          cronExpression: String.t() | nil,
          description: String.t() | nil,
          isEnabled: boolean | nil,
          isExclusive: boolean | nil,
          name: String.t() | nil,
          timezone: String.t() | nil
        }

  defstruct [
    :__info__,
    :actions,
    :cronExpression,
    :description,
    :isEnabled,
    :isExclusive,
    :name,
    :timezone
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actions: [{Apify.ScheduleCreateActions, :t}],
      cronExpression: {:string, :generic},
      description: {:string, :generic},
      isEnabled: :boolean,
      isExclusive: :boolean,
      name: {:string, :generic},
      timezone: {:string, :generic}
    ]
  end
end
