defmodule Apify.ActorDefinition do
  @moduledoc """
  Provides struct and type for a ActorDefinition
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          actorSpecification: 1,
          buildTag: String.t() | nil,
          changelog: String.t() | nil,
          dockerContextDir: String.t() | nil,
          dockerfile: String.t() | nil,
          environmentVariables: Apify.ActorDefinitionEnvironmentVariables.t() | nil,
          input: map | nil,
          maxMemoryMbytes: integer | nil,
          minMemoryMbytes: integer | nil,
          name: String.t(),
          readme: String.t() | nil,
          storages: Apify.ActorDefinitionStorages.t() | nil,
          usesStandbyMode: boolean | nil,
          version: String.t()
        }

  defstruct [
    :__info__,
    :actorSpecification,
    :buildTag,
    :changelog,
    :dockerContextDir,
    :dockerfile,
    :environmentVariables,
    :input,
    :maxMemoryMbytes,
    :minMemoryMbytes,
    :name,
    :readme,
    :storages,
    :usesStandbyMode,
    :version
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      actorSpecification: {:const, 1},
      buildTag: {:string, :generic},
      changelog: {:string, :generic},
      dockerContextDir: {:string, :generic},
      dockerfile: {:string, :generic},
      environmentVariables: {Apify.ActorDefinitionEnvironmentVariables, :t},
      input: :map,
      maxMemoryMbytes: :integer,
      minMemoryMbytes: :integer,
      name: {:string, :generic},
      readme: {:string, :generic},
      storages: {Apify.ActorDefinitionStorages, :t},
      usesStandbyMode: :boolean,
      version: {:string, :generic}
    ]
  end
end
