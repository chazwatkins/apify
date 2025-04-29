defmodule Apify.Storage.Datasets do
  @moduledoc """
  Provides API endpoints related to storage/datasets
  """

  @default_client Apify.Client

  @doc """
  Delete dataset

  Deletes a specific dataset.
  """
  @spec dataset_delete(datasetId :: String.t(), opts :: keyword) ::
          :ok | {:error, Apify.Error.t()}
  def dataset_delete(datasetId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [datasetId: datasetId],
      call: {Apify.Storage.Datasets, :dataset_delete},
      url: "/v2/datasets/#{datasetId}",
      method: :delete,
      response: [{204, :null}],
      opts: opts
    })
  end

  @doc """
  Get dataset

  Returns dataset object for given dataset ID.

  :::note

  Keep in mind that attributes `itemCount` and `cleanItemCount` are not propagated right away after data are pushed into a dataset.

  :::

  There is a short period (up to 5 seconds) during which these counters may not match with exact counts in dataset items.


  ## Options

    * `token`: API authentication token. It is required only when using the `username~dataset-name` format for `datasetId`.
      

  """
  @spec dataset_get(datasetId :: String.t(), opts :: keyword) ::
          {:ok, Apify.DatasetResponse.t()} | {:error, Apify.Error.t()}
  def dataset_get(datasetId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:token])

    client.request(%{
      args: [datasetId: datasetId],
      call: {Apify.Storage.Datasets, :dataset_get},
      url: "/v2/datasets/#{datasetId}",
      method: :get,
      query: query,
      response: [{200, {Apify.DatasetResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get items

  Returns data stored in the dataset in a desired format.

  ### Response format

  The format of the response depends on <code>format</code> query parameter.

  The <code>format</code> parameter can have one of the following values:
  <code>json</code>, <code>jsonl</code>, <code>xml</code>, <code>html</code>,
  <code>csv</code>, <code>xlsx</code> and <code>rss</code>.

  The following table describes how each format is treated.

  <table>
    <tr>
      <th>Format</th>
      <th>Items</th>
    </tr>
    <tr>
      <td><code>json</code></td>
      <td rowspan="3">The response is a JSON, JSONL or XML array of raw item objects.</td>
    </tr>
    <tr>
      <td><code>jsonl</code></td>
    </tr>
    <tr>
      <td><code>xml</code></td>
    </tr>
    <tr>
      <td><code>html</code></td>
      <td rowspan="3">The response is a HTML, CSV or XLSX table, where columns correspond to the
      properties of the item and rows correspond to each dataset item.</td>
    </tr>
    <tr>
      <td><code>csv</code></td>
    </tr>
    <tr>
      <td><code>xlsx</code></td>
    </tr>
    <tr>
      <td><code>rss</code></td>
      <td colspan="2">The response is a RSS file. Each item is displayed as child elements of one
      <code>&lt;item&gt;</code>.</td>
    </tr>
  </table>

  Note that CSV, XLSX and HTML tables are limited to 2000 columns and the column names cannot be longer than 200 characters.
  JSON, XML and RSS formats do not have such restrictions.

  ### Hidden fields

  The top-level fields starting with the `#` character are considered hidden.
  These are useful to store debugging information and can be omitted from the output by providing the `skipHidden=1` or `clean=1` query parameters.
  For example, if you store the following object to the dataset:

  ```
  {
      productName: "iPhone Xs",
      description: "Welcome to the big screens."
      #debug: {
          url: "https://www.apple.com/lae/iphone-xs/",
          crawledAt: "2019-01-21T16:06:03.683Z"
      }
  }
  ```

  The `#debug` field will be considered as hidden and can be omitted from the
  results. This is useful to
  provide nice cleaned data to end users, while keeping debugging info
  available if needed. The Dataset object
  returned by the API contains the number of such clean items in the`dataset.cleanItemCount` property.

  ### XML format extension

  When exporting results to XML or RSS formats, the names of object properties become XML tags and the corresponding values become tag's children. For example, the following JavaScript object:

  ```
  {
      name: "Paul Newman",
      address: [
          { type: "home", street: "21st", city: "Chicago" },
          { type: "office", street: null, city: null }
      ]
  }
  ```

  will be transformed to the following XML snippet:

  ```
  <name>Paul Newman</name>
  <address>
    <type>home</type>
    <street>21st</street>
    <city>Chicago</city>
  </address>
  <address>
    <type>office</type>
    <street/>
    <city/>
  </address>
  ```

  If the JavaScript object contains a property named `@` then its sub-properties are exported as attributes of the parent XML
  element.
  If the parent XML element does not have any child elements then its value is taken from a JavaScript object property named `#`.

  For example, the following JavaScript object:

  ```
  {
    "address": [{
      "@": {
        "type": "home"
      },
      "street": "21st",
      "city": "Chicago"
    },
    {
      "@": {
        "type": "office"
      },
      "#": 'unknown'
    }]
  }
  ```

  will be transformed to the following XML snippet:

  ```
  <address type="home">
    <street>21st</street>
    <city>Chicago</city>
  </address>
  <address type="office">unknown</address>
  ```

  This feature is also useful to customize your RSS feeds generated for various websites.

  By default the whole result is wrapped in a `<items>` element and each page object is wrapped in a `<item>` element.
  You can change this using <code>xmlRoot</code> and <code>xmlRow</code> url parameters.

  ### Pagination

  The generated response supports [pagination](#/introduction/pagination).
  The pagination is always performed with the granularity of a single item, regardless whether <code>unwind</code> parameter was provided.
  By default, the **Items** in the response are sorted by the time they were stored to the database, therefore you can use pagination to incrementally fetch the items as they are being added.
  No limit exists to how many items can be returned in one response.

  If you specify `desc=1` query parameter, the results are returned in the reverse order than they were stored (i.e. from newest to oldest items).
  Note that only the order of **Items** is reversed, but not the order of the `unwind` array elements.


  ## Options

    * `format`: Format of the results, possible values are: `json`, `jsonl`, `csv`, `html`, `xlsx`, `xml` and `rss`. The default value is `json`.
      
    * `clean`: If `true` or `1` then the API endpoint returns only non-empty items and skips hidden fields (i.e. fields starting with the # character).
      The `clean` parameter is just a shortcut for `skipHidden=true` and `skipEmpty=true` parameters.
      Note that since some objects might be skipped from the output, that the result might contain less items than the `limit` value.
      
    * `offset`: Number of items that should be skipped at the start. The default value is `0`.
      
    * `limit`: Maximum number of items to return. By default there is no limit.
    * `fields`: A comma-separated list of fields which should be picked from the items, only these fields will remain in the resulting record objects.
      Note that the fields in the outputted items are sorted the same way as they are specified in the `fields` query parameter.
      You can use this feature to effectively fix the output format.
      
    * `omit`: A comma-separated list of fields which should be omitted from the items.
    * `unwind`: A comma-separated list of fields which should be unwound, in order which they should be processed. Each field should be either an array or an object.
      If the field is an array then every element of the array will become a separate record and merged with parent object.
      If the unwound field is an object then it is merged with the parent object.
      If the unwound field is missing or its value is neither an array nor an object and therefore cannot be merged with a parent object then the item gets preserved as it is.
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
      
    * `bom`: All text responses are encoded in UTF-8 encoding. By default, the
      `format=csv` files are prefixed with the UTF-8 Byte Order Mark (BOM), while `json`, `jsonl`, `xml`, `html` and `rss` files are not.
      
      If you want to override this default behavior, specify `bom=1` query parameter to include the BOM or `bom=0` to skip it.
      
    * `xmlRoot`: Overrides default root element name of `xml` output. By default the root element is `items`.
      
    * `xmlRow`: Overrides default element name that wraps each page or page function result object in `xml` output. By default the element name is `item`.
      
    * `skipHeaderRow`: If `true` or `1` then header row in the `csv` format is skipped.
    * `skipHidden`: If `true` or `1` then hidden fields are skipped from the output, i.e. fields starting with the `#` character.
      
    * `skipEmpty`: If `true` or `1` then empty items are skipped from the output.
      
      Note that if used, the results might contain less items than the limit value.
      
    * `simplified`: If `true` or `1` then, the endpoint applies the `fields=url,pageFunctionResult,errorInfo`
      and `unwind=pageFunctionResult` query parameters. This feature is used to emulate simplified results provided by the
      legacy Apify Crawler product and it's not recommended to use it in new integrations.
      
    * `skipFailedPages`: If `true` or `1` then, the all the items with errorInfo property will be skipped from the output.
      
      This feature is here to emulate functionality of API version 1 used for the legacy Apify Crawler product and it's not recommended to use it in new integrations.
      

  """
  @spec dataset_items_get(datasetId :: String.t(), opts :: keyword) ::
          {:ok, String.t() | [map]} | {:error, Apify.Error.t()}
  def dataset_items_get(datasetId, opts \\ []) do
    client = opts[:client] || @default_client

    query =
      Keyword.take(opts, [
        :attachment,
        :bom,
        :clean,
        :delimiter,
        :desc,
        :fields,
        :flatten,
        :format,
        :limit,
        :offset,
        :omit,
        :simplified,
        :skipEmpty,
        :skipFailedPages,
        :skipHeaderRow,
        :skipHidden,
        :unwind,
        :xmlRoot,
        :xmlRow
      ])

    client.request(%{
      args: [datasetId: datasetId],
      call: {Apify.Storage.Datasets, :dataset_items_get},
      url: "/v2/datasets/#{datasetId}/items",
      method: :get,
      query: query,
      response: [{200, {:union, [{:string, :generic}, [:map]]}}],
      opts: opts
    })
  end

  @type dataset_items_post_400_json_resp :: %{
          __info__: map,
          error: Apify.Storage.DatasetsError.dataset_items_post_400_json_resp() | nil
        }

  @doc """
  Store items

  Appends an item or an array of items to the end of the dataset.
  The POST payload is a JSON object or a JSON array of objects to save into the dataset.

  If the data you attempt to store in the dataset is invalid (meaning any of the items received by the API fails the validation), the whole request is discarded and the API will return a response with status code 400.
  For more information about dataset schema validation, see [Dataset schema](https://docs.apify.com/platform/actors/development/actor-definition/dataset-schema/validation).

  **IMPORTANT:** The limit of request payload size for the dataset is 5 MB. If the array exceeds the size, you'll need to split it into a number of smaller arrays.

  """
  @spec dataset_items_post(
          datasetId :: String.t(),
          body :: [Apify.PutItemsRequest.t()],
          opts :: keyword
        ) :: {:ok, map} | {:error, Apify.Error.t()}
  def dataset_items_post(datasetId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [datasetId: datasetId, body: body],
      call: {Apify.Storage.Datasets, :dataset_items_post},
      url: "/v2/datasets/#{datasetId}/items",
      body: body,
      method: :post,
      request: [{"application/json", [{Apify.PutItemsRequest, :t}]}],
      response: [{201, :map}, {400, {Apify.Storage.Datasets, :dataset_items_post_400_json_resp}}],
      opts: opts
    })
  end

  @doc """
  Update dataset

  Updates a dataset's name using a value specified by a JSON object passed in the PUT payload.
  The response is the updated dataset object, as returned by the [Get dataset](#/reference/datasets/dataset-collection/get-dataset) API endpoint.

  """
  @spec dataset_put(
          datasetId :: String.t(),
          body :: Apify.UpdateDatasetRequest.t(),
          opts :: keyword
        ) :: {:ok, Apify.DatasetResponse.t()} | {:error, Apify.Error.t()}
  def dataset_put(datasetId, body, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [datasetId: datasetId, body: body],
      call: {Apify.Storage.Datasets, :dataset_put},
      url: "/v2/datasets/#{datasetId}",
      body: body,
      method: :put,
      request: [{"application/json", {Apify.UpdateDatasetRequest, :t}}],
      response: [{200, {Apify.DatasetResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get dataset statistics

  Returns statistics for given dataset.

  Provides only [field statistics](https://docs.apify.com/platform/actors/development/actor-definition/dataset-schema/validation#dataset-field-statistics).

  """
  @spec dataset_statistics_get(datasetId :: String.t(), opts :: keyword) ::
          {:ok, Apify.GetDatasetStatisticsResponse.t()} | {:error, Apify.Error.t()}
  def dataset_statistics_get(datasetId, opts \\ []) do
    client = opts[:client] || @default_client

    client.request(%{
      args: [datasetId: datasetId],
      call: {Apify.Storage.Datasets, :dataset_statistics_get},
      url: "/v2/datasets/#{datasetId}/statistics",
      method: :get,
      response: [{200, {Apify.GetDatasetStatisticsResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Get list of datasets

  Lists all of a user's datasets.

  The response is a JSON array of objects,
  where each object contains basic information about one dataset.

  By default, the objects are sorted by the `createdAt` field in ascending
  order, therefore you can use pagination to incrementally fetch all datasets while new
  ones are still being created. To sort them in descending order, use `desc=1`
  parameter. The endpoint supports pagination using `limit` and `offset`
  parameters and it will not return more than 1000 array elements.


  ## Options

    * `offset`: Number of array elements that should be skipped at the start. The default value is `0`.
      
    * `limit`: Maximum number of array elements to return. The default value as well as the maximum is `1000`.
      
    * `desc`: If `true` or `1` then the objects are sorted by the `startedAt` field in
      descending order. By default, they are sorted in ascending order.
      
    * `unnamed`: If `true` or `1` then all the datasets are returned. By default only named datasets are returned.
      

  """
  @spec datasets_get(opts :: keyword) ::
          {:ok, Apify.GetListOfDatasetsResponse.t()} | {:error, Apify.Error.t()}
  def datasets_get(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:desc, :limit, :offset, :unnamed])

    client.request(%{
      args: [],
      call: {Apify.Storage.Datasets, :datasets_get},
      url: "/v2/datasets",
      method: :get,
      query: query,
      response: [{200, {Apify.GetListOfDatasetsResponse, :t}}],
      opts: opts
    })
  end

  @doc """
  Create dataset

  Creates a dataset and returns its object.
  Keep in mind that data stored under unnamed dataset follows [data retention period](https://docs.apify.com/platform/storage#data-retention).
  It creates a dataset with the given name if the parameter name is used.
  If a dataset with the given name already exists then returns its object.


  ## Options

    * `name`: Custom unique name to easily identify the dataset in the future.

  """
  @spec datasets_post(opts :: keyword) ::
          {:ok, Apify.DatasetResponse.t()} | {:error, Apify.Error.t()}
  def datasets_post(opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:name])

    client.request(%{
      args: [],
      call: {Apify.Storage.Datasets, :datasets_post},
      url: "/v2/datasets",
      method: :post,
      query: query,
      response: [{201, {Apify.DatasetResponse, :t}}],
      opts: opts
    })
  end

  @doc false
  @spec __fields__(atom) :: keyword
  def __fields__(:dataset_items_post_400_json_resp) do
    [error: {Apify.Storage.DatasetsError, :dataset_items_post_400_json_resp}]
  end
end
