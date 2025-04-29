defmodule Apify.Storage.KeyValueStores do
  @moduledoc """
  Provides API endpoints related to storage/key value stores
  """

  @default_client Apify.Client

  @doc """
  Delete store

  Deletes a key-value store.
  """
  @spec key_value_store_delete(storeId :: String.t(), opts :: keyword) ::
          :ok | {:error, Apify.Error.t()}
  def key_value_store_delete(storeId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [storeId: storeId],
      call: {Apify.Storage.KeyValueStores, :key_value_store_delete},
      url: "/v2/key-value-stores/#{storeId}",
      method: :delete,
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Get store

  Gets an object that contains all the details about a specific key-value
  store.

  """
  @spec key_value_store_get(storeId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetStoreResponse.t()} | {:error, Apify.Error.t()}
  def key_value_store_get(storeId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [storeId: storeId],
      call: {Apify.Storage.KeyValueStores, :key_value_store_get},
      url: "/v2/key-value-stores/#{storeId}",
      method: :get,
      response: [{200, {Apify.GetStoreResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get list of keys

  Returns a list of objects describing keys of a given key-value store, as
  well as some information about the values (e.g. size).

  This endpoint is paginated using `exclusiveStartKey` and `limit` parameters
  - see [Pagination](/api/v2#using-key) for more details.


  ## Options

    * `exclusiveStartKey`: All keys up to this one (including) are skipped from the result.
    * `limit`: Number of keys to be returned. Maximum value is `1000`.

  """
  @spec key_value_store_keys_get(storeId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetListOfKeysResponse.t()} | {:error, Apify.Error.t()}
  def key_value_store_keys_get(storeId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:exclusiveStartKey, :limit])

    client.request(%{
      args: [storeId: storeId],
      call: {Apify.Storage.KeyValueStores, :key_value_store_keys_get},
      url: "/v2/key-value-stores/#{storeId}/keys",
      method: :get,
      query: query,
      response: [{200, {Apify.GetListOfKeysResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Update store

  Updates a key-value store's name using a value specified by a JSON object
  passed in the PUT payload.

  The response is the updated key-value store object, as returned by the [Get
  store](#/reference/key-value-stores/store-object/get-store) API endpoint.

  """
  @spec key_value_store_put(
          storeId :: String.t(),
          body :: Apify.UpdateStoreRequest.t(),
          opts :: keyword
        ) :: {:ok, Apify.UpdateStoreResponse.t()} | {:error, Apify.Error.t()}
  def key_value_store_put(storeId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [storeId: storeId, body: body],
      call: {Apify.Storage.KeyValueStores, :key_value_store_put},
      url: "/v2/key-value-stores/#{storeId}",
      body: body,
      method: :put,
      request: [{"application/json", {Apify.UpdateStoreRequest, :t}}],
      response: [{200, {Apify.UpdateStoreResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Delete record

  Removes a record specified by a key from the key-value store.
  """
  @spec key_value_store_record_delete(
          storeId :: String.t(),
          recordKey :: String.t(),
          opts :: keyword
        ) :: :ok | {:error, Apify.Error.t()}
  def key_value_store_record_delete(storeId, recordKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [storeId: storeId, recordKey: recordKey],
      call: {Apify.Storage.KeyValueStores, :key_value_store_record_delete},
      url: "/v2/key-value-stores/#{storeId}/records/#{recordKey}",
      method: :delete,
      response: [{204, :null}],
      opts: opts
    })
  end

  @type key_value_store_record_get_200_json_resp :: %{__info__: map, foo: String.t() | nil}

  @doc """
  Get record

  Gets a value stored in the key-value store under a specific key.

  The response body has the same `Content-Encoding` header as it was set in
  [Put record](#tag/Key-value-storesRecord/operation/keyValueStore_record_put).

  If the request does not define the `Accept-Encoding` HTTP header with the
  right encoding, the record will be decompressed.

  Most HTTP clients support decompression by default. After using the HTTP
  client with decompression support, the `Accept-Encoding` header is set by
  the client and body is decompressed automatically.

  """
  @spec key_value_store_record_get(
          storeId :: String.t(),
          recordKey :: String.t(),
          opts :: keyword
        ) :: {:ok, map} | {:error, Apify.Error.t()}
  def key_value_store_record_get(storeId, recordKey, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [storeId: storeId, recordKey: recordKey],
      call: {Apify.Storage.KeyValueStores, :key_value_store_record_get},
      url: "/v2/key-value-stores/#{storeId}/records/#{recordKey}",
      method: :get,
      response: [
        {200, {Apify.Storage.KeyValueStores, :key_value_store_record_get_200_json_resp}},
        {302, :null}
      ],
      opts: opts
    })
  end

  @doc """
  Store record

  Stores a value under a specific key to the key-value store.

  The value is passed as the PUT payload and it is stored with a MIME content
  type defined by the `Content-Type` header and with encoding defined by the
  `Content-Encoding` header.

  To save bandwidth, storage, and speed up your upload, send the request
  payload compressed with Gzip compression and add the `Content-Encoding: gzip`
  header. It is possible to set up another compression type with `Content-Encoding`
  request header.

  Below is a list of supported `Content-Encoding` types.

  * Gzip compression: `Content-Encoding: gzip`
  * Deflate compression: `Content-Encoding: deflate`
  * Brotli compression: `Content-Encoding: br`

  """
  @spec key_value_store_record_put(
          storeId :: String.t(),
          recordKey :: String.t(),
          body :: Apify.PutRecordRequest.t(),
          opts :: keyword
        ) :: {:ok, map} | {:error, Apify.Error.t()}
  def key_value_store_record_put(storeId, recordKey, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [storeId: storeId, recordKey: recordKey, body: body],
      call: {Apify.Storage.KeyValueStores, :key_value_store_record_put},
      url: "/v2/key-value-stores/#{storeId}/records/#{recordKey}",
      body: body,
      method: :put,
      request: [{"application/json", {Apify.PutRecordRequest, :t}}],
      response: [{201, :map}],
      opts: opts
    })
  end

  @doc """
  Get list of key-value stores

  Gets the list of key-value stores owned by the user.

  The response is a list of objects, where each objects contains a basic
  information about a single key-value store.

  The endpoint supports pagination using the `limit` and `offset` parameters
  and it will not return more than 1000 array elements.

  By default, the records are sorted by the `createdAt` field in ascending
  order, therefore you can use pagination to incrementally fetch all key-value stores
  while new ones are still being created. To sort the records in descending order, use
  the `desc=1` parameter.


  ## Options

    * `offset`: Number of records that should be skipped at the start. The default value
      is `0`.
      
    * `limit`: Maximum number of records to return. The default value as well as the
      maximum is `1000`.
      
    * `desc`: If `true` or `1` then the objects are sorted by the `startedAt` field in
      descending order. By default, they are sorted in ascending order.
      
    * `unnamed`: If `true` or `1` then all the stores are returned. By default, only
      named key-value stores are returned.
      

  """
  @spec key_value_stores_get(opts :: keyword) ::
          {:ok, Apify.GetListOfKeyValueStoresResponse.t()} | {:error, Apify.Error.t()}
  def key_value_stores_get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset, :unnamed])

    client.request(%{
      args: [],
      call: {Apify.Storage.KeyValueStores, :key_value_stores_get},
      url: "/v2/key-value-stores",
      method: :get,
      query: query,
      response: [{200, {Apify.GetListOfKeyValueStoresResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Create key-value store

  Creates a key-value store and returns its object. The response is the same
  object as returned by the [Get store](#/reference/key-value-stores/store-object/get-store)
  endpoint.

  Keep in mind that data stored under unnamed store follows [data retention
  period](https://docs.apify.com/platform/storage#data-retention).

  It creates a store with the given name if the parameter name is used.
  If there is another store with the same name, the endpoint does not create a
  new one and returns the existing object instead.


  ## Options

    * `name`: Custom unique name to easily identify the store in the future.

  """
  @spec key_value_stores_post(opts :: keyword) ::
          {:ok, Apify.CreateKeyValueStoreResponse.t()} | {:error, Apify.Error.t()}
  def key_value_stores_post(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:name])

    client.request(%{
      args: [],
      call: {Apify.Storage.KeyValueStores, :key_value_stores_post},
      url: "/v2/key-value-stores",
      method: :post,
      query: query,
      response: [{201, {Apify.CreateKeyValueStoreResponse, :t}}],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:key_value_store_record_get_200_json_resp) do
    [foo: {:string, :generic}]
  end
end
