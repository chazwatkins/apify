defmodule Apify.ActorRuns do
  @moduledoc """
  Provides API endpoints related to actor runs
  """

  @default_client Apify.Client

  @doc """
  Abort run

  Aborts an Actor run and returns an object that contains all the details
  about the run.

  Only runs that are starting or running are aborted. For runs with status
  `FINISHED`, `FAILED`, `ABORTING` and `TIMED-OUT` this call does nothing.


  ## Options

    * `gracefully`: If true passed, the Actor run will abort gracefully.
      It will send `aborting` and `persistState` event into run and force-stop the run after 30 seconds.
      It is helpful in cases where you plan to resurrect the run later.
      

  """
  @spec actor_run_abort_post(runId :: String.t(), opts :: keyword) ::
          {:ok, Apify.RunResponse.t()} | {:error, Apify.Error.t()}
  def actor_run_abort_post(runId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:gracefully])

    client.request(%{
      args: [runId: runId],
      call: {Apify.ActorRuns, :actor_run_abort_post},
      url: "/v2/actor-runs/#{runId}/abort",
      method: :post,
      query: query,
      response: [{200, {Apify.RunResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete run

  Delete the run. Only finished runs can be deleted. Only the person or
  organization that initiated the run can delete it.

  """
  @spec actor_run_delete(runId :: String.t(), opts :: keyword) :: :ok | {:error, Apify.Error.t()}
  def actor_run_delete(runId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [runId: runId],
      call: {Apify.ActorRuns, :actor_run_delete},
      url: "/v2/actor-runs/#{runId}",
      method: :delete,
      response: [{204, :null}],
      opts: opts
    })
  end

  @type actor_run_get_200_json_resp :: %{__info__: map, data: map | nil}

  @doc """
  Get run

  This is not a single endpoint, but an entire group of endpoints that lets
  you retrieve the run or any of its default storages.

  The endpoints accept the same HTTP methods and query parameters as
  the respective storage endpoints.

  The base path that represents the Actor run object is:

  `/v2/actor-runs/{runId}{?token}`

  In order to access the default storages of the Actor run, i.e. log,
  key-value store, dataset and request queue, use the following endpoints:

  * `/v2/actor-runs/{runId}/log{?token}`
  * `/v2/actor-runs/{runId}/key-value-store{?token}`
  * `/v2/actor-runs/{runId}/dataset{?token}`
  * `/v2/actor-runs/{runId}/request-queue{?token}`

  These API endpoints have the same usage as the equivalent storage endpoints.

  For example, `/v2/actor-runs/{runId}/key-value-store` has the same HTTP method and
  parameters as the [Key-value store object](#/reference/key-value-stores/store-object) endpoint.

  Additionally, each of the above API endpoints supports all sub-endpoints
  of the original one:

  #### Log

  * `/v2/actor-runs/{runId}/log` [Log](#/reference/logs)

  #### Key-value store

  * `/v2/actor-runs/{runId}/key-value-store/keys{?token}` [Key
  collection](#/reference/key-value-stores/key-collection)
  * `/v2/actor-runs/{runId}/key-value-store/records/{recordKey}{?token}`
  [Record](#/reference/key-value-stores/record)

  #### Dataset

  * `/v2/actor-runs/{runId}/dataset/items{?token}` [Item
  collection](#/reference/datasets/item-collection)

  #### Request queue

  * `/v2/actor-runs/{runId}/request-queue/requests{?token}` [Request
  collection](#/reference/request-queues/request-collection)
  * `/v2/actor-runs/{runId}/request-queue/requests/{requestId}{?token}`
  [Request collection](#/reference/request-queues/request)
  * `/v2/actor-runs/{runId}/request-queue/head{?token}` [Queue
  head](#/reference/request-queues/queue-head)

  For example, to download data from a dataset of the Actor run in XML format,
  send HTTP GET request to the following URL:

  ```
  https://api.apify.com/v2/actor-runs/{runId}/dataset/items?format=xml
  ```

  In order to save new items to the dataset, send HTTP POST request with JSON
  payload to the same URL.

  Gets an object that contains all the details about a
  specific run of an Actor.

  By passing the optional `waitForFinish` parameter the API endpoint will synchronously wait
  for the run to finish. This is useful to avoid periodic polling when waiting for Actor run to complete.

  This endpoint does not require the authentication token. Instead, calls are authenticated using a hard-to-guess ID of the run. However,
  if you access the endpoint without the token, certain attributes, such as `usageUsd` and `usageTotalUsd`, will be hidden.


  ## Options

    * `waitForFinish`: The maximum number of seconds the server waits for the run to finish. By
      default it is `0`, the maximum value is `60`. <!--
      MAX_ACTOR_JOB_ASYNC_WAIT_SECS -->
      If the build finishes in time then the returned run object will have a terminal status (e.g. `SUCCEEDED`),
      otherwise it will have a transitional status (e.g. `RUNNING`).
      

  """
  @spec actor_run_get(runId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def actor_run_get(runId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:waitForFinish])

    client.request(%{
      args: [runId: runId],
      call: {Apify.ActorRuns, :actor_run_get},
      url: "/v2/actor-runs/#{runId}",
      method: :get,
      query: query,
      response: [{200, {Apify.ActorRuns, :actor_run_get_200_json_resp}}],
      opts: opts
    })
  end

  @doc """
  Metamorph run

  Transforms an Actor run into a run of another Actor with a new input.

  This is useful if you want to use another Actor to finish the work
  of your current Actor run, without the need to create a completely new run
  and waiting for its finish.

  For the users of your Actors, the metamorph operation is transparent, they
  will just see your Actor got the work done.

  Internally, the system stops the Docker container corresponding to the Actor
  run and starts a new container using a different Docker image.

  All the default storages are preserved and the new input is stored under the
  `INPUT-METAMORPH-1` key in the same default key-value store.

  For more information, see the [Actor docs](https://docs.apify.com/platform/actors/development/programming-interface/metamorph).


  ## Options

    * `targetActorId`: ID of a target Actor that the run should be transformed into.
    * `build`: Optional build of the target Actor.
      
      It can be either a build tag or build number. By default, the run uses
      the build specified in the default run configuration for the target
      Actor (typically `latest`).
      

  """
  @spec actor_run_metamorph_post(runId :: String.t(), opts :: keyword) ::
          {:ok, Apify.RunResponse.t()} | {:error, Apify.Error.t()}
  def actor_run_metamorph_post(runId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:build, :targetActorId])

    client.request(%{
      args: [runId: runId],
      call: {Apify.ActorRuns, :actor_run_metamorph_post},
      url: "/v2/actor-runs/#{runId}/metamorph",
      method: :post,
      query: query,
      response: [{200, {Apify.RunResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Update status message

  You can set a single status message on your run that will be displayed in
  the Apify Console UI. During an Actor run, you will typically do this in order
  to inform users of your Actor about the Actor's progress.

  The request body must contain `runId` and `statusMessage` properties. The
  `isStatusMessageTerminal` property is optional and it indicates if the
  status message is the very last one. In the absence of a status message, the
  platform will try to substitute sensible defaults.

  """
  @spec actor_run_put(runId :: String.t(), body :: map, opts :: keyword) ::
          {:ok, Apify.RunResponse.t()} | {:error, Apify.Error.t()}
  def actor_run_put(runId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [runId: runId, body: body],
      call: {Apify.ActorRuns, :actor_run_put},
      url: "/v2/actor-runs/#{runId}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, {Apify.RunResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Reboot run

  Reboots an Actor run and returns an object that contains all the details
  about the rebooted run.

  Only runs that are running, i.e. runs with status `RUNNING` can be rebooted.

  The run's container will be restarted, so any data not persisted in the
  key-value store, dataset, or request queue will be lost.

  """
  @spec actor_run_reboot_post(runId :: String.t(), opts :: keyword) ::
          {:ok, Apify.RunResponse.t()} | {:error, Apify.Error.t()}
  def actor_run_reboot_post(runId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [runId: runId],
      call: {Apify.ActorRuns, :actor_run_reboot_post},
      url: "/v2/actor-runs/#{runId}/reboot",
      method: :post,
      response: [{200, {Apify.RunResponse, :t}}],
      opts: opts
    })
  end

  @type actor_runs_get_200_json_resp :: %{__info__: map, data: map | nil}

  @doc """
  Get user runs list

  Gets a list of all runs for a user. The response is a list of objects, where
  each object contains basic information about a single Actor run.

  The endpoint supports pagination using the `limit` and `offset` parameters
  and it will not return more than 1000 array elements.

  By default, the records are sorted by the `startedAt` field in ascending
  order. Therefore, you can use pagination to incrementally fetch all records while
  new ones are still being created. To sort the records in descending order, use
  `desc=1` parameter. You can also filter runs by status ([available
  statuses](https://docs.apify.com/platform/actors/running/runs-and-builds#lifecycle)).


  ## Options

    * `offset`: Number of array elements that should be skipped at the start. The
      default value is `0`.
      
    * `limit`: Maximum number of array elements to return. The default value (as well
      as the maximum) is `1000`.
      
    * `desc`: If `true` or `1` then the objects are sorted by the `startedAt` field in
      descending order. By default, they are sorted in ascending order.
      
    * `status`: Return only runs with the provided status ([available
      statuses](https://docs.apify.com/platform/actors/running/runs-and-builds#lifecycle))
      

  """
  @spec actor_runs_get(opts :: keyword) :: {:ok, map} | {:error, Apify.Error.t()}
  def actor_runs_get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset, :status])

    client.request(%{
      args: [],
      call: {Apify.ActorRuns, :actor_runs_get},
      url: "/v2/actor-runs",
      method: :get,
      query: query,
      response: [{200, {Apify.ActorRuns, :actor_runs_get_200_json_resp}}],
      opts: opts
    })
  end

  @doc """
  Charge events in run

  Charge for events in the run of your [pay per event Actor](https://docs.apify.com/platform/actors/running/actors-in-store#pay-per-event).
  The event you are charging for must be one of the configured events in your Actor. If the Actor is not set up as pay per event, or if the event is not configured,
  the endpoint will return an error. The endpoint must be called from the Actor run itself, with the same API token that the run was started with.

  :::note

  Pay per events Actors are still in alpha. Please, reach out to us with any questions or feedback.

  :::

  """
  @spec post_charge_run(runId :: String.t(), body :: Apify.ChargeRunRequest.t(), opts :: keyword) ::
          :ok | {:error, Apify.Error.t()}
  def post_charge_run(runId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [runId: runId, body: body],
      call: {Apify.ActorRuns, :post_charge_run},
      url: "/v2/actor-runs/#{runId}/charge",
      body: body,
      method: :post,
      request: [{"application/json", {Apify.ChargeRunRequest, :t}}],
      response: [{201, :null}],
      opts: opts
    })
  end

  @type post_resurrect_run_200_json_resp :: %{__info__: map, data: map | nil}

  @doc """
  Resurrect run

  Resurrects a finished Actor run and returns an object that contains all the details about the resurrected run.
  Only finished runs, i.e. runs with status `FINISHED`, `FAILED`, `ABORTED` and `TIMED-OUT` can be resurrected.
  Run status will be updated to RUNNING and its container will be restarted with the same storages
  (the same behaviour as when the run gets migrated to the new server).

  For more information, see the [Actor docs](https://docs.apify.com/platform/actors/running/runs-and-builds#resurrection-of-finished-run).


  ## Options

    * `build`: Specifies the Actor build to run. It can be either a build tag or build number. By default, the run uses the build specified in the run that is being resurrected (typically `latest`).
    * `timeout`: Optional timeout for the run, in seconds. By default, the run uses a timeout specified in the run that is being resurrected.
    * `memory`

  """
  @spec post_resurrect_run(runId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def post_resurrect_run(runId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:build, :memory, :timeout])

    client.request(%{
      args: [runId: runId],
      call: {Apify.ActorRuns, :post_resurrect_run},
      url: "/v2/actor-runs/#{runId}/resurrect",
      method: :post,
      query: query,
      response: [{200, {Apify.ActorRuns, :post_resurrect_run_200_json_resp}}],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:actor_run_get_200_json_resp) do
    [data: :map]
  end

  def __fields__(:actor_runs_get_200_json_resp) do
    [data: :map]
  end

  def __fields__(:post_resurrect_run_200_json_resp) do
    [data: :map]
  end
end
