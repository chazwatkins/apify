defmodule Apify.Logs do
  @moduledoc """
  Provides API endpoint related to logs
  """

  @default_client Apify.Client

  @doc """
  Get log

  Retrieves logs for a specific Actor build or run.


  ## Options

    * `stream`: If `true` or `1` then the logs will be streamed as long as the run or
      build is running.
      
    * `download`: If `true` or `1` then the web browser will download the log file rather
      than open it in a tab.
      

  """
  @spec log_get(buildOrRunId :: String.t(), opts :: keyword) ::
          {:ok, String.t()} | {:error, Apify.Error.t()}
  def log_get(buildOrRunId, opts \\ []) do
    client = opts[:client] || @default_client
    query = Keyword.take(opts, [:download, :stream])

    client.request(%{
      args: [buildOrRunId: buildOrRunId],
      call: {Apify.Logs, :log_get},
      url: "/v2/logs/#{buildOrRunId}",
      method: :get,
      query: query,
      response: [{200, {:string, :generic}}],
      opts: opts
    })
  end
end
