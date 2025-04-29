defmodule Apify.Storage.RequestQueues.RequestsLocks do
  @moduledoc """
  Provides API endpoints related to storage/request queues/requests locks
  """

  @default_client Apify.Client

  @type request_queue_head_get_200_json_resp :: %{
          __info__: map,
          data:
            Apify.Storage.RequestQueues.RequestsLocksData.request_queue_head_get_200_json_resp()
            | nil
        }

  @doc """
  Get head

  Returns given number of first requests from the queue.

  The response contains the `hadMultipleClients` boolean field which indicates
  that the queue was accessed by more than one client (with unique or empty
  `clientKey`).
  This field is used by [Apify SDK](https://sdk.apify.com) to determine
  whether the local cache is consistent with the request queue, and thus
  optimize performance of certain operations.


  ## Options

    * `limit`: How many items from queue should be returned.
    * `clientKey`: A unique identifier of the client accessing the request queue. It must
      be a string between 1 and 32 characters long. This identifier is used to
      determine whether the queue was accessed by multiple clients. If
      `clientKey` is not provided,
      the system considers this API call to come from a new client. For
      details, see the `hadMultipleClients` field returned by the [Get
      head](#/reference/request-queues/queue-head) operation.
      

  """
  @spec request_queue_head_get(queueId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def request_queue_head_get(queueId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:clientKey, :limit])

    client.request(%{
      args: [queueId: queueId],
      call: {Apify.Storage.RequestQueues.RequestsLocks, :request_queue_head_get},
      url: "/v2/request-queues/#{queueId}/head",
      method: :get,
      query: query,
      response: [
        {200, {Apify.Storage.RequestQueues.RequestsLocks, :request_queue_head_get_200_json_resp}}
      ],
      opts: opts
    })
  end

  @type request_queue_head_lock_post_200_json_resp :: %{
          __info__: map,
          data:
            Apify.Storage.RequestQueues.RequestsLocksData.request_queue_head_lock_post_200_json_resp()
            | nil
        }

  @doc """
  Get head and lock

  Returns the given number of first requests from the queue and locks them for
  the given time.

  If this endpoint locks the request, no other client or run will be able to get and
  lock these requests.

  The response contains the `hadMultipleClients` boolean field which indicates
  that the queue was accessed by more than one client (with unique or empty
  `clientKey`).


  ## Options

    * `lockSecs`: How long the requests will be locked for (in seconds).
    * `limit`: How many items from the queue should be returned.
    * `clientKey`: A unique identifier of the client accessing the request queue. It must
      be a string between 1 and 32 characters long.
      

  """
  @spec request_queue_head_lock_post(queueId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def request_queue_head_lock_post(queueId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:clientKey, :limit, :lockSecs])

    client.request(%{
      args: [queueId: queueId],
      call: {Apify.Storage.RequestQueues.RequestsLocks, :request_queue_head_lock_post},
      url: "/v2/request-queues/#{queueId}/head/lock",
      method: :post,
      query: query,
      response: [
        {200,
         {Apify.Storage.RequestQueues.RequestsLocks, :request_queue_head_lock_post_200_json_resp}}
      ],
      opts: opts
    })
  end

  @doc """
  Delete request lock

  Deletes a request lock. The request lock can be deleted only by the client
  that has locked it using [Get and lock head
  operation](#/reference/request-queues/queue-head-with-locks).


  ## Options

    * `clientKey`: A unique identifier of the client accessing the request queue. It must
      be a string between 1 and 32 characters long. This identifier is used to for locking
      and unlocking requests. You can delete or prolong lock only for requests that were locked by by same
      client key or from the same Actor run.
      
    * `forefront`: Determines if request should be added to the head of the queue or to the
      end after lock was removed.
      

  """
  @spec request_queue_request_lock_delete(
          queueId :: String.t(),
          requestId :: String.t(),
          opts :: keyword
        ) :: :ok | {:error, Apify.Error.t()}
  def request_queue_request_lock_delete(queueId, requestId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:clientKey, :forefront])

    client.request(%{
      args: [queueId: queueId, requestId: requestId],
      call: {Apify.Storage.RequestQueues.RequestsLocks, :request_queue_request_lock_delete},
      url: "/v2/request-queues/#{queueId}/requests/#{requestId}/lock",
      method: :delete,
      query: query,
      response: [{204, :null}],
      opts: opts
    })
  end

  @type request_queue_request_lock_put_200_json_resp :: %{
          __info__: map,
          data:
            Apify.Storage.RequestQueues.RequestsLocksData.request_queue_request_lock_put_200_json_resp()
            | nil
        }

  @doc """
  Prolong request lock

  Prolongs request lock. The request lock can be prolonged only by the client
  that has locked it using [Get and lock head
  operation](#/reference/request-queues/queue-head-with-locks).


  ## Options

    * `lockSecs`: For how long second request will be locked.
    * `clientKey`: A unique identifier of the client accessing the request queue. It must
      be a string between 1 and 32 characters long. This identifier is used to for locking
      and unlocking requests. You can delete or prolong lock only for requests that were locked by by same
      client key or from the same Actor run.
      
    * `forefront`: Determines if request should be added to the head of the queue or to the
      end after lock expires.
      

  """
  @spec request_queue_request_lock_put(
          queueId :: String.t(),
          requestId :: String.t(),
          opts :: keyword
        ) :: {:ok, map} | {:error, Apify.Error.t()}
  def request_queue_request_lock_put(queueId, requestId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:clientKey, :forefront, :lockSecs])

    client.request(%{
      args: [queueId: queueId, requestId: requestId],
      call: {Apify.Storage.RequestQueues.RequestsLocks, :request_queue_request_lock_put},
      url: "/v2/request-queues/#{queueId}/requests/#{requestId}/lock",
      method: :put,
      query: query,
      response: [
        {200,
         {Apify.Storage.RequestQueues.RequestsLocks,
          :request_queue_request_lock_put_200_json_resp}}
      ],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:request_queue_head_get_200_json_resp) do
    [data: {Apify.Storage.RequestQueues.RequestsLocksData, :request_queue_head_get_200_json_resp}]
  end

  def __fields__(:request_queue_head_lock_post_200_json_resp) do
    [
      data:
        {Apify.Storage.RequestQueues.RequestsLocksData,
         :request_queue_head_lock_post_200_json_resp}
    ]
  end

  def __fields__(:request_queue_request_lock_put_200_json_resp) do
    [
      data:
        {Apify.Storage.RequestQueues.RequestsLocksData,
         :request_queue_request_lock_put_200_json_resp}
    ]
  end
end
