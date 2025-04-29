defmodule Apify.Plugin do
  @moduledoc """
  Behaviour and utilities for client plugins

  Plugins are the building blocks of the Apify client. Each plugin is responsible for a specific
  part of the request/response cycle, such as serializing the request body, making the HTTP request,
  or deserializing the response body.

  ## Creating a Plugin

  A plugin is a module that implements the `c:handle_request/2` callback. This callback receives
  an `Apify.Operation` struct and a keyword list of options, and returns either
  `{:ok, operation}` or `{:error, error}`.

  ```elixir
  defmodule MyPlugin do
    @behaviour Apify.Plugin

    @impl true
    def handle_request(operation, opts) do
      # Do something with the operation
      {:ok, operation}
    end
  end
  ```

  ## Using a Plugin

  Plugins are used by adding them to the client's stack. The stack is a list of plugins that are
  executed in order. Each plugin receives the operation from the previous plugin and passes it to
  the next plugin.

  ```elixir
  # In config/config.exs
  config :apify, :stack, [
    {MyPlugin, :handle_request, []},
    {Apify.Plugin.JasonSerializer, :encode_body, []},
    {Apify.Plugin.ReqClient, :request, []},
    {Apify.Plugin.JasonSerializer, :decode_body, []},
    {Apify.Plugin.TypedDecoder, :decode_response, []}
  ]
  ```

  Or, you can pass the stack directly to the client:

  ```elixir
  Apify.client(stack: [
    {MyPlugin, :handle_request, []},
    # ...
  ])
  ```
  """

  alias Apify.Operation

  @doc """
  Handle a request operation

  This callback receives an `Apify.Operation` struct and a keyword list of options, and returns
  either `{:ok, operation}` or `{:error, error}`.
  """
  @callback handle_request(Operation.t(), keyword) :: {:ok, Operation.t()} | {:error, term}
end
