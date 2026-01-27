return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",       -- completion from buffer
    "hrsh7th/cmp-nvim-lsp",     -- completion from LSP
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
      },
      sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
        }),
    })
  end
}
