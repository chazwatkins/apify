defmodule Apify.ActorBuilds do
  @moduledoc """
  Provides API endpoints related to actor builds
  """

  @default_client Apify.Client

  @type actor_build_abort_post_200_json_resp :: %{__info__: map, data: map | nil}

  @doc """
  Abort build

  Aborts an Actor build and returns an object that contains all the details
  about the build.

  Only builds that are starting or running are aborted. For builds with status
  `FINISHED`, `FAILED`, `ABORTING` and `TIMED-OUT` this call does nothing.

  """
  @spec actor_build_abort_post(buildId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def actor_build_abort_post(buildId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [buildId: buildId],
      call: {Apify.ActorBuilds, :actor_build_abort_post},
      url: "/v2/actor-builds/#{buildId}/abort",
      method: :post,
      response: [{200, {Apify.ActorBuilds, :actor_build_abort_post_200_json_resp}}],
      opts: opts
    })
  end

  @doc """
  Delete build

  Delete the build. The build that is the current default build for the Actor
  cannot be deleted.

  Only users with build permissions for the Actor can delete builds.

  """
  @spec actor_build_delete(buildId :: String.t(), opts :: keyword) ::
          :ok | {:error, Apify.Error.t()}
  def actor_build_delete(buildId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [buildId: buildId],
      call: {Apify.ActorBuilds, :actor_build_delete},
      url: "/v2/actor-builds/#{buildId}",
      method: :delete,
      response: [{204, :null}],
      opts: opts
    })
  end

  @type actor_build_get_200_json_resp :: %{__info__: map, data: map | nil}

  @doc """
  Get build

  Gets an object that contains all the details about a specific build of an
  Actor.

  By passing the optional `waitForFinish` parameter the API endpoint will
  synchronously wait for the build to finish. This is useful to avoid periodic
  polling when waiting for an Actor build to finish.

  This endpoint does not require the authentication token. Instead, calls are authenticated using a hard-to-guess ID of the build. However,
  if you access the endpoint without the token, certain attributes, such as `usageUsd` and `usageTotalUsd`, will be hidden.


  ## Options

    * `waitForFinish`: The maximum number of seconds the server waits for the build to finish.
      By default it is `0`, the maximum value is `60`. <!-- MAX_ACTOR_JOB_ASYNC_WAIT_SECS -->
      
      If the build finishes in time then the returned build object will have a
      terminal status (e.g. `SUCCEEDED`), otherwise it will have a transitional status (e.g. `RUNNING`).
      

  """
  @spec actor_build_get(buildId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def actor_build_get(buildId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:waitForFinish])

    client.request(%{
      args: [buildId: buildId],
      call: {Apify.ActorBuilds, :actor_build_get},
      url: "/v2/actor-builds/#{buildId}",
      method: :get,
      query: query,
      response: [{200, {Apify.ActorBuilds, :actor_build_get_200_json_resp}}],
      opts: opts
    })
  end

  @doc """
  Get log

  Check out [Logs](#/reference/logs) for full reference.

  ## Options

    * `stream`: If `true` or `1` then the logs will be streamed as long as the run or
      build is running.
      
    * `download`: If `true` or `1` then the web browser will download the log file rather
      than open it in a tab.
      

  """
  @spec actor_build_log_get(buildId :: String.t(), opts :: keyword) ::
          {:ok, String.t()} | {:error, Apify.Error.t()}
  def actor_build_log_get(buildId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:download, :stream])

    client.request(%{
      args: [buildId: buildId],
      call: {Apify.ActorBuilds, :actor_build_log_get},
      url: "/v2/actor-builds/#{buildId}/log",
      method: :get,
      query: query,
      response: [{200, {:string, :generic}}],
      opts: opts
    })
  end

  @doc """
  Get OpenAPI definition

  Get the OpenAPI definition for Actor builds. Two similar endpoints are available:

  - [First endpoint](/api/v2/act-openapi-json-get): Requires both `actorId` and `buildId`. Use `default` as the `buildId` to get the OpenAPI schema for the default Actor build.
  - [Second endpoint](/api/v2/actor-build-openapi-json-get): Requires only `buildId`.

  Get the OpenAPI definition for a specific Actor build.
  Authentication is based on the build's unique ID. No authentication token is required.

  :::note

  You can also use the [`/api/v2/act-openapi-json-get`](/api/v2/act-openapi-json-get) endpoint to get the OpenAPI definition for a build.

  :::

  """
  @spec actor_build_openapi_json_get(buildId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetOpenApiResponse.t()} | {:error, Apify.Error.t()}
  def actor_build_openapi_json_get(buildId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [buildId: buildId],
      call: {Apify.ActorBuilds, :actor_build_openapi_json_get},
      url: "/v2/actor-builds/#{buildId}/openapi.json",
      method: :get,
      response: [{200, {Apify.GetOpenApiResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get user builds list

  Gets a list of all builds for a user. The response is a JSON array of
  objects, where each object contains basic information about a single build.

  The endpoint supports pagination using the `limit` and `offset` parameters
  and it will not return more than 1000 records.

  By default, the records are sorted by the `startedAt` field in ascending
  order. Therefore, you can use pagination to incrementally fetch all builds while
  new ones are still being started. To sort the records in descending order, use
  the `desc=1` parameter.


  ## Options

    * `offset`: Number of records that should be skipped at the start. The default value
      is `0`.
      
    * `limit`: Maximum number of records to return. The default value as well as the
      maximum is `1000`.
      
    * `desc`: If `true` or `1` then the objects are sorted by the `startedAt` field in
      descending order. By default, they are sorted in ascending order.
      

  """
  @spec actor_builds_get(opts :: keyword) ::
          {:ok, Apify.GetBuildListResponse.t()} | {:error, Apify.Error.t()}
  def actor_builds_get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset])

    client.request(%{
      args: [],
      call: {Apify.ActorBuilds, :actor_builds_get},
      url: "/v2/actor-builds",
      method: :get,
      query: query,
      response: [{200, {Apify.GetBuildListResponse, :t}}],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:actor_build_abort_post_200_json_resp) do
    [data: :map]
  end

  def __fields__(:actor_build_get_200_json_resp) do
    [data: :map]
  end
end
