return {
  settings = {
    yaml = {
      keyOrdering = false,
      schemaStore = {
        -- in favor of schemastore
        enable = false,
        url = "",
      },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
}
