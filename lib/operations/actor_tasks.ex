defmodule Apify.ActorTasks do
  @moduledoc """
  Provides API endpoints related to actor tasks
  """

  @default_client Apify.Client

  @doc """
  Delete task

  Delete the task specified through the `actorTaskId` parameter.
  """
  @spec actor_task_delete(actorTaskId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def actor_task_delete(actorTaskId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorTaskId: actorTaskId],
      call: {Apify.ActorTasks, :actor_task_delete},
      url: "/v2/actor-tasks/#{actorTaskId}",
      method: :delete,
      response: [{204, :map}],
      opts: opts
    })
  end

  @type actor_task_get_200_json_resp :: %{__info__: map, data: Apify.Task.t()}

  @doc """
  Get task

  Get an object that contains all the details about a task.
  """
  @spec actor_task_get(actorTaskId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def actor_task_get(actorTaskId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorTaskId: actorTaskId],
      call: {Apify.ActorTasks, :actor_task_get},
      url: "/v2/actor-tasks/#{actorTaskId}",
      method: :get,
      response: [{200, {Apify.ActorTasks, :actor_task_get_200_json_resp}}],
      opts: opts
    })
  end

  @doc """
  Get task input

  Returns the input of a given task.
  """
  @spec actor_task_input_get(actorTaskId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def actor_task_input_get(actorTaskId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorTaskId: actorTaskId],
      call: {Apify.ActorTasks, :actor_task_input_get},
      url: "/v2/actor-tasks/#{actorTaskId}/input",
      method: :get,
      response: [{200, :map}],
      opts: opts
    })
  end

  @doc """
  Update task input

  Updates the input of a task using values specified by an object passed as
  JSON in the PUT payload.

  If the object does not define a specific property, its value is not updated.

  The response is the full task input as returned by the
  [Get task input](#/reference/tasks/task-input-object/get-task-input) endpoint.

  The request needs to specify the `Content-Type: application/json` HTTP
  header!

  When providing your API authentication token, we recommend using the
  request's `Authorization` header, rather than the URL. ([More
  info](#/introduction/authentication)).

  """
  @spec actor_task_input_put(actorTaskId :: String.t(), body :: map, opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def actor_task_input_put(actorTaskId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorTaskId: actorTaskId, body: body],
      call: {Apify.ActorTasks, :actor_task_input_put},
      url: "/v2/actor-tasks/#{actorTaskId}/input",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, :map}],
      opts: opts
    })
  end

  @type actor_task_put_200_json_resp :: %{__info__: map, data: Apify.Task.t()}

  @doc """
  Update task

  Update settings of a task using values specified by an object passed as JSON
  in the POST payload.

  If the object does not define a specific property, its value is not updated.

  The response is the full task object as returned by the
  [Get task](#/reference/tasks/task-object/get-task) endpoint.

  The request needs to specify the `Content-Type: application/json` HTTP
  header!

  When providing your API authentication token, we recommend using the
  request's `Authorization` header, rather than the URL. ([More
  info](#/introduction/authentication)).

  """
  @spec actor_task_put(
          actorTaskId :: String.t(),
          body :: Apify.UpdateTaskRequest.t(),
          opts :: keyword
        ) :: {:ok, map} | {:error, Apify.Error.t()}
  def actor_task_put(actorTaskId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [actorTaskId: actorTaskId, body: body],
      call: {Apify.ActorTasks, :actor_task_put},
      url: "/v2/actor-tasks/#{actorTaskId}",
      body: body,
      method: :put,
      request: [{"application/json", {Apify.UpdateTaskRequest, :t}}],
      response: [{200, {Apify.ActorTasks, :actor_task_put_200_json_resp}}],
      opts: opts
    })
  end

  @doc """
  Run task synchronously

  Run a specific task and return its output.

  The run must finish in 300<!-- MAX_ACTOR_JOB_SYNC_WAIT_SECS --> seconds
  otherwise the HTTP request fails with a timeout error (this won't abort
  the run itself).

  Beware that it might be impossible to maintain an idle HTTP connection for
  an extended period, due to client timeout or network conditions. Make sure your HTTP client is
  configured to have a long enough connection timeout.

  If the connection breaks, you will not receive any information about the run
  and its status.

  To run the Task asynchronously, use the
  [Run task asynchronously](#/reference/actor-tasks/run-collection/run-task)
  endpoint instead.


  ## Options

    * `timeout`: Optional timeout for the run, in seconds. By default, the run uses a
      timeout specified in the task settings.
      
    * `memory`: Memory limit for the run, in megabytes. The amount of memory can be set
      to a power of 2 with a minimum of 128. By default, the run uses a memory
      limit specified in the task settings.
      
    * `maxItems`: The maximum number of items that the task run should return. This is
      useful for pay-per-result tasks, as it allows you to limit the number of
      results that will be charged to your subscription. You can access the
      maximum number of items in your Actor by using the
      `ACTOR_MAX_PAID_DATASET_ITEMS` environment variable.
      
    * `build`: Specifies the Actor build to run. It can be either a build tag or build
      number. By default, the run uses the build specified in the task
      settings (typically `latest`).
      
    * `outputRecordKey`: Key of the record from run's default key-value store to be returned
      in the response. By default, it is `OUTPUT`.
      
    * `webhooks`: Specifies optional webhooks associated with the Actor run, which can be
      used to receive a notification
      e.g. when the Actor finished or failed. The value is a Base64-encoded
      JSON array of objects defining the webhooks. For more information, see
      [Webhooks documentation](https://docs.apify.com/platform/integrations/webhooks).
      

  """
  @spec actor_task_run_sync_get(actorTaskId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def actor_task_run_sync_get(actorTaskId, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [:build, :maxItems, :memory, :outputRecordKey, :timeout, :webhooks])

    client.request(%{
      args: [actorTaskId: actorTaskId],
      call: {Apify.ActorTasks, :actor_task_run_sync_get},
      url: "/v2/actor-tasks/#{actorTaskId}/run-sync",
      method: :get,
      query: query,
      response: [{201, :map}, {400, {Apify.ErrorResponse, :t}}, {408, {Apify.ErrorResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Run task synchronously and get dataset items

  Run a specific task and return its dataset items.

  The run must finish in 300<!-- MAX_ACTOR_JOB_SYNC_WAIT_SECS --> seconds
  otherwise the HTTP request fails with a timeout error (this won't abort
  the run itself).

  You can send all the same options in parameters as the [Get Dataset
  Items](#/reference/datasets/item-collection/get-items) API endpoint.

  Beware that it might be impossible to maintain an idle HTTP connection for
  an extended period, due to client timeout or network conditions. Make sure your HTTP client is
  configured to have a long enough connection timeout.

  If the connection breaks, you will not receive any information about the run
  and its status.

  To run the Task asynchronously, use the [Run task
  asynchronously](#/reference/actor-tasks/run-collection/run-task) endpoint
  instead.


  ## Options

    * `timeout`: Optional timeout for the run, in seconds. By default, the run uses a
      timeout specified in the task settings.
      
    * `memory`: Memory limit for the run, in megabytes. The amount of memory can be set
      to a power of 2 with a minimum of 128. By default, the run uses a memory
      limit specified in the task settings.
      
    * `maxItems`: The maximum number of items that the task run should return. This is
      useful for pay-per-result tasks, as it allows you to limit the number of
      results that will be charged to your subscription. You can access the
      maximum number of items in your Actor by using the
      `ACTOR_MAX_PAID_DATASET_ITEMS` environment variable.
      
    * `build`: Specifies the Actor build to run. It can be either a build tag or build
      number. By default, the run uses the build specified in the task
      settings (typically `latest`).
      
    * `webhooks`: Specifies optional webhooks associated with the Actor run, which can be
      used to receive a notification e.g. when the Actor finished or failed. The value is a Base64-encoded
      JSON array of objects defining the webhooks. For more information, see
      [Webhooks documentation](https://docs.apify.com/platform/integrations/webhooks).
      
    * `format`: Format of the results, possible values are: `json`, `jsonl`, `csv`,
      `html`, `xlsx`, `xml` and `rss`. The default value is `json`.
      
    * `clean`: If `true` or `1` then the API endpoint returns only non-empty items and
      skips hidden fields
      
      (i.e. fields starting with the # character).
      
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
      
      If the unwound field is an object then it is merged with the parent
      object
      
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
  @spec actor_task_run_sync_get_dataset_items_get(actorTaskId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def actor_task_run_sync_get_dataset_items_get(actorTaskId, opts \\ []) do
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
      args: [actorTaskId: actorTaskId],
      call: {Apify.ActorTasks, :actor_task_run_sync_get_dataset_items_get},
      url: "/v2/actor-tasks/#{actorTaskId}/run-sync-get-dataset-items",
      method: :get,
      query: query,
      response: [{201, :map}, {400, {Apify.ErrorResponse, :t}}, {408, {Apify.ErrorResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Run task synchronously and get dataset items

  Runs an Actor task and synchronously returns its dataset items.

  The run must finish in 300<!-- MAX_ACTOR_JOB_SYNC_WAIT_SECS --> seconds
  otherwise the HTTP request fails with a timeout error (this won't abort
  the run itself).

  Optionally, you can override the Actor input configuration by passing a JSON
  object as the POST payload and setting the `Content-Type: application/json` HTTP header.

  Note that if the object in the POST payload does not define a particular
  input property, the Actor run uses the default value defined by the task (or the Actor's
  input schema if not defined by the task).

  You can send all the same options in parameters as the [Get Dataset
  Items](#/reference/datasets/item-collection/get-items) API endpoint.

  Beware that it might be impossible to maintain an idle HTTP connection for
  an extended period, due to client timeout or network conditions. Make sure your HTTP client is
  configured to have a long enough connection timeout.

  If the connection breaks, you will not receive any information about the run
  and its status.

  Input fields from Actor task configuration can be overloaded with values
  passed as the POST payload.

  Just make sure to specify the `Content-Type` header as `application/json`
  and that the input is an object.

  To run the task asynchronously, use the [Run
  task](#/reference/actor-tasks/run-collection/run-task) API endpoint instead.


  ## Options

    * `timeout`: Optional timeout for the run, in seconds. By default, the run uses a
      timeout specified in the task settings.
      
    * `memory`: Memory limit for the run, in megabytes. The amount of memory can be set
      to a power of 2 with a minimum of 128. By default, the run uses a memory
      limit specified in the task settings.
      
    * `maxItems`: The maximum number of items that the task run should return. This is
      useful for pay-per-result tasks, as it allows you to limit the number of
      results that will be charged to your subscription. You can access the
      maximum number of items in your Actor by using the
      `ACTOR_MAX_PAID_DATASET_ITEMS` environment variable.
      
    * `maxTotalChargeUsd`: Specifies the maximum cost of the task run. This is
      useful for pay-per-event tasks, as it allows you to limit the amount
      charged to your subscription. You can access the
      maximum cost in your Actor by using the
      `ACTOR_MAX_TOTAL_CHARGE_USD` environment variable.
      
    * `build`: Specifies the Actor build to run. It can be either a build tag or build
      number. By default, the run uses the build specified in the task
      settings (typically `latest`).
      
    * `webhooks`: Specifies optional webhooks associated with the Actor run, which can be
      used to receive a notification
      e.g. when the Actor finished or failed. The value is a Base64-encoded
      JSON array of objects defining the webhooks. For more information, see
      [Webhooks
      documentation](https://docs.apify.com/platform/integrations/webhooks).
      
    * `format`: Format of the results, possible values are: `json`, `jsonl`, `csv`,
      `html`, `xlsx`, `xml` and `rss`. The default value is `json`.
      
    * `clean`: If `true` or `1` then the API endpoint returns only non-empty items and
      skips hidden fields
      (i.e. fields starting with the # character).
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
      If the unwound field is an object then it is merged with the parent
      object
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
  @spec actor_task_run_sync_get_dataset_items_post(
          actorTaskId :: String.t(),
          body :: map,
          opts :: keyword
        ) :: {:ok, map} | {:error, Apify.Error.t()}
  def actor_task_run_sync_get_dataset_items_post(actorTaskId, body, opts \\ []) do
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
      args: [actorTaskId: actorTaskId, body: body],
      call: {Apify.ActorTasks, :actor_task_run_sync_get_dataset_items_post},
      url: "/v2/actor-tasks/#{actorTaskId}/run-sync-get-dataset-items",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", :map}],
      response: [{201, :map}, {400, {Apify.ErrorResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Run task synchronously

  Runs an Actor task and synchronously returns its output.

  The run must finish in 300<!-- MAX_ACTOR_JOB_SYNC_WAIT_SECS --> seconds
  otherwise the HTTP request fails with a timeout error (this won't abort
  the run itself).

  Optionally, you can override the Actor input configuration by passing a JSON
  object as the POST payload and setting the `Content-Type: application/json` HTTP header.

  Note that if the object in the POST payload does not define a particular
  input property, the Actor run uses the default value defined by the task (or Actor's input
  schema if not defined by the task).

  Beware that it might be impossible to maintain an idle HTTP connection for
  an extended period, due to client timeout or network conditions. Make sure your HTTP client is
  configured to have a long enough connection timeout.

  If the connection breaks, you will not receive any information about the run
  and its status.

  Input fields from Actor task configuration can be overloaded with values
  passed as the POST payload.

  Just make sure to specify `Content-Type` header to be `application/json` and
  input to be an object.

  To run the task asynchronously, use the [Run
  task](#/reference/actor-tasks/run-collection/run-task) API endpoint instead.


  ## Options

    * `timeout`: Optional timeout for the run, in seconds. By default, the run uses a
      timeout specified in the task settings.
      
    * `memory`: Memory limit for the run, in megabytes. The amount of memory can be set
      to a power of 2 with a minimum of 128. By default, the run uses a memory
      limit specified in the task settings.
      
    * `maxItems`: The maximum number of items that the task run should return. This is
      useful for pay-per-result tasks, as it allows you to limit the number of
      results that will be charged to your subscription. You can access the
      maximum number of items in your Actor by using the
      `ACTOR_MAX_PAID_DATASET_ITEMS` environment variable.
      
    * `maxTotalChargeUsd`: Specifies the maximum cost of the task run. This parameter is
      useful for pay-per-event tasks, as it allows you to limit the amount
      charged to your subscription. You can access the
      maximum cost in your Actor by using the
      `ACTOR_MAX_TOTAL_CHARGE_USD` environment variable.
      
    * `build`: Specifies the Actor build to run. It can be either a build tag or build
      number. By default, the run uses the build specified in the task
      settings (typically `latest`).
      
    * `outputRecordKey`: Key of the record from run's default key-value store to be returned
      in the response. By default, it is `OUTPUT`.
      
    * `webhooks`: Specifies optional webhooks associated with the Actor run, which can be
      used to receive a notification
      
      e.g. when the Actor finished or failed. The value is a Base64-encoded
      JSON array of objects defining the webhooks. For more information, see
      
      [Webhooks
      documentation](https://docs.apify.com/platform/integrations/webhooks).
      

  """
  @spec actor_task_run_sync_post(actorTaskId :: String.t(), body :: map, opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def actor_task_run_sync_post(actorTaskId, body, opts \\ []) do
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
      args: [actorTaskId: actorTaskId, body: body],
      call: {Apify.ActorTasks, :actor_task_run_sync_post},
      url: "/v2/actor-tasks/#{actorTaskId}/run-sync",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", :map}],
      response: [{201, :map}, {400, {Apify.ErrorResponse, :t}}],
      opts: opts
    })
  end

  @type actor_task_runs_get_200_json_resp :: %{
          __info__: map,
          data: Apify.ActorTasksData.actor_task_runs_get_200_json_resp()
        }

  @doc """
  Get list of task runs

  Get a list of runs of a specific task. The response is a list of objects,
  where each object contains essential information about a single task run.

  The endpoint supports pagination using the `limit` and `offset` parameters,
  and it does not return more than a 1000 array elements.

  By default, the records are sorted by the `startedAt` field in ascending
  order; therefore you can use pagination to incrementally fetch all records while
  new ones are still being created. To sort the records in descending order, use
  the `desc=1` parameter. You can also filter runs by status ([available
  statuses](https://docs.apify.com/platform/actors/running/runs-and-builds#lifecycle)).


  ## Options

    * `offset`: Number of array elements that should be skipped at the start. The default value is `0`.
      
    * `limit`: Maximum number of array elements to return. The default value as well as the maximum is `1000`.
      
    * `desc`: If `true` or `1` then the objects are sorted by the `startedAt` field in
      descending order. By default, they are sorted in ascending order.
      
    * `status`: Return only runs with the provided status ([available
      statuses](https://docs.apify.com/platform/actors/running/runs-and-builds#lifecycle))
      

  """
  @spec actor_task_runs_get(actorTaskId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def actor_task_runs_get(actorTaskId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset, :status])

    client.request(%{
      args: [actorTaskId: actorTaskId],
      call: {Apify.ActorTasks, :actor_task_runs_get},
      url: "/v2/actor-tasks/#{actorTaskId}/runs",
      method: :get,
      query: query,
      response: [{200, {Apify.ActorTasks, :actor_task_runs_get_200_json_resp}}],
      opts: opts
    })
  end

  @type actor_task_runs_last_get_200_json_resp :: %{__info__: map, data: Apify.Run.t()}

  @doc """
  Get last run

  This is not a single endpoint, but an entire group of endpoints that lets you to
  retrieve and manage the last run of given actor task or any of its default storages.
  All the endpoints require an authentication token.

  The endpoints accept the same HTTP methods and query parameters as
  the respective storage endpoints.
  The base path represents the last actor task run object is:

  `/v2/actor-tasks/{actorTaskId}/runs/last{?token,status}`

  Using the `status` query parameter you can ensure to only get a run with a certain status
  (e.g. `status=SUCCEEDED`). The output of this endpoint and other query parameters
  are the same as in the [Run object](/api/v2/actor-run-get) endpoint.

  In order to access the default storages of the last actor task run, i.e. log, key-value store, dataset and request queue,
  use the following endpoints:

  * `/v2/actor-tasks/{actorTaskId}/runs/last/log{?token,status}`
  * `/v2/actor-tasks/{actorTaskId}/runs/last/key-value-store{?token,status}`
  * `/v2/actor-tasks/{actorTaskId}/runs/last/dataset{?token,status}`
  * `/v2/actor-tasks/{actorTaskId}/runs/last/request-queue{?token,status}`

  These API endpoints have the same usage as the equivalent storage endpoints.
  For example,
  `/v2/actor-tasks/{actorTaskId}/runs/last/key-value-store` has the same HTTP method and parameters as the
  [Key-value store object](/api/v2/storage-key-value-stores) endpoint.

  Additionally, each of the above API endpoints supports all sub-endpoints
  of the original one:

  ##### Storage endpoints

  * [Dataset - introduction](/api/v2/storage-datasets)

  * [Key-value store - introduction](/api/v2/storage-key-value-stores)

  * [Request queue - introduction](/api/v2/storage-request-queues)

  For example, to download data from a dataset of the last succeeded actor task run in XML format,
  send HTTP GET request to the following URL:

  ```
  https://api.apify.com/v2/actor-tasks/{actorTaskId}/runs/last/dataset/items?token={yourApiToken}&format=xml&status=SUCCEEDED
  ```

  In order to save new items to the dataset, send HTTP POST request with JSON payload to the same URL.


  ## Options

    * `status`: Filter for the run status.

  """
  @spec actor_task_runs_last_get(actorTaskId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def actor_task_runs_last_get(actorTaskId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:status])

    client.request(%{
      args: [actorTaskId: actorTaskId],
      call: {Apify.ActorTasks, :actor_task_runs_last_get},
      url: "/v2/actor-tasks/#{actorTaskId}/runs/last",
      method: :get,
      query: query,
      response: [{200, {Apify.ActorTasks, :actor_task_runs_last_get_200_json_resp}}],
      opts: opts
    })
  end

  @type actor_task_runs_post_201_json_resp :: %{__info__: map, data: Apify.Run.t()}

  @doc """
  Run task

  Runs an Actor task and immediately returns without waiting for the run to
  finish.

  Optionally, you can override the Actor input configuration by passing a JSON
  object as the POST payload and setting the `Content-Type: application/json` HTTP header.

  Note that if the object in the POST payload does not define a particular
  input property, the Actor run uses the default value defined by the task (or Actor's input
  schema if not defined by the task).

  The response is the Actor Run object as returned by the [Get
  run](#/reference/actor-runs/run-object-and-its-storages/get-run) endpoint.

  If you want to wait for the run to finish and receive the actual output of
  the Actor run as the response, use one of the [Run task
  synchronously](#/reference/actor-tasks/run-task-synchronously) API endpoints
  instead.

  To fetch the Actor run results that are typically stored in the default
  dataset, you'll need to pass the ID received in the `defaultDatasetId` field
  received in the response JSON to the
  [Get items](#/reference/datasets/item-collection/get-items) API endpoint.


  ## Options

    * `timeout`: Optional timeout for the run, in seconds. By default, the run uses a
      timeout specified in the task settings.
      
    * `memory`: Memory limit for the run, in megabytes. The amount of memory can be set
      to a power of 2 with a minimum of 128. By default, the run uses a memory
      limit specified in the task settings.
      
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
      number. By default, the run uses the build specified in the task
      settings (typically `latest`).
      
    * `waitForFinish`: The maximum number of seconds the server waits for the run to finish. By
      default, it is `0`, the maximum value is `60`. <!-- MAX_ACTOR_JOB_ASYNC_WAIT_SECS -->
      If the build finishes in time then the returned run object will have a
      terminal status (e.g. `SUCCEEDED`),
      otherwise it will have a transitional status (e.g. `RUNNING`).
      
    * `webhooks`: Specifies optional webhooks associated with the Actor run, which can be
      used to receive a notification
      e.g. when the Actor finished or failed. The value is a Base64-encoded
      JSON array of objects defining the webhooks.
      
      **Note**: if you already have a webhook set up for the Actor or task,
      you do not have to add it again here.
      
      For more information, see [Webhooks documentation](https://docs.apify.com/platform/integrations/webhooks).
      

  """
  @spec actor_task_runs_post(actorTaskId :: String.t(), body :: map, opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def actor_task_runs_post(actorTaskId, body, opts \\ []) do
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
      args: [actorTaskId: actorTaskId, body: body],
      call: {Apify.ActorTasks, :actor_task_runs_post},
      url: "/v2/actor-tasks/#{actorTaskId}/runs",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", :map}],
      response: [{201, {Apify.ActorTasks, :actor_task_runs_post_201_json_resp}}],
      opts: opts
    })
  end

  @type actor_task_webhooks_get_200_json_resp :: %{
          __info__: map,
          data: Apify.ActorTasksData.actor_task_webhooks_get_200_json_resp()
        }

  @doc """
  Get list of webhooks

  Gets the list of webhooks of a specific Actor task. The response is a JSON
  with the list of objects, where each object contains basic information about a single webhook.

  The endpoint supports pagination using the `limit` and `offset` parameters
  and it will not return more than 1000 records.

  By default, the records are sorted by the `createdAt` field in ascending
  order, to sort the records in descending order, use the `desc=1` parameter.


  ## Options

    * `offset`: Number of array elements that should be skipped at the start. The
      default value is `0`.
      
    * `limit`: Maximum number of array elements to return. The default value as well as
      the maximum is `1000`.
      
    * `desc`: If `true` or `1` then the objects are sorted by the `createdAt` field in
      descending order. By default, they are sorted in ascending order.
      

  """
  @spec actor_task_webhooks_get(actorTaskId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def actor_task_webhooks_get(actorTaskId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset])

    client.request(%{
      args: [actorTaskId: actorTaskId],
      call: {Apify.ActorTasks, :actor_task_webhooks_get},
      url: "/v2/actor-tasks/#{actorTaskId}/webhooks",
      method: :get,
      query: query,
      response: [{200, {Apify.ActorTasks, :actor_task_webhooks_get_200_json_resp}}],
      opts: opts
    })
  end

  @type actor_tasks_get_200_json_resp :: %{
          __info__: map,
          data: Apify.ActorTasksData.actor_tasks_get_200_json_resp()
        }

  @doc """
  Get list of tasks

  Gets the complete list of tasks that a user has created or used.

  The response is a list of objects in which each object contains essential
  information about a single task.

  The endpoint supports pagination using the `limit` and `offset` parameters,
  and it does not return more than a 1000 records.

  By default, the records are sorted by the `createdAt` field in ascending
  order; therefore you can use pagination to incrementally fetch all tasks while new
  ones are still being created. To sort the records in descending order, use
  the `desc=1` parameter.


  ## Options

    * `offset`: Number of records that should be skipped at the start. The default value is `0`.
      
    * `limit`: Maximum number of records to return. The default value as well as the maximum is `1000`.
      
    * `desc`: If `true` or `1` then the objects are sorted by the `createdAt` field in
      descending order. By default, they are sorted in ascending order.
      

  """
  @spec actor_tasks_get(opts :: keyword) :: {:ok, map} | {:error, Apify.Error.t()}
  def actor_tasks_get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset])

    client.request(%{
      args: [],
      call: {Apify.ActorTasks, :actor_tasks_get},
      url: "/v2/actor-tasks",
      method: :get,
      query: query,
      response: [{200, {Apify.ActorTasks, :actor_tasks_get_200_json_resp}}],
      opts: opts
    })
  end

  @type actor_tasks_post_201_json_resp :: %{__info__: map, data: Apify.Task.t()}

  @doc """
  Create task

  Create a new task with settings specified by the object passed as JSON in
  the POST payload.

  The response is the full task object as returned by the
  [Get task](#/reference/tasks/task-object/get-task) endpoint.

  The request needs to specify the `Content-Type: application/json` HTTP header!

  When providing your API authentication token, we recommend using the
  request's `Authorization` header, rather than the URL. ([More
  info](#/introduction/authentication)).

  """
  @spec actor_tasks_post(body :: map, opts :: keyword) :: {:ok, map} | {:error, Apify.Error.t()}
  def actor_tasks_post(body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [body: body],
      call: {Apify.ActorTasks, :actor_tasks_post},
      url: "/v2/actor-tasks",
      body: body,
      method: :post,
      request: [{"application/json", :map}],
      response: [{201, {Apify.ActorTasks, :actor_tasks_post_201_json_resp}}],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:actor_task_get_200_json_resp) do
    [data: {Apify.Task, :t}]
  end

  def __fields__(:actor_task_put_200_json_resp) do
    [data: {Apify.Task, :t}]
  end

  def __fields__(:actor_task_runs_get_200_json_resp) do
    [data: {Apify.ActorTasksData, :actor_task_runs_get_200_json_resp}]
  end

  def __fields__(:actor_task_runs_last_get_200_json_resp) do
    [data: {Apify.Run, :t}]
  end

  def __fields__(:actor_task_runs_post_201_json_resp) do
    [data: {Apify.Run, :t}]
  end

  def __fields__(:actor_task_webhooks_get_200_json_resp) do
    [data: {Apify.ActorTasksData, :actor_task_webhooks_get_200_json_resp}]
  end

  def __fields__(:actor_tasks_get_200_json_resp) do
    [data: {Apify.ActorTasksData, :actor_tasks_get_200_json_resp}]
  end

  def __fields__(:actor_tasks_post_201_json_resp) do
    [data: {Apify.Task, :t}]
  end
end
