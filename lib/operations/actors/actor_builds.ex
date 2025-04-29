defmodule Apify.Actors.ActorBuilds do
  @moduledoc """
  Provides API endpoints related to actors/actor builds
  """

  @default_client Apify.Client

  @doc """
  Abort build

  **[DEPRECATED]** API endpoints related to build of the Actor were moved
  under new namespace [`actor-builds`](#/reference/actor-builds). Aborts an
  Actor build and returns an object that contains all the details about the
  build.

  Only builds that are starting or running are aborted. For builds with status
  `FINISHED`, `FAILED`, `ABORTING` and `TIMED-OUT` this call does nothing.

  """
  @spec act_build_abort_post(actorId :: String.t(), buildId :: String.t(), opts :: keyword) ::
          {:ok, Apify.PostAbortBuildResponse.t()} | {:error, Apify.Error.t()}
  def act_build_abort_post(actorId, buildId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId, buildId: buildId],
      call: {Apify.Actors.ActorBuilds, :act_build_abort_post},
      url: "/v2/acts/#{actorId}/builds/#{buildId}/abort",
      method: :post,
      response: [{200, {Apify.PostAbortBuildResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get default build

  Get the default build for an Actor.

  Use the optional `waitForFinish` parameter to synchronously wait for the build to finish.
  This avoids the need for periodic polling when waiting for the build to complete.

  This endpoint does not require an authentication token. Instead, calls are authenticated using the Actor's unique ID.
  However, if you access the endpoint without a token, certain attributes (e.g., `usageUsd` and `usageTotalUsd`) will be hidden.


  ## Options

    * `waitForFinish`: The maximum number of seconds the server waits for the build to finish.
      If the build finishes within this time, the returned build object will have a terminal status (e.g. `SUCCEEDED`),
      otherwise it will have a transitional status (e.g. `RUNNING`).
      
      By default it is `0`, the maximum value is `60`. <!-- MAX_ACTOR_JOB_ASYNC_WAIT_SECS -->
      

  """
  @spec act_build_default_get(actorId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetBuildResponse.t()} | {:error, Apify.Error.t()}
  def act_build_default_get(actorId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:waitForFinish])

    client.request(%{
      args: [actorId: actorId],
      call: {Apify.Actors.ActorBuilds, :act_build_default_get},
      url: "/v2/acts/#{actorId}/builds/default",
      method: :get,
      query: query,
      response: [{200, {Apify.GetBuildResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get build

  By passing the optional `waitForFinish` parameter the API endpoint will
  synchronously wait for the build to finish.
  This is useful to avoid periodic polling when waiting for an Actor build to
  finish.

  This endpoint does not require the authentication token. Instead, calls are authenticated using a hard-to-guess ID of the build. However,
  if you access the endpoint without the token, certain attributes, such as `usageUsd` and `usageTotalUsd`, will be hidden.


  ## Options

    * `waitForFinish`: The maximum number of seconds the server waits for the build to finish.
      By default it is `0`, the maximum value is `60`. <!-- MAX_ACTOR_JOB_ASYNC_WAIT_SECS -->
      If the build finishes in time then the returned build object will have a terminal status (e.g. `SUCCEEDED`),
      otherwise it will have a transitional status (e.g. `RUNNING`).
      

  """
  @spec act_build_get(actorId :: String.t(), buildId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetBuildResponse.t()} | {:error, Apify.Error.t()}
  def act_build_get(actorId, buildId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:waitForFinish])

    client.request(%{
      args: [actorId: actorId, buildId: buildId],
      call: {Apify.Actors.ActorBuilds, :act_build_get},
      url: "/v2/acts/#{actorId}/builds/#{buildId}",
      method: :get,
      query: query,
      response: [{200, {Apify.GetBuildResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get list of builds

  Gets the list of builds of a specific Actor. The response is a JSON with the
  list of objects, where each object contains basic information about a single build.

  The endpoint supports pagination using the `limit` and `offset` parameters
  and it will not return more than 1000 records.

  By default, the records are sorted by the `startedAt` field in ascending order,
  therefore you can use pagination to incrementally fetch all builds while new
  ones are still being started. To sort the records in descending order, use
  the `desc=1` parameter.


  ## Options

    * `offset`: Number of records that should be skipped at the start. The default value is `0`.
      
    * `limit`: Maximum number of records to return. The default value as well as the maximum is `1000`.
      
    * `desc`: If `true` or `1` then the objects are sorted by the `startedAt` field in
      descending order. By default, they are sorted in ascending order.
      

  """
  @spec act_builds_get(actorId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetBuildListResponse.t()} | {:error, Apify.Error.t()}
  def act_builds_get(actorId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset])

    client.request(%{
      args: [actorId: actorId],
      call: {Apify.Actors.ActorBuilds, :act_builds_get},
      url: "/v2/acts/#{actorId}/builds",
      method: :get,
      query: query,
      response: [{200, {Apify.GetBuildListResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Build Actor

  Builds an Actor.
  The response is the build object as returned by the
  [Get build](#/reference/actors/build-object/get-build) endpoint.


  ## Options

    * `version`: Actor version number to be built.
    * `useCache`: If `true` or `1`, the system will use a cache to speed up the build
      process. By default, cache is not used.
      
    * `betaPackages`: If `true` or `1` then the Actor is built with beta versions of Apify NPM
      packages. By default, the build uses `latest` packages.
      
    * `tag`: Tag to be applied to the build on success. By default, the tag is taken
      from Actor version's `buildTag` property.
      
    * `waitForFinish`: The maximum number of seconds the server waits for the build to finish.
      By default it is `0`, the maximum value is `60`. <!-- MAX_ACTOR_JOB_ASYNC_WAIT_SECS -->
      If the build finishes in time then the returned build object will have a terminal status (e.g. `SUCCEEDED`),
      otherwise it will have a transitional status (e.g. `RUNNING`).
      

  """
  @spec act_builds_post(actorId :: String.t(), opts :: keyword) ::
          {:ok, Apify.BuildActorResponse.t()} | {:error, Apify.Error.t()}
  def act_builds_post(actorId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:betaPackages, :tag, :useCache, :version, :waitForFinish])

    client.request(%{
      args: [actorId: actorId],
      call: {Apify.Actors.ActorBuilds, :act_builds_post},
      url: "/v2/acts/#{actorId}/builds",
      method: :post,
      query: query,
      response: [{201, {Apify.BuildActorResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get OpenAPI definition


  Get the OpenAPI definition for Actor builds. Two similar endpoints are available:

  - [First endpoint](/api/v2/act-openapi-json-get): Requires both `actorId` and `buildId`. Use `default` as the `buildId` to get the OpenAPI schema for the default Actor build.
  - [Second endpoint](/api/v2/actor-build-openapi-json-get): Requires only `buildId`.

  Get the OpenAPI definition for a specific Actor build.

  To fetch the default Actor build, simply pass `default` as the `buildId`.
  Authentication is based on the build's unique ID. No authentication token is required.

  :::note

  You can also use the [`/api/v2/actor-build-openapi-json-get`](/api/v2/actor-build-openapi-json-get) endpoint to get the OpenAPI definition for a build.

  :::

  """
  @spec act_openapi_json_get(actorId :: String.t(), buildId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetOpenApiResponse.t()} | {:error, Apify.Error.t()}
  def act_openapi_json_get(actorId, buildId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorId: actorId, buildId: buildId],
      call: {Apify.Actors.ActorBuilds, :act_openapi_json_get},
      url: "/v2/acts/#{actorId}/builds/#{buildId}/openapi.json",
      method: :get,
      response: [{200, {Apify.GetOpenApiResponse, :t}}],
      opts: opts
    })
  end
end
