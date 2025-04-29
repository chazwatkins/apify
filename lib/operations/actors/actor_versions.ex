defmodule Apify.Actors.ActorVersions do
  @moduledoc """
  Provides API endpoints related to actors/actor versions
  """

  @default_client Apify.Client

  @doc """
  Delete version

  Deletes a specific version of Actor's source code.

  """
  @spec act_version_delete(actorId :: String.t(), versionNumber :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def act_version_delete(actorId, versionNumber, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId, versionNumber: versionNumber],
      call: {Apify.Actors.ActorVersions, :act_version_delete},
      url: "/v2/acts/#{actorId}/versions/#{versionNumber}",
      method: :delete,
      response: [{204, :map}],
      opts: opts
    })
  end

  @doc """
  Delete environment variable

  Deletes a specific environment variable.
  """
  @spec act_version_env_var_delete(
          actorId :: String.t(),
          versionNumber :: String.t(),
          envVarName :: String.t(),
          opts :: keyword
        ) :: {:ok, map} | {:error, Apify.Error.t()}
  def act_version_env_var_delete(actorId, versionNumber, envVarName, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId, versionNumber: versionNumber, envVarName: envVarName],
      call: {Apify.Actors.ActorVersions, :act_version_env_var_delete},
      url: "/v2/acts/#{actorId}/versions/#{versionNumber}/env-vars/#{envVarName}",
      method: :delete,
      response: [{204, :map}],
      opts: opts
    })
  end

  @doc """
  Get environment variable

  Gets a [EnvVar object](#/reference/actors/environment-variable-object) that
  contains all the details about a specific environment variable of an Actor.

  If `isSecret` is set to `true`, then `value` will never be returned.

  """
  @spec act_version_env_var_get(
          actorId :: String.t(),
          versionNumber :: String.t(),
          envVarName :: String.t(),
          opts :: keyword
        ) :: {:ok, Apify.GetEnvVarResponse.t()} | {:error, Apify.Error.t()}
  def act_version_env_var_get(actorId, versionNumber, envVarName, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId, versionNumber: versionNumber, envVarName: envVarName],
      call: {Apify.Actors.ActorVersions, :act_version_env_var_get},
      url: "/v2/acts/#{actorId}/versions/#{versionNumber}/env-vars/#{envVarName}",
      method: :get,
      response: [{200, {Apify.GetEnvVarResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Update environment variable

  Updates Actor environment variable using values specified by a [EnvVar
  object](#/reference/actors/environment-variable-object)
  passed as JSON in the POST payload.
  If the object does not define a specific property, its value will not be
  updated.

  The request needs to specify the `Content-Type: application/json` HTTP
  header!

  When providing your API authentication token, we recommend using the
  request's `Authorization` header, rather than the URL. ([More
  info](#/introduction/authentication)).

  The response is the [EnvVar object](#/reference/actors/environment-variable-object) as returned by the
  [Get environment variable](#/reference/actors/environment-variable-object/get-environment-variable)
  endpoint.

  """
  @spec act_version_env_var_put(
          actorId :: String.t(),
          versionNumber :: String.t(),
          envVarName :: String.t(),
          body :: Apify.CreateOrUpdateEnvVarRequest.t(),
          opts :: keyword
        ) :: {:ok, Apify.GetEnvVarResponse.t()} | {:error, Apify.Error.t()}
  def act_version_env_var_put(actorId, versionNumber, envVarName, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId, versionNumber: versionNumber, envVarName: envVarName, body: body],
      call: {Apify.Actors.ActorVersions, :act_version_env_var_put},
      url: "/v2/acts/#{actorId}/versions/#{versionNumber}/env-vars/#{envVarName}",
      body: body,
      method: :put,
      request: [{"application/json", {Apify.CreateOrUpdateEnvVarRequest, :t}}],
      response: [{200, {Apify.GetEnvVarResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get list of environment variables

  Gets the list of environment variables for a specific version of an Actor.
  The response is a JSON object with the list of [EnvVar objects](#/reference/actors/environment-variable-object), where each contains basic information about a single environment variable.

  """
  @spec act_version_env_vars_get(
          actorId :: String.t(),
          versionNumber :: String.t(),
          opts :: keyword
        ) :: {:ok, Apify.GetEnvVarListResponse.t()} | {:error, Apify.Error.t()}
  def act_version_env_vars_get(actorId, versionNumber, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId, versionNumber: versionNumber],
      call: {Apify.Actors.ActorVersions, :act_version_env_vars_get},
      url: "/v2/acts/#{actorId}/versions/#{versionNumber}/env-vars",
      method: :get,
      response: [{200, {Apify.GetEnvVarListResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Create environment variable

  Creates an environment variable of an Actor using values specified in a
  [EnvVar object](#/reference/actors/environment-variable-object) passed as
  JSON in the POST payload.

  The request must specify `name` and `value` parameters (as strings) in the
  JSON payload and a `Content-Type: application/json` HTTP header.

  ```
  {
      "name": "ENV_VAR_NAME",
      "value": "my-env-var"
  }
  ```

  The response is the [EnvVar
  object](#/reference/actors/environment-variable-object) as returned by the [Get environment
  variable](#/reference/actors/environment-variable-object/get-environment-variable)
  endpoint.

  """
  @spec act_version_env_vars_post(
          actorId :: String.t(),
          versionNumber :: String.t(),
          body :: Apify.CreateOrUpdateEnvVarRequest.t(),
          opts :: keyword
        ) :: {:ok, Apify.GetEnvVarResponse.t()} | {:error, Apify.Error.t()}
  def act_version_env_vars_post(actorId, versionNumber, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId, versionNumber: versionNumber, body: body],
      call: {Apify.Actors.ActorVersions, :act_version_env_vars_post},
      url: "/v2/acts/#{actorId}/versions/#{versionNumber}/env-vars",
      body: body,
      method: :post,
      request: [{"application/json", {Apify.CreateOrUpdateEnvVarRequest, :t}}],
      response: [{201, {Apify.GetEnvVarResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get version

  Gets a [Version object](#/reference/actors/version-object) that contains all the details about a specific version of an Actor.

  """
  @spec act_version_get(actorId :: String.t(), versionNumber :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetVersionResponse.t()} | {:error, Apify.Error.t()}
  def act_version_get(actorId, versionNumber, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId, versionNumber: versionNumber],
      call: {Apify.Actors.ActorVersions, :act_version_get},
      url: "/v2/acts/#{actorId}/versions/#{versionNumber}",
      method: :get,
      response: [{200, {Apify.GetVersionResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Update version

  Updates Actor version using values specified by a [Version object](#/reference/actors/version-object) passed as JSON in the POST payload.

  If the object does not define a specific property, its value will not be
  updated.

  The request needs to specify the `Content-Type: application/json` HTTP
  header!

  When providing your API authentication token, we recommend using the
  request's `Authorization` header, rather than the URL. ([More
  info](#/introduction/authentication)).

  The response is the [Version object](#/reference/actors/version-object) as
  returned by the [Get version](#/reference/actors/version-object/get-version) endpoint.

  """
  @spec act_version_put(
          actorId :: String.t(),
          versionNumber :: String.t(),
          body :: Apify.CreateOrUpdateVersionRequest.t(),
          opts :: keyword
        ) :: {:ok, Apify.GetVersionResponse.t()} | {:error, Apify.Error.t()}
  def act_version_put(actorId, versionNumber, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId, versionNumber: versionNumber, body: body],
      call: {Apify.Actors.ActorVersions, :act_version_put},
      url: "/v2/acts/#{actorId}/versions/#{versionNumber}",
      body: body,
      method: :put,
      request: [{"application/json", {Apify.CreateOrUpdateVersionRequest, :t}}],
      response: [{200, {Apify.GetVersionResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get list of versions

  Gets the list of versions of a specific Actor. The response is a JSON object
  with the list of [Version objects](#/reference/actors/version-object), where each
  contains basic information about a single version.

  """
  @spec act_versions_get(actorId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetVersionListResponse.t()} | {:error, Apify.Error.t()}
  def act_versions_get(actorId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId],
      call: {Apify.Actors.ActorVersions, :act_versions_get},
      url: "/v2/acts/#{actorId}/versions",
      method: :get,
      response: [{200, {Apify.GetVersionListResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Create version

  Creates a version of an Actor using values specified in a [Version
  object](#/reference/actors/version-object) passed as JSON in the POST
  payload.

  The request must specify `versionNumber` and `sourceType` parameters (as
  strings) in the JSON payload and a `Content-Type: application/json` HTTP
  header.

  Each `sourceType` requires its own additional properties to be passed to the
  JSON payload object. These are outlined in the [Version
  object](#/reference/actors/version-object) table below and in more detail in
  the [Apify
  documentation](https://docs.apify.com/platform/actors/development/deployment/source-types).

  For example, if an Actor's source code is stored in a [GitHub
  repository](https://docs.apify.com/platform/actors/development/deployment/source-types#git-repository),
  you will set the `sourceType` to `GIT_REPO` and pass the repository's URL in
  the `gitRepoUrl` property.

  ```
  {
      "versionNumber": "0.1",
      "sourceType": "GIT_REPO",
      "gitRepoUrl": "https://github.com/my-github-account/actor-repo"
  }
  ```

  The response is the [Version object](#/reference/actors/version-object) as
  returned by the [Get version](#/reference/actors/version-object/get-version) endpoint.

  """
  @spec act_versions_post(
          actorId :: String.t(),
          body :: Apify.CreateOrUpdateVersionRequest.t(),
          opts :: keyword
        ) :: {:ok, Apify.GetVersionResponse.t()} | {:error, Apify.Error.t()}
  def act_versions_post(actorId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId, body: body],
      call: {Apify.Actors.ActorVersions, :act_versions_post},
      url: "/v2/acts/#{actorId}/versions",
      body: body,
      method: :post,
      request: [{"application/json", {Apify.CreateOrUpdateVersionRequest, :t}}],
      response: [{201, {Apify.GetVersionResponse, :t}}],
      opts: opts
    })
  end
end
