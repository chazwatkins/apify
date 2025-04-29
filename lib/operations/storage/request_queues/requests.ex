defmodule Apify.Storage.RequestQueues.Requests do
  @moduledoc """
  Provides API endpoints related to storage/request queues/requests
  """

  @default_client Apify.Client

  @doc """
  Delete request

  Deletes given request from queue.

  ## Options

    * `clientKey`: A unique identifier of the client accessing the request queue. It must
      be a string between 1 and 32 characters long. This identifier is used to
      determine whether the queue was accessed by multiple clients. If
      `clientKey` is not provided,
      the system considers this API call to come from a new client. For
      details, see the `hadMultipleClients` field returned by the [Get
      head](#/reference/request-queues/queue-head) operation.
      

  """
  @spec request_queue_request_delete(
          queueId :: String.t(),
          requestId :: String.t(),
          opts :: keyword
        ) :: :ok | {:error, Apify.Error.t()}
  def request_queue_request_delete(queueId, requestId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:clientKey])

    client.request(%{
      args: [queueId: queueId, requestId: requestId],
      call: {Apify.Storage.RequestQueues.Requests, :request_queue_request_delete},
      url: "/v2/request-queues/#{queueId}/requests/#{requestId}",
      method: :delete,
      query: query,
      response: [{204, :null}],
      opts: opts
    })
  end

  @type request_queue_request_get_200_json_resp :: %{
          __info__: map,
          data:
            Apify.Storage.RequestQueues.RequestsData.request_queue_request_get_200_json_resp()
            | nil
        }

  @doc """
  Get request

  Returns request from queue.
  """
  @spec request_queue_request_get(queueId :: String.t(), requestId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def request_queue_request_get(queueId, requestId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [queueId: queueId, requestId: requestId],
      call: {Apify.Storage.RequestQueues.Requests, :request_queue_request_get},
      url: "/v2/request-queues/#{queueId}/requests/#{requestId}",
      method: :get,
      response: [
        {200, {Apify.Storage.RequestQueues.Requests, :request_queue_request_get_200_json_resp}}
      ],
      opts: opts
    })
  end

  @type request_queue_request_put_200_json_resp :: %{
          __info__: map,
          data:
            Apify.Storage.RequestQueues.RequestsData.request_queue_request_put_200_json_resp()
            | nil
        }

  @doc """
  Update request

  Updates a request in a queue. Mark request as handled by setting
  `request.handledAt = new Date()`.
  If `handledAt` is set, the request will be removed from head of the queue.


  ## Options

    * `forefront`: Determines if request should be added to the head of the queue or to the
      end. Default value is `false` (end of queue).
      
    * `clientKey`: A unique identifier of the client accessing the request queue. It must
      be a string between 1 and 32 characters long. This identifier is used to
      determine whether the queue was accessed by multiple clients. If
      `clientKey` is not provided,
      the system considers this API call to come from a new client. For
      details, see the `hadMultipleClients` field returned by the [Get
      head](#/reference/request-queues/queue-head) operation.
      

  """
  @spec request_queue_request_put(
          queueId :: String.t(),
          requestId :: String.t(),
          body :: map,
          opts :: keyword
        ) :: {:ok, map} | {:error, Apify.Error.t()}
  def request_queue_request_put(queueId, requestId, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:clientKey, :forefront])

    client.request(%{
      args: [queueId: queueId, requestId: requestId, body: body],
      call: {Apify.Storage.RequestQueues.Requests, :request_queue_request_put},
      url: "/v2/request-queues/#{queueId}/requests/#{requestId}",
      body: body,
      method: :put,
      query: query,
      request: [{"application/json", :map}],
      response: [
        {200, {Apify.Storage.RequestQueues.Requests, :request_queue_request_put_200_json_resp}}
      ],
      opts: opts
    })
  end

  @type request_queue_requests_get_200_json_resp :: %{
          __info__: map,
          data:
            Apify.Storage.RequestQueues.RequestsData.request_queue_requests_get_200_json_resp()
            | nil
        }

  @doc """
  List requests

  Returns a list of requests. This endpoint is paginated using
  exclusiveStartId and limit parameters.


  ## Options

    * `clientKey`: A unique identifier of the client accessing the request queue. It must
      be a string between 1 and 32 characters long. This identifier is used to
      determine whether the queue was accessed by multiple clients. If
      `clientKey` is not provided,
      the system considers this API call to come from a new client. For
      details, see the `hadMultipleClients` field returned by the [Get
      head](#/reference/request-queues/queue-head) operation.
      
    * `exclusiveStartId`: All requests up to this one (including) are skipped from the result.
    * `limit`: Number of keys to be returned. Maximum value is `10000`.

  """
  @spec request_queue_requests_get(queueId :: String.t(), opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def request_queue_requests_get(queueId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:clientKey, :exclusiveStartId, :limit])

    client.request(%{
      args: [queueId: queueId],
      call: {Apify.Storage.RequestQueues.Requests, :request_queue_requests_get},
      url: "/v2/request-queues/#{queueId}/requests",
      method: :get,
      query: query,
      response: [
        {200, {Apify.Storage.RequestQueues.Requests, :request_queue_requests_get_200_json_resp}}
      ],
      opts: opts
    })
  end

  @type request_queue_requests_post_201_json_resp :: %{
          __info__: map,
          data:
            Apify.Storage.RequestQueues.RequestsData.request_queue_requests_post_201_json_resp()
            | nil
        }

  @doc """
  Add request

  Adds request to the queue. Response contains ID of the request and info if
  request was already present in the queue or handled.

  If request with same `uniqueKey` was already present in the queue then
  returns an ID of existing request.


  ## Options

    * `clientKey`: A unique identifier of the client accessing the request queue. It must
      be a string between 1 and 32 characters long. This identifier is used to
      determine whether the queue was accessed by multiple clients. If
      `clientKey` is not provided,
      the system considers this API call to come from a new client. For
      details, see the `hadMultipleClients` field returned by the [Get
      head](#/reference/request-queues/queue-head) operation.
      
    * `forefront`: Determines if request should be added to the head of the queue or to the
      end. Default value is `false` (end of queue).
      

  """
  @spec request_queue_requests_post(queueId :: String.t(), body :: map, opts :: keyword) ::
          {:ok, map} | {:error, Apify.Error.t()}
  def request_queue_requests_post(queueId, body, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:clientKey, :forefront])

    client.request(%{
      args: [queueId: queueId, body: body],
      call: {Apify.Storage.RequestQueues.Requests, :request_queue_requests_post},
      url: "/v2/request-queues/#{queueId}/requests",
      body: body,
      method: :post,
      query: query,
      request: [{"application/json", :map}],
      response: [
        {201, {Apify.Storage.RequestQueues.Requests, :request_queue_requests_post_201_json_resp}}
      ],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:request_queue_request_get_200_json_resp) do
    [data: {Apify.Storage.RequestQueues.RequestsData, :request_queue_request_get_200_json_resp}]
  end

  def __fields__(:request_queue_request_put_200_json_resp) do
    [data: {Apify.Storage.RequestQueues.RequestsData, :request_queue_request_put_200_json_resp}]
  end

  def __fields__(:request_queue_requests_get_200_json_resp) do
    [data: {Apify.Storage.RequestQueues.RequestsData, :request_queue_requests_get_200_json_resp}]
  end

  def __fields__(:request_queue_requests_post_201_json_resp) do
    [data: {Apify.Storage.RequestQueues.RequestsData, :request_queue_requests_post_201_json_resp}]
  end
end
