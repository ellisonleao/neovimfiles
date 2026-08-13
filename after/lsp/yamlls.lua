return {
  settings = {
    yaml = {
      format = false,
      schemaStore = {
        -- in favor of schemastore
        enable = false,
        url = "",
      },
      schemas = require("schemastore").yaml.schemas(),
    },
  },
}
