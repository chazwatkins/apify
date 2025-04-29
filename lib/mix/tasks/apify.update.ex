defmodule Mix.Tasks.Apify.Update do
  @moduledoc """
  Updates the Apify client with the latest API specification.

  This task performs the following steps:
  1. Downloads the latest Apify API specification to a temporary file
  2. Deletes the existing generated code (schemas and operations)
  3. Runs the code generator
  4. Updates the .api-version file with the current date

  ## Usage

      mix apify.update
  """
  use Mix.Task

  @shortdoc "Updates the Apify client with the latest API specification"
  @api_spec_url "https://docs.apify.com/api/openapi.yaml"

  @impl Mix.Task
  def run(_args) do
    # Step 1: Download the API spec to a temporary file
    temp_spec_path = download_api_spec()

    # Step 2: Delete existing generated code
    delete_generated_code()

    # Step 3: Run the code generator
    generate_code(temp_spec_path)

    # Step 4: Update .api-version file
    update_api_version()

    # Step 5: Clean up temporary file
    File.rm!(temp_spec_path)

    Mix.shell().info([:green, "✓ ", :reset, "Apify client updated successfully!"])
  end

  defp download_api_spec do
    # Create a temporary file
    temp_spec_path = Path.join(System.tmp_dir!(), "apify_openapi_#{System.os_time()}.yaml")

    case System.cmd("curl", ["-s", "-o", temp_spec_path, @api_spec_url]) do
      {_, 0} ->
        Mix.shell().info([:green, "✓ ", :reset, "API specification downloaded"])
        temp_spec_path

      {error, _} ->
        Mix.raise("Failed to download API specification: #{error}")
    end
  end

  defp delete_generated_code do
    # Get directories from config
    config = Application.get_env(:oapi_generator, :default)
    base_location = config[:output][:location] || "lib/"
    schema_dir = Path.join(base_location, config[:output][:schema_subdirectory] || "schemas/")

    operation_dir =
      Path.join(base_location, config[:output][:operation_subdirectory] || "operations/")

    File.rm_rf!(schema_dir)
    File.rm_rf!(operation_dir)
  end

  defp generate_code(spec_path) do
    # Run the generator
    Mix.Task.run("api.gen", ["default", spec_path])
  end

  defp update_api_version do
    today = Date.utc_today() |> Date.to_iso8601()
    File.write!(".api-version", today)
  end
end
