defmodule Apify.Storage.RequestQueues do
  @moduledoc """
  Provides API endpoints related to storage/request queues
  """

  @default_client Apify.Client

  @doc """
  Delete request queue

  Deletes given queue.
  """
  @spec request_queue_delete(queueId :: String.t(), opts :: keyword) ::
          :ok | {:error, Apify.Error.t()}
  def request_queue_delete(queueId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [queueId: queueId],
      call: {Apify.Storage.RequestQueues, :request_queue_delete},
      url: "/v2/request-queues/#{queueId}",
      method: :delete,
      response: [{204, :null}],
      opts: opts
    })
  end

  @type request_queue_get_200_json_resp :: %{
          __info__: map,
          data: Apify.Storage.RequestQueuesData.request_queue_get_200_json_resp() | nil
        }

  @doc """
  Get request queue

  Returns queue object for given queue ID.
  """
  @spec request_queue_get(queueId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def request_queue_get(queueId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [queueId: queueId],
      call: {Apify.Storage.RequestQueues, :request_queue_get},
      url: "/v2/request-queues/#{queueId}",
      method: :get,
      response: [{200, {Apify.Storage.RequestQueues, :request_queue_get_200_json_resp}}],
      opts: opts
    })
  end

  @type request_queue_put_200_json_resp :: %{
          __info__: map,
          data: Apify.Storage.RequestQueuesData.request_queue_put_200_json_resp() | nil
        }

  @doc """
  Update request queue

  Updates a request queue's name using a value specified by a JSON object
  passed in the PUT payload.

  The response is the updated request queue object, as returned by the
  [Get request queue](#/reference/request-queues/queue-collection/get-request-queue) API endpoint.

  """
  @spec request_queue_put(queueId :: String.t(), body :: map, opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def request_queue_put(queueId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [queueId: queueId, body: body],
      call: {Apify.Storage.RequestQueues, :request_queue_put},
      url: "/v2/request-queues/#{queueId}",
      body: body,
      method: :put,
      request: [{"application/json", :map}],
      response: [{200, {Apify.Storage.RequestQueues, :request_queue_put_200_json_resp}}],
      opts: opts
    })
  end

  @type request_queue_requests_batch_delete_204_json_resp :: %{__info__: map, data: map | nil}

  @doc """
  Delete requests

  Batch-deletes given requests from the queue. The number of requests in a
  batch is limited to 25. The response contains an array of unprocessed and
  processed requests.
  If any delete operation fails because the request queue rate limit is
  exceeded or an internal failure occurs,
  the failed request is returned in the `unprocessedRequests` response
  parameter.
  You can re-send these delete requests. It is recommended to use an
  exponential backoff algorithm for these retries.
  Each request is identified by its ID or uniqueKey parameter. You can use
  either of them to identify the request.


  ## Options

    * `clientKey`: A unique identifier of the client accessing the request queue. It must
      be a string between 1 and 32 characters long
      

  """
  @spec request_queue_requests_batch_delete(queueId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def request_queue_requests_batch_delete(queueId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:clientKey])

    client.request(%{
      args: [queueId: queueId],
      call: {Apify.Storage.RequestQueues, :request_queue_requests_batch_delete},
      url: "/v2/request-queues/#{queueId}/requests/batch",
      method: :delete,
      query: query,
      response: [
        {204, {Apify.Storage.RequestQueues, :request_queue_requests_batch_delete_204_json_resp}}
      ],
      opts: opts
    })
  end

  @type request_queue_requests_batch_post_201_json_resp :: %{__info__: map, data: map | nil}

  @doc """
  Add requests

  Adds requests to the queue in batch. The maximum requests in batch is limit
  to 25. The response contains an array of unprocessed and processed requests.
  If any add operation fails because the request queue rate limit is exceeded
  or an internal failure occurs,
  the failed request is returned in the unprocessedRequests response
  parameter.
  You can resend these requests to add. It is recommended to use exponential
  backoff algorithm for these retries.
  If a request with the same `uniqueKey` was already present in the queue,
  then it returns an ID of the existing request.


  ## Options

    * `clientKey`: A unique identifier of the client accessing the request queue. It must
      be a string between 1 and 32 characters long
      
    * `forefront`: Determines if request should be added to the head of the queue or to the
      end. Default value is `false` (end of queue).
      

  """
  @spec request_queue_requests_batch_post(
          queueId :: String.t(),
          body :: [Apify.RequestWithoutId.t()],
          opts :: keyword
        ) :: {:ok, map} | {:error, Apify.Error.t()}
  def request_queue_requests_batch_post(queueId, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:clientKey, :forefront])

    client.request(%{
      args: [queueId: queueId, body: body],
      call: {Apify.Storage.RequestQueues, :request_queue_requests_batch_post},
      url: "/v2/request-queues/#{queueId}/requests/batch",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", [{Apify.RequestWithoutId, :t}]}],
      response: [
        {201, {Apify.Storage.RequestQueues, :request_queue_requests_batch_post_201_json_resp}}
      ],
      opts: opts
    })
  end

  @doc """
  Get list of request queues

  Lists all of a user's request queues. The response is a JSON array of
  objects, where each object
  contains basic information about one queue.

  By default, the objects are sorted by the `createdAt` field in ascending order,
  therefore you can use pagination to incrementally fetch all queues while new
  ones are still being created. To sort them in descending order, use `desc=1`
  parameter. The endpoint supports pagination using `limit` and `offset`
  parameters and it will not return more than 1000
  array elements.


  ## Options

    * `offset`: Number of array elements that should be skipped at the start. The
      default value is `0`.
      
    * `limit`: Maximum number of array elements to return. The default value as well as
      the maximum is `1000`.
      
    * `desc`: If `true` or `1` then the objects are sorted by the `startedAt` field in
      descending order. By default, they are sorted in ascending order.
      
    * `unnamed`: If `true` or `1` then all the queues are returned. By default only named
      queues are returned.
      

  """
  @spec request_queues_get(opts :: keyword) ::
          {:ok, Apify.GetListOfRequestQueuesResponse.t()} | {:error, Apify.Error.t()}
  def request_queues_get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset, :unnamed])

    client.request(%{
      args: [],
      call: {Apify.Storage.RequestQueues, :request_queues_get},
      url: "/v2/request-queues",
      method: :get,
      query: query,
      response: [{200, {Apify.GetListOfRequestQueuesResponse, :t}}],
      opts: opts
    })
  end

  @type request_queues_post_201_json_resp :: %{__info__: map, data: Apify.RequestQueue.t() | nil}

  @doc """
  Create request queue

  Creates a request queue and returns its object.
  Keep in mind that requests stored under unnamed queue follows [data
  retention period](https://docs.apify.com/platform/storage#data-retention).

  It creates a queue of given name if the parameter name is used. If a queue
  with the given name already exists then the endpoint returns
  its object.


  ## Options

    * `name`: Custom unique name to easily identify the queue in the future.

  """
  @spec request_queues_post(opts :: keyword) :: {:ok, map} | {:error, Apify.Error.t()}
  def request_queues_post(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:name])

    client.request(%{
      args: [],
      call: {Apify.Storage.RequestQueues, :request_queues_post},
      url: "/v2/request-queues",
      method: :post,
      query: query,
      response: [{201, {Apify.Storage.RequestQueues, :request_queues_post_201_json_resp}}],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:request_queue_get_200_json_resp) do
    [data: {Apify.Storage.RequestQueuesData, :request_queue_get_200_json_resp}]
  end

  def __fields__(:request_queue_put_200_json_resp) do
    [data: {Apify.Storage.RequestQueuesData, :request_queue_put_200_json_resp}]
  end

  def __fields__(:request_queue_requests_batch_delete_204_json_resp) do
    [data: :map]
  end

  def __fields__(:request_queue_requests_batch_post_201_json_resp) do
    [data: :map]
  end

  def __fields__(:request_queues_post_201_json_resp) do
    [data: {Apify.RequestQueue, :t}]
  end
end
