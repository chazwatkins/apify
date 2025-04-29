defmodule Apify.Actors.ActorRuns do
  @moduledoc """
  Provides API endpoints related to actors/actor runs
  """

  @default_client Apify.Client

  @doc """
  Abort run

  **[DEPRECATED]** API endpoints related to run of the Actor were moved under
  new namespace [`actor-runs`](#/reference/actor-runs). Aborts an Actor run and
  returns an object that contains all the details about the run.

  Only runs that are starting or running are aborted. For runs with status
  `FINISHED`, `FAILED`, `ABORTING` and `TIMED-OUT` this call does nothing.


  ## Options

    * `gracefully`: If true passed, the Actor run will abort gracefully.
      It will send `aborting` and `persistState` event into run and force-stop the run after 30 seconds.
      It is helpful in cases where you plan to resurrect the run later.
      

  """
  @spec act_run_abort_post(actorId :: String.t(), runId :: String.t(), opts :: keyword) ::
          {:ok, Apify.RunResponse.t()} | {:error, Apify.Error.t()}
  def act_run_abort_post(actorId, runId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:gracefully])

    client.request(%{
      args: [actorId: actorId, runId: runId],
      call: {Apify.Actors.ActorRuns, :act_run_abort_post},
      url: "/v2/acts/#{actorId}/runs/#{runId}/abort",
      method: :post,
      query: query,
      response: [{200, {Apify.RunResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get run

  **[DEPRECATED]** API endpoints related to run of the Actor were moved under
  new namespace [`actor-runs`](#/reference/actor-runs).

  Gets an object that contains all the details about a specific run of an Actor.

  By passing the optional `waitForFinish` parameter the API endpoint will
  synchronously wait for the run to finish.
  This is useful to avoid periodic polling when waiting for Actor run to
  complete.

  This endpoint does not require the authentication token. Instead, calls are authenticated using a hard-to-guess ID of the run. However,
  if you access the endpoint without the token, certain attributes, such as `usageUsd` and `usageTotalUsd`, will be hidden.


  ## Options

    * `waitForFinish`: The maximum number of seconds the server waits for the run to finish. By
      default it is `0`, the maximum value is `60`. <!-- MAX_ACTOR_JOB_ASYNC_WAIT_SECS -->
      If the build finishes in time then the returned run object will have a terminal status (e.g. `SUCCEEDED`),
      otherwise it will have a transitional status (e.g. `RUNNING`).
      

  """
  @spec act_run_get(actorId :: String.t(), runId :: String.t(), opts :: keyword) ::
          {:ok, Apify.RunResponse.t()} | {:error, Apify.Error.t()}
  def act_run_get(actorId, runId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:waitForFinish])

    client.request(%{
      args: [actorId: actorId, runId: runId],
      call: {Apify.Actors.ActorRuns, :act_run_get},
      url: "/v2/acts/#{actorId}/runs/#{runId}",
      method: :get,
      query: query,
      response: [{200, {Apify.RunResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Metamorph run

  **[DEPRECATED]** API endpoints related to run of the Actor were moved under
  new namespace [`actor-runs`](#/reference/actor-runs).Transforms an Actor run
  into a run of another Actor with a new input.

  This is useful if you want to use another Actor to finish the work
  of your current Actor run, without the need to create a completely new run
  and waiting for its finish.
  For the users of your Actors, the metamorph operation is transparent, they
  will just see your Actor got the work done.

  There is a limit on how many times you can metamorph a single run. You can
  check the limit in [the Actor runtime limits](https://docs.apify.com/platform/limits#actor-limits).

  Internally, the system stops the Docker container corresponding to the Actor
  run and starts a new container using a different Docker image.
  All the default storages are preserved and the new input is stored under the
  `INPUT-METAMORPH-1` key in the same default key-value store.

  For more information, see the [Actor
  docs](https://docs.apify.com/platform/actors/development/programming-interface/metamorph).


  ## Options

    * `targetActorId`: ID of a target Actor that the run should be transformed into.
    * `build`: Optional build of the target Actor.
      
      It can be either a build tag or build number. By default, the run uses
      the build specified in the default run configuration for the target
      Actor (typically `latest`).
      

  """
  @spec act_run_metamorph_post(actorId :: String.t(), runId :: String.t(), opts :: keyword) ::
          {:ok, Apify.RunResponse.t()} | {:error, Apify.Error.t()}
  def act_run_metamorph_post(actorId, runId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:build, :targetActorId])

    client.request(%{
      args: [actorId: actorId, runId: runId],
      call: {Apify.Actors.ActorRuns, :act_run_metamorph_post},
      url: "/v2/acts/#{actorId}/runs/#{runId}/metamorph",
      method: :post,
      query: query,
      response: [{200, {Apify.RunResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Resurrect run

  **[DEPRECATED]** API endpoints related to run of the Actor were moved under
  new namespace [`actor-runs`](#/reference/actor-runs).Resurrects a finished
  Actor run and returns an object that contains all the details about the
  resurrected run.

  Only finished runs, i.e. runs with status `FINISHED`, `FAILED`, `ABORTED`
  and `TIMED-OUT` can be resurrected.
  Run status will be updated to RUNNING and its container will be restarted
  with the same storages
  (the same behaviour as when the run gets migrated to the new server).

  For more information, see the [Actor
  docs](https://docs.apify.com/platform/actors/running/runs-and-builds#resurrection-of-finished-run).


  ## Options

    * `build`: Specifies the Actor build to run. It can be either a build tag or build
      number. By default, the run uses the build specified in the run that is
      being resurrected (typically `latest`).
      
    * `timeout`: Optional timeout for the run, in seconds. By default, the run uses a
      timeout specified in the run that is being resurrected.
      
    * `memory`: Memory limit for the run, in megabytes. The amount of memory can be set
      to a power of 2 with a minimum of 128. By default, the run uses a memory
      limit specified in the run that is being resurrected.
      

  """
  @spec act_run_resurrect_post(actorId :: String.t(), runId :: String.t(), opts :: keyword) ::
          {:ok, Apify.RunResponse.t()} | {:error, Apify.Error.t()}
  def act_run_resurrect_post(actorId, runId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:build, :memory, :timeout])

    client.request(%{
      args: [actorId: actorId, runId: runId],
      call: {Apify.Actors.ActorRuns, :act_run_resurrect_post},
      url: "/v2/acts/#{actorId}/runs/#{runId}/resurrect",
      method: :post,
      query: query,
      response: [{200, {Apify.RunResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Without input

  Runs a specific Actor and returns its output.
  The run must finish in 300<!-- MAX_ACTOR_JOB_SYNC_WAIT_SECS --> seconds
  otherwise the API endpoint returns a timeout error.
  The Actor is not passed any input.

  Beware that it might be impossible to maintain an idle HTTP connection for a
  long period of time,
  due to client timeout or network conditions. Make sure your HTTP client is
  configured to have a long enough connection timeout.
  If the connection breaks, you will not receive any information about the run
  and its status.

  To run the Actor asynchronously, use the [Run
  Actor](#/reference/actors/run-collection/run-actor) API endpoint instead.


  ## Options

    * `outputRecordKey`: Key of the record from run's default key-value store to be returned
      in the response. By default, it is `OUTPUT`.
      
    * `timeout`: Optional timeout for the run, in seconds. By default, the run uses a
      timeout specified in the default run configuration for the Actor.
      
    * `memory`: Memory limit for the run, in megabytes. The amount of memory can be set
      to a power of 2 with a minimum of 128. By default, the run uses a memory
      limit specified in the default run configuration for the Actor.
      
    * `maxItems`: The maximum number of items that the Actor run should return. This is
      useful for pay-per-result Actors, as it allows you to limit the number
      of results that will be charged to your subscription. You can access the
      maximum number of items in your Actor by using the
      `ACTOR_MAX_PAID_DATASET_ITEMS` environment variable.
      
    * `maxTotalChargeUsd`: Specifies the maximum cost of the Actor run. This parameter is
      useful for pay-per-event Actors, as it allows you to limit the amount
      charged to your subscription. You can access the
      maximum cost in your Actor by using the
      `ACTOR_MAX_TOTAL_CHARGE_USD` environment variable.
      
    * `build`: Specifies the Actor build to run. It can be either a build tag or build
      number. By default, the run uses the build specified in the default run
      configuration for the Actor (typically `latest`).
      
    * `webhooks`: Specifies optional webhooks associated with the Actor run, which can be
      used to receive a notification
      e.g. when the Actor finished or failed. The value is a Base64-encoded
      JSON array of objects defining the webhooks. For more information, see
      [Webhooks documentation](https://docs.apify.com/platform/integrations/webhooks).
      

  """
  @spec act_run_sync_get(actorId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def act_run_sync_get(actorId, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :build,
        :maxItems,
        :maxTotalChargeUsd,
        :memory,
        :outputRecordKey,
        :timeout,
        :webhooks
      ])

    client.request(%{
      args: [actorId: actorId],
      call: {Apify.Actors.ActorRuns, :act_run_sync_get},
      url: "/v2/acts/#{actorId}/run-sync",
      method: :get,
      query: query,
      response: [{201, :map}, {400, {Apify.ErrorResponse, :t}}, {408, {Apify.ErrorResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Run Actor synchronously without input and get dataset items

  Runs a specific Actor and returns its dataset items.
  The run must finish in 300<!-- MAX_ACTOR_JOB_SYNC_WAIT_SECS --> seconds
  otherwise the API endpoint returns a timeout error.
  The Actor is not passed any input.

  It allows to send all possible options in parameters from [Get Dataset
  Items](#/reference/datasets/item-collection/get-items) API endpoint.

  Beware that it might be impossible to maintain an idle HTTP connection for a
  long period of time,
  due to client timeout or network conditions. Make sure your HTTP client is
  configured to have a long enough connection timeout.
  If the connection breaks, you will not receive any information about the run
  and its status.

  To run the Actor asynchronously, use the [Run
  Actor](#/reference/actors/run-collection/run-actor) API endpoint instead.


  ## Options

    * `timeout`: Optional timeout for the run, in seconds. By default, the run uses a
      timeout specified in the default run configuration for the Actor.
      
    * `memory`: Memory limit for the run, in megabytes. The amount of memory can be set
      to a power of 2 with a minimum of 128. By default, the run uses a memory
      limit specified in the default run configuration for the Actor.
      
    * `maxItems`: The maximum number of items that the Actor run should return. This is
      useful for pay-per-result Actors, as it allows you to limit the number
      of results that will be charged to your subscription. You can access the
      maximum number of items in your Actor by using the
      `ACTOR_MAX_PAID_DATASET_ITEMS` environment variable.
      
    * `maxTotalChargeUsd`: Specifies the maximum cost of the Actor run. This parameter is
      useful for pay-per-event Actors, as it allows you to limit the amount
      charged to your subscription. You can access the
      maximum cost in your Actor by using the
      `ACTOR_MAX_TOTAL_CHARGE_USD` environment variable.
      
    * `build`: Specifies the Actor build to run. It can be either a build tag or build
      number. By default, the run uses the build specified in the default run
      configuration for the Actor (typically `latest`).
      
    * `webhooks`: Specifies optional webhooks associated with the Actor run, which can be
      used to receive a notification
      e.g. when the Actor finished or failed. The value is a Base64-encoded
      JSON array of objects defining the webhooks. For more information, see
      [Webhooks documentation](https://docs.apify.com/platform/integrations/webhooks).
      
    * `format`: Format of the results, possible values are: `json`, `jsonl`, `csv`,
      `html`, `xlsx`, `xml` and `rss`. The default value is `json`.
      
    * `clean`: If `true` or `1` then the API endpoint returns only non-empty items and
      skips hidden fields (i.e. fields starting with the # character).
      The `clean` parameter is just a shortcut for `skipHidden=true` and `skipEmpty=true` parameters.
      Note that since some objects might be skipped from the output, that the
      result might contain less items than the `limit` value.
      
    * `offset`: Number of items that should be skipped at the start. The default value is `0`.
      
    * `limit`: Maximum number of items to return. By default there is no limit.
    * `fields`: A comma-separated list of fields which should be picked from the items,
      only these fields will remain in the resulting record objects.
      Note that the fields in the outputted items are sorted the same way as
      they are specified in the `fields` query parameter.
      You can use this feature to effectively fix the output format.
      
    * `omit`: A comma-separated list of fields which should be omitted from the items.
    * `unwind`: A comma-separated list of fields which should be unwound, in order which
      they should be processed. Each field should be either an array or an object.
      If the field is an array then every element of
      the array will become a separate record and merged with parent object.
      If the unwound field is an object then it is merged with the parent object
      If the unwound field is missing or its value is neither an array nor an
      object and therefore cannot be merged with a parent object then the item
      gets preserved as it is.
      Note that the unwound items ignore the `desc` parameter.
      
    * `flatten`: A comma-separated list of fields which should transform nested objects into flat structures.
      For example, with `flatten="foo"` the object `{"foo":{"bar": "hello"}}` is turned into `{"foo.bar": "hello"}`.
      The original object with properties is replaced with the flattened object.
      
    * `desc`: By default, results are returned in the same order as they were stored.
      To reverse the order, set this parameter to `true` or `1`.
      
    * `attachment`: If `true` or `1` then the response will define the `Content-Disposition:
      attachment` header, forcing a web browser to download the file rather
      than to display it. By default this header is not present.
      
    * `delimiter`: A delimiter character for CSV files, only used if `format=csv`. You
      might need to URL-encode the character (e.g. use `%09` for tab or `%3B`
      for semicolon). The default delimiter is a simple comma (`,`).
      
    * `bom`: All text responses are encoded in UTF-8 encoding. By default, the `format=csv` files are prefixed with
      the UTF-8 Byte Order Mark (BOM), while `json`, `jsonl`, `xml`, `html` and `rss` files are not.
      If you want to override this default behavior, specify `bom=1` query
      parameter to include the BOM or `bom=0` to skip it.
      
    * `xmlRoot`: Overrides default root element name of `xml` output. By default the root
      element is `items`.
      
    * `xmlRow`: Overrides default element name that wraps each page or page function
      result object in `xml` output. By default the element name is `item`.
      
    * `skipHeaderRow`: If `true` or `1` then header row in the `csv` format is skipped.
    * `skipHidden`: If `true` or `1` then hidden fields are skipped from the output,
      i.e. fields starting with the `#` character.
      
    * `skipEmpty`: If `true` or `1` then empty items are skipped from the output.
      
      Note that if used, the results might contain less items than the limit
      value.
      
    * `simplified`: If `true` or `1` then, the endpoint applies the `fields=url,pageFunctionResult,errorInfo`
      and `unwind=pageFunctionResult` query parameters. This feature is used
      to emulate simplified results provided by the
      legacy Apify Crawler product and it's not recommended to use it in new integrations.
      
    * `skipFailedPages`: If `true` or `1` then, the all the items with errorInfo property will be
      skipped from the output.
      This feature is here to emulate functionality of API version 1 used for
      the legacy Apify Crawler product and it's not recommended to use it in
      new integrations.
      

  """
  @spec act_run_sync_get_dataset_items_get(actorId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def act_run_sync_get_dataset_items_get(actorId, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :attachment,
        :bom,
        :build,
        :clean,
        :delimiter,
        :desc,
        :fields,
        :flatten,
        :format,
        :limit,
        :maxItems,
        :maxTotalChargeUsd,
        :memory,
        :offset,
        :omit,
        :simplified,
        :skipEmpty,
        :skipFailedPages,
        :skipHeaderRow,
        :skipHidden,
        :timeout,
        :unwind,
        :webhooks,
        :xmlRoot,
        :xmlRow
      ])

    client.request(%{
      args: [actorId: actorId],
      call: {Apify.Actors.ActorRuns, :act_run_sync_get_dataset_items_get},
      url: "/v2/acts/#{actorId}/run-sync-get-dataset-items",
      method: :get,
      query: query,
      response: [{201, :map}, {400, {Apify.ErrorResponse, :t}}, {408, {Apify.ErrorResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Run Actor synchronously with input and get dataset items

  Runs a specific Actor and returns its dataset items.

  The POST payload including its `Content-Type` header is passed as `INPUT` to
  the Actor (usually `application/json`).
  The HTTP response contains the Actors dataset items, while the format of
  items depends on specifying dataset items' `format` parameter.

  You can send all the same options in parameters as the [Get Dataset
  Items](#/reference/datasets/item-collection/get-items) API endpoint.

  The Actor is started with the default options; you can override them using
  URL query parameters.
  If the Actor run exceeds 300<!-- MAX_ACTOR_JOB_SYNC_WAIT_SECS --> seconds,
  the HTTP response will return the 408 status code (Request Timeout).

  Beware that it might be impossible to maintain an idle HTTP connection for a
  long period of time,
  due to client timeout or network conditions. Make sure your HTTP client is
  configured to have a long enough connection timeout.
  If the connection breaks, you will not receive any information about the run
  and its status.

  To run the Actor asynchronously, use the [Run
  Actor](#/reference/actors/run-collection/run-actor) API endpoint instead.


  ## Options

    * `timeout`: Optional timeout for the run, in seconds. By default, the run uses a
      timeout specified in the default run configuration for the Actor.
      
    * `memory`: Memory limit for the run, in megabytes. The amount of memory can be set
      to a power of 2 with a minimum of 128. By default, the run uses a memory
      limit specified in the default run configuration for the Actor.
      
    * `maxItems`: The maximum number of items that the Actor run should return. This is
      useful for pay-per-result Actors, as it allows you to limit the number
      of results that will be charged to your subscription. You can access the
      maximum number of items in your Actor by using the
      `ACTOR_MAX_PAID_DATASET_ITEMS` environment variable.
      
    * `maxTotalChargeUsd`: Specifies the maximum cost of the Actor run. This parameter is
      useful for pay-per-event Actors, as it allows you to limit the amount
      charged to your subscription. You can access the
      maximum cost in your Actor by using the
      `ACTOR_MAX_TOTAL_CHARGE_USD` environment variable.
      
    * `build`: Specifies the Actor build to run. It can be either a build tag or build
      number. By default, the run uses the build specified in the default run
      configuration for the Actor (typically `latest`).
      
    * `webhooks`: Specifies optional webhooks associated with the Actor run, which can be
      used to receive a notification
      e.g. when the Actor finished or failed. The value is a Base64-encoded
      JSON array of objects defining the webhooks. For more information, see
      [Webhooks documentation](https://docs.apify.com/platform/integrations/webhooks).
      
    * `format`: Format of the results, possible values are: `json`, `jsonl`, `csv`,
      `html`, `xlsx`, `xml` and `rss`. The default value is `json`.
      
    * `clean`: If `true` or `1` then the API endpoint returns only non-empty items and
      skips hidden fields (i.e. fields starting with the # character).
      The `clean` parameter is just a shortcut for `skipHidden=true` and
      `skipEmpty=true` parameters.
      Note that since some objects might be skipped from the output, that the
      result might contain less items than the `limit` value.
      
    * `offset`: Number of items that should be skipped at the start. The default value
      is `0`.
      
    * `limit`: Maximum number of items to return. By default there is no limit.
    * `fields`: A comma-separated list of fields which should be picked from the items,
      only these fields will remain in the resulting record objects.
      Note that the fields in the outputted items are sorted the same way as
      they are specified in the `fields` query parameter.
      You can use this feature to effectively fix the output format.
      
    * `omit`: A comma-separated list of fields which should be omitted from the items.
    * `unwind`: A comma-separated list of fields which should be unwound, in order which
      they should be processed. Each field should be either an array or an object.
      If the field is an array then every element of
      the array will become a separate record and merged with parent object.
      If the unwound field is an object then it is merged with the parent object.
      If the unwound field is missing or its value is neither an array nor an
      object and therefore cannot be merged with a parent object then the item
      gets preserved as it is.
      Note that the unwound items ignore the `desc` parameter.
      
    * `flatten`: A comma-separated list of fields which should transform nested objects
      into flat structures.
      For example, with `flatten="foo"` the object `{"foo":{"bar": "hello"}}`
      is turned into `{"foo.bar": "hello"}`.
      The original object with properties is replaced with the flattened
      object.
      
    * `desc`: By default, results are returned in the same order as they were stored.
      To reverse the order, set this parameter to `true` or `1`.
      
    * `attachment`: If `true` or `1` then the response will define the `Content-Disposition:
      attachment` header, forcing a web browser to download the file rather
      than to display it. By default this header is not present.
      
    * `delimiter`: A delimiter character for CSV files, only used if `format=csv`. You
      might need to URL-encode the character (e.g. use `%09` for tab or `%3B`
      for semicolon). The default delimiter is a simple comma (`,`).
      
    * `bom`: All text responses are encoded in UTF-8 encoding. By default, the
      `format=csv` files are prefixed with
      the UTF-8 Byte Order Mark (BOM), while `json`, `jsonl`, `xml`, `html`
      and `rss` files are not.
      If you want to override this default behavior, specify `bom=1` query
      parameter to include the BOM or `bom=0` to skip it.
      
    * `xmlRoot`: Overrides default root element name of `xml` output. By default the root
      element is `items`.
      
    * `xmlRow`: Overrides default element name that wraps each page or page function
      result object in `xml` output. By default the element name is `item`.
      
    * `skipHeaderRow`: If `true` or `1` then header row in the `csv` format is skipped.
    * `skipHidden`: If `true` or `1` then hidden fields are skipped from the output,
      i.e. fields starting with the `#` character.
      
    * `skipEmpty`: If `true` or `1` then empty items are skipped from the output.
      
      Note that if used, the results might contain less items than the limit
      value.
      
    * `simplified`: If `true` or `1` then, the endpoint applies the
      `fields=url,pageFunctionResult,errorInfo`
      and `unwind=pageFunctionResult` query parameters. This feature is used
      to emulate simplified results provided by the
      legacy Apify Crawler product and it's not recommended to use it in new
      integrations.
      
    * `skipFailedPages`: If `true` or `1` then, the all the items with errorInfo property will be
      skipped from the output.
      This feature is here to emulate functionality of API version 1 used for
      the legacy Apify Crawler product and it's not recommended to use it in
      new integrations.
      

  """
  @spec act_run_sync_get_dataset_items_post(actorId :: String.t(), body :: map, opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def act_run_sync_get_dataset_items_post(actorId, body, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :attachment,
        :bom,
        :build,
        :clean,
        :delimiter,
        :desc,
        :fields,
        :flatten,
        :format,
        :limit,
        :maxItems,
        :maxTotalChargeUsd,
        :memory,
        :offset,
        :omit,
        :simplified,
        :skipEmpty,
        :skipFailedPages,
        :skipHeaderRow,
        :skipHidden,
        :timeout,
        :unwind,
        :webhooks,
        :xmlRoot,
        :xmlRow
      ])

    client.request(%{
      args: [actorId: actorId, body: body],
      call: {Apify.Actors.ActorRuns, :act_run_sync_get_dataset_items_post},
      url: "/v2/acts/#{actorId}/run-sync-get-dataset-items",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", :map}],
      response: [{201, :map}, {400, {Apify.ErrorResponse, :t}}, {408, {Apify.ErrorResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Run Actor synchronously with input and return output

  Runs a specific Actor and returns its output.

  The POST payload including its `Content-Type` header is passed as `INPUT` to
  the Actor (usually <code>application/json</code>).
  The HTTP response contains Actors `OUTPUT` record from its default
  key-value store.

  The Actor is started with the default options; you can override them using
  various URL query parameters.
  If the Actor run exceeds 300<!-- MAX_ACTOR_JOB_SYNC_WAIT_SECS --> seconds,
  the HTTP response will have status 408 (Request Timeout).

  Beware that it might be impossible to maintain an idle HTTP connection for a
  long period of time, due to client timeout or network conditions. Make sure your HTTP client is
  configured to have a long enough connection timeout.
  If the connection breaks, you will not receive any information about the run
  and its status.

  To run the Actor asynchronously, use the [Run
  Actor](#/reference/actors/run-collection/run-actor) API endpoint instead.


  ## Options

    * `outputRecordKey`: Key of the record from run's default key-value store to be returned
      in the response. By default, it is `OUTPUT`.
      
    * `timeout`: Optional timeout for the run, in seconds. By default, the run uses a
      timeout specified in the default run configuration for the Actor.
      
    * `memory`: Memory limit for the run, in megabytes. The amount of memory can be set
      to a power of 2 with a minimum of 128. By default, the run uses a memory
      limit specified in the default run configuration for the Actor.
      
    * `maxItems`: The maximum number of items that the Actor run should return. This is
      useful for pay-per-result Actors, as it allows you to limit the number
      of results that will be charged to your subscription. You can access the
      maximum number of items in your Actor by using the
      `ACTOR_MAX_PAID_DATASET_ITEMS` environment variable.
      
    * `maxTotalChargeUsd`: Specifies the maximum cost of the Actor run. This parameter is
      useful for pay-per-event Actors, as it allows you to limit the amount
      charged to your subscription. You can access the
      maximum cost in your Actor by using the
      `ACTOR_MAX_TOTAL_CHARGE_USD` environment variable.
      
    * `build`: Specifies the Actor build to run. It can be either a build tag or build
      number. By default, the run uses the build specified in the default run
      configuration for the Actor (typically `latest`).
      
    * `webhooks`: Specifies optional webhooks associated with the Actor run, which can be
      used to receive a notification
      e.g. when the Actor finished or failed. The value is a Base64-encoded
      JSON array of objects defining the webhooks. For more information, see
      [Webhooks documentation](https://docs.apify.com/platform/integrations/webhooks).
      

  """
  @spec act_run_sync_post(actorId :: String.t(), body :: map, opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def act_run_sync_post(actorId, body, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :build,
        :maxItems,
        :maxTotalChargeUsd,
        :memory,
        :outputRecordKey,
        :timeout,
        :webhooks
      ])

    client.request(%{
      args: [actorId: actorId, body: body],
      call: {Apify.Actors.ActorRuns, :act_run_sync_post},
      url: "/v2/acts/#{actorId}/run-sync",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", :map}],
      response: [{201, :map}, {400, {Apify.ErrorResponse, :t}}, {408, {Apify.ErrorResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get list of runs

  Gets the list of runs of a specific Actor. The response is a list of
  objects, where each object contains basic information about a single Actor run.

  The endpoint supports pagination using the `limit` and `offset` parameters
  and it will not return more than 1000 array elements.

  By default, the records are sorted by the `startedAt` field in ascending
  order, therefore you can use pagination to incrementally fetch all records while
  new ones are still being created. To sort the records in descending order, use
  `desc=1` parameter. You can also filter runs by status ([available
  statuses](https://docs.apify.com/platform/actors/running/runs-and-builds#lifecycle)).


  ## Options

    * `offset`: Number of array elements that should be skipped at the start. The
      default value is `0`.
      
    * `limit`: Maximum number of array elements to return. The default value as well as
      the maximum is `1000`.
      
    * `desc`: If `true` or `1` then the objects are sorted by the `startedAt` field in
      descending order. By default, they are sorted in ascending order.
      
    * `status`: Return only runs with the provided status ([available
      statuses](https://docs.apify.com/platform/actors/running/runs-and-builds#lifecycle))
      

  """
  @spec act_runs_get(actorId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetUserRunsListResponse.t()} | {:error, Apify.Error.t()}
  def act_runs_get(actorId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset, :status])

    client.request(%{
      args: [actorId: actorId],
      call: {Apify.Actors.ActorRuns, :act_runs_get},
      url: "/v2/acts/#{actorId}/runs",
      method: :get,
      query: query,
      response: [{200, {Apify.GetUserRunsListResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get last run

  This is not a single endpoint, but an entire group of endpoints that lets you to
  retrieve and manage the last run of given Actor or any of its default storages.
  All the endpoints require an authentication token.

  The endpoints accept the same HTTP methods and query parameters as
  the respective storage endpoints.
  The base path represents the last Actor run object is:

  `/v2/acts/{actorId}/runs/last{?token,status}`

  Using the `status` query parameter you can ensure to only get a run with a certain status
  (e.g. `status=SUCCEEDED`). The output of this endpoint and other query parameters
  are the same as in the [Run object](#/reference/actors/run-object) endpoint.

  In order to access the default storages of the last Actor run, i.e. log, key-value store, dataset and request queue,
  use the following endpoints:

  * `/v2/acts/{actorId}/runs/last/log{?token,status}`
  * `/v2/acts/{actorId}/runs/last/key-value-store{?token,status}`
  * `/v2/acts/{actorId}/runs/last/dataset{?token,status}`
  * `/v2/acts/{actorId}/runs/last/request-queue{?token,status}`

  These API endpoints have the same usage as the equivalent storage endpoints.
  For example,
  `/v2/acts/{actorId}/runs/last/key-value-store` has the same HTTP method and parameters as the
  [Key-value store object](#/reference/key-value-stores/store-object) endpoint.

  Additionally, each of the above API endpoints supports all sub-endpoints
  of the original one:

  #### Key-value store

  * `/v2/acts/{actorId}/runs/last/key-value-store/keys{?token,status}` [Key collection](#/reference/key-value-stores/key-collection)
  * `/v2/acts/{actorId}/runs/last/key-value-store/records/{recordKey}{?token,status}` [Record](#/reference/key-value-stores/record)

  #### Dataset

  * `/v2/acts/{actorId}/runs/last/dataset/items{?token,status}` [Item collection](#/reference/datasets/item-collection)

  #### Request queue

  * `/v2/acts/{actorId}/runs/last/request-queue/requests{?token,status}` [Request collection](#/reference/request-queues/request-collection)
  * `/v2/acts/{actorId}/runs/last/request-queue/requests/{requestId}{?token,status}` [Request collection](#/reference/request-queues/request)
  * `/v2/acts/{actorId}/runs/last/request-queue/head{?token,status}` [Queue head](#/reference/request-queues/queue-head)

  For example, to download data from a dataset of the last succeeded Actor run in XML format,
  send HTTP GET request to the following URL:

  ```
  https://api.apify.com/v2/acts/{actorId}/runs/last/dataset/items?token={yourApiToken}&format=xml&status=SUCCEEDED
  ```

  In order to save new items to the dataset, send HTTP POST request with JSON payload to the same URL.


  ## Options

    * `status`: Filter for the run status.

  """
  @spec act_runs_last_get(actorId :: String.t(), opts :: keyword) ::
          {:ok, Apify.RunResponse.t()} | {:error, Apify.Error.t()}
  def act_runs_last_get(actorId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:status])

    client.request(%{
      args: [actorId: actorId],
      call: {Apify.Actors.ActorRuns, :act_runs_last_get},
      url: "/v2/acts/#{actorId}/runs/last",
      method: :get,
      query: query,
      response: [{200, {Apify.RunResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Run Actor

  Runs an Actor and immediately returns without waiting for the run to finish.

  The POST payload including its `Content-Type` header is passed as `INPUT` to
  the Actor (usually `application/json`).

  The Actor is started with the default options; you can override them using
  various URL query parameters.

  The response is the Run object as returned by the [Get
  run](#/reference/actor-runs/run-object-and-its-storages/get-run) API
  endpoint.

  If you want to wait for the run to finish and receive the actual output of
  the Actor as the response, please use one of the [Run Actor
  synchronously](#/reference/actors/run-actor-synchronously) API endpoints
  instead.

  To fetch the Actor run results that are typically stored in the default
  dataset, you'll need to pass the ID received in the `defaultDatasetId` field
  received in the response JSON to the [Get items](#/reference/datasets/item-collection/get-items)
  API endpoint.


  ## Options

    * `timeout`: Optional timeout for the run, in seconds. By default, the run uses a
      timeout specified in the default run configuration for the Actor.
      
    * `memory`: Memory limit for the run, in megabytes. The amount of memory can be set
      to a power of 2 with a minimum of 128. By default, the run uses a memory
      limit specified in the default run configuration for the Actor.
      
    * `maxItems`: The maximum number of items that the Actor run should return. This is
      useful for pay-per-result Actors, as it allows you to limit the number
      of results that will be charged to your subscription. You can access the
      maximum number of items in your Actor by using the
      `ACTOR_MAX_PAID_DATASET_ITEMS` environment variable.
      
    * `maxTotalChargeUsd`: Specifies the maximum cost of the Actor run. This parameter is
      useful for pay-per-event Actors, as it allows you to limit the amount
      charged to your subscription. You can access the
      maximum cost in your Actor by using the
      `ACTOR_MAX_TOTAL_CHARGE_USD` environment variable.
      
    * `build`: Specifies the Actor build to run. It can be either a build tag or build
      number. By default, the run uses the build specified in the default run
      configuration for the Actor (typically `latest`).
      
    * `waitForFinish`: The maximum number of seconds the server waits for the run to finish. By
      default, it is `0`, the maximum value is `60`. <!-- MAX_ACTOR_JOB_ASYNC_WAIT_SECS -->
      If the build finishes in time then the returned run object will have a terminal status (e.g. `SUCCEEDED`),
      otherwise it will have a transitional status (e.g. `RUNNING`).
      
    * `webhooks`: Specifies optional webhooks associated with the Actor run, which can be
      used to receive a notification e.g. when the Actor finished or failed. The value is a Base64-encoded
      JSON array of objects defining the webhooks. For more information, see
      [Webhooks documentation](https://docs.apify.com/platform/integrations/webhooks).
      

  """
  @spec act_runs_post(actorId :: String.t(), body :: map, opts :: keyword) ::
          {:ok, Apify.RunResponse.t()} | {:error, Apify.Error.t()}
  def act_runs_post(actorId, body, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :build,
        :maxItems,
        :maxTotalChargeUsd,
        :memory,
        :timeout,
        :waitForFinish,
        :webhooks
      ])

    client.request(%{
      args: [actorId: actorId, body: body],
      call: {Apify.Actors.ActorRuns, :act_runs_post},
      url: "/v2/acts/#{actorId}/runs",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", :map}],
      response: [{201, {Apify.RunResponse, :t}}],
      opts: opts
    })
  end
end
