import Config

if config_env() == :dev do
  # Configure oapi_generator
  config :oapi_generator,
    default: [
      output: [
        base_module: Apify,
        location: "lib/",
        operation_subdirectory: "operations/",
        schema_subdirectory: "schemas/",
        schema_use: Apify.Encoder,
        extra_fields: [__info__: :map],
        types: [
          error: {Apify.Error, :t}
        ]
      ],
      # Ignore problematic schemas
      ignore: [
        # Ignore GetOpenApi schemas which have problematic keys
        ~r"^GetOpenApiResponse",
        ~r"#/components/schemas/GetOpenApiResponse*"
      ],
      naming: [
        # Group related schemas under common namespaces
        group: [],

        # Merge similar schemas into single modules with different type variants
        merge: [],

        # Handle spaces in operation names and other renames
        rename: []
      ]
    ]
end
