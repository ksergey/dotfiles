local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local completion = function(fallback)
  local cmp = require("cmp")
  local luasnip = require("luasnip")

  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  elseif has_words_before() then
    cmp.complete()
  else
    fallback()
  end
end

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-buffer",
    "L3MON4D3/LuaSnip",
  },
  event = { "InsertEnter" },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- load snippets
    require("luasnip.loaders.from_snipmate").lazy_load()

    cmp.setup({
      completion = {
        keyword_length = 4,
        autocomplete = false,
      },
      snippets = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end
      },
      mapping = {
        ["<Tab>"] = cmp.mapping(completion, { "i", "s" }),
        ['<cr>'] = cmp.mapping.confirm({ select = true }),
      },
      sources = cmp.config.sources({
        { name = 'luasnip', keyword_length = 2 },
        { name = "nvim_lsp" },
        { name = "buffer" },
      }),
    })
  end,
}
