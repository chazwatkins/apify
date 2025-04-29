defmodule Apify.Version do
  @moduledoc """
  Provides struct and type for a Version
  """
  use Apify.Encoder

  @type t :: %__MODULE__{
          __info__: map,
          applyEnvVarsToBuild: boolean | nil,
          buildTag: String.t(),
          envVars: [Apify.EnvVar.t()] | nil,
          sourceFiles: [Apify.SourceCodeFile.t() | Apify.SourceCodeFolder.t()] | nil,
          sourceType: map | String.t(),
          versionNumber: String.t()
        }

  defstruct [
    :__info__,
    :applyEnvVarsToBuild,
    :buildTag,
    :envVars,
    :sourceFiles,
    :sourceType,
    :versionNumber
  ]

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(type \\ :t)

  def __fields__(:t) do
    [
      applyEnvVarsToBuild: :boolean,
      buildTag: {:string, :generic},
      envVars: [{Apify.EnvVar, :t}],
      sourceFiles: [union: [{Apify.SourceCodeFile, :t}, {Apify.SourceCodeFolder, :t}]],
      sourceType: {:union, [:map, enum: ["SOURCE_FILES", "GIT_REPO", "TARBALL", "GITHUB_GIST"]]},
      versionNumber: {:string, :generic}
    ]
  end
end
