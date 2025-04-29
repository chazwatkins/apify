defmodule Apify.Config do
  @external_resource ".api-version"

  @default_server "https://api.apify.com"
  @api_version File.read!(".api-version") |> String.trim()

  @default_stack [
    {Apify.Plugin.JasonSerializer, :encode_body, []},
    {Apify.Plugin.ReqClient, :request, []},
    {Apify.Plugin.JasonSerializer, :decode_body, []},
    {Apify.Plugin.TypedDecoder, :decode_response, []},
    {Apify.Plugin.TypedDecoder, :normalize_errors, []}
  ]

  @moduledoc """
  Configuration for the API client and plugins

  > #### Note {:.info}
  >
  > Functions in this module is unlikely to be used directly by applications. Instead, they are
  > useful for plugins. See `Apify.Plugin` for more information.

  Callers of API operation functions can pass in some configuration directly using the final
  argument. Configuration passed in this way always takes precedence over global configuration.

      # Local options:
      Apify.ActorRuns.get_run("my-actor-run-id", client: Apify.client(api_token: "my-token"))

      # Application environment (ex. config/config.exs):
      config :apify, :api_token, "my-token"

  ## Options

  The following configuration is available using **local options**:

    * `server` (URL): API server to use. Defaults to `#{@default_server}`.

    * `stack` (list of plugins): Plugins to control the execution of client requests. See
      `Apify.Plugin` for more information. Defaults to the default stack below.

    * `wrap` (boolean): Whether to wrap the results of the API call in a tagged tuple. When
      `true`, the response body will be wrapped as `{:ok, response}` on success or
      `{:error, error}` otherwise. When false, the Operation or Error is returned directly.
      Defaults to `true`.

  The following configuration is available using the **application environment**:

    * `app_name` (string): Name of the application using this client, used for User Agent and
      logging purposes.

    * `api_token` (string): Default API token to use when authentication was not provided for a request.

    * `server` (URL): API server to use. Defaults to `#{@default_server}`.

    * `stack` (list of plugins): Plugins to control the execution of client requests. See
      `Apify.Plugin` for more information. Defaults to the default stack below.

  ## Plugins

  Client requests are implemented using a series of plugins. Each plugin accepts a
  `Apify.Operation` struct and returns either a modified operation or an error. The collection of
  plugins configured for a request form a **stack**.

  The default stack uses `Jason` as a serializer/deserializer and `Req` as an HTTP client:

  ```elixir
  #{inspect(@default_stack, pretty: true, width: 98)}
  ```

  In general, plugins can be defined as 2- or 3-tuples specifying the module and function name and
  any options to pass to the function. For example:

      {MyPlugin, :my_function}
      #=> MyPlugin.my_function(operation)

      {MyPlugin, :my_function, some: :option}
      #=> MyPlugin.my_function(operation, some: :option)

  By modifying the stack, applications can easily use a different HTTP client library or serializer.
  """

  @typedoc """
  Plugin definition

  Plugins are defined in the stack using module and function tuples with an optional keyword list.
  Options, if provided, will be passed as the second argument.
  """
  @type plugin ::
          {module :: module, function :: atom, options :: keyword}
          | {module :: module, function :: atom}

  #
  # Client Configuration
  #

  @doc """
  Get the configured app name

  ## Example

      iex> Application.put_env(:apify, :app_name, "Test App")
      iex> Config.app_name()
      "Test App"

  """
  @spec app_name :: String.t() | nil
  def app_name do
    Application.get_env(:apify, :app_name)
  end

  @doc """
  Get the configured default auth token

  ## Example

      iex> Application.put_env(:apify, :api_token, "my-api-token")
      iex> Config.default_auth()
      "my-api-token"

  """
  @spec default_auth :: String.t() | nil
  def default_auth do
    Application.get_env(:apify, :api_token)
  end

  @doc """
  Get the configured default API server, or `#{@default_server}` by default

  ## Example

      iex> Config.server([])
      "https://api.apify.com"

      iex> Config.server(server: "https://custom-api.apify.com")
      "https://custom-api.apify.com"

  """
  @spec server(keyword) :: String.t()
  def server(opts) do
    config(opts, :server, @default_server)
  end

  @doc """
  Get the API version date

  Returns the date when the API specification was last updated.
  This is stored in the .api-version file.

  ## Example

      iex> is_binary(Config.api_version())
      true

  """
  @spec api_version :: String.t()
  def api_version do
    @api_version
  end

  @doc """
  Get the configured plugin stack

  ## Example

      iex> Config.stack([])
      [
        {Apify.Plugin.JasonSerializer, :encode_body},
        # ...
      ]

  ## Default

  The following stack is the default if none is configured or passed as an option:

  ```elixir
  #{inspect(@default_stack, pretty: true, width: 98)}
  ```

  """
  @spec stack(keyword) :: [plugin]
  def stack(opts) do
    config(opts, :stack, @default_stack)
  end

  @doc """
  Whether to wrap the result

  Passing `wrap: false` to a client call can be useful if you need additional information about
  the response, such as response headers.

  ## Example

      iex> Config.wrap([])
      true

      iex> Config.wrap(wrap: false)
      false

  """
  @spec wrap(keyword) :: boolean
  def wrap(opts) do
    config(opts, :wrap, true)
  end

  #
  # Plugin Configuration
  #

  @doc """
  Get configuration namespaced with a plugin module

  Plugins can provide a keyword list of options (such as a pre-merged keyword list of the plugin
  options argument and the operation's options) to be used if the given key is present. Otherwise,
  the response will fall back to the application environment given with the following form:

      config :apify, MyPlugin, some: :option

  Where `MyPlugin` is the `plugin` module given as the second argument.

  See `plugin_config!/3` for a variant that raises if the configuration is not found.
  """
  @spec plugin_config(keyword, module, atom, term) :: term
  def plugin_config(config \\ [], plugin, key, default) do
    if value = Keyword.get(config, key) do
      value
    else
      Application.get_env(:apify, plugin, [])
      |> Keyword.get(key, default)
    end
  end

  @doc """
  Get configuration namespaced with a plugin module, or raise if not present

  Plugins can provide a keyword list of options (such as a pre-merged keyword list of the plugin
  options argument and the operation's options) to be used if the given key is present. Otherwise,
  the response will fall back to the application environment given with the following form:

      config :apify, MyPlugin, some: :option

  Where `MyPlugin` is the `plugin` module given as the second argument.

  See `plugin_config/4` for a variant that accepts a default value.
  """
  @spec plugin_config!(keyword, module, atom) :: term | no_return
  def plugin_config!(config \\ [], plugin, key) do
    plugin_config(config, plugin, key, nil) ||
      raise "Configuration #{key} is required for #{plugin}"
  end

  #
  # Helpers
  #

  @spec config(keyword, atom, any) :: any
  defp config(config, key, default) do
    Keyword.get(config, key, Application.get_env(:apify, key, default))
  end
end
