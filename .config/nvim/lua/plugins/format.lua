local function format()
  require("conform").format {
    lsp_fallback = true,
  }
end

vim.keymap.set("n", "<leader>z", format, { desc = "Format", silent = true })

vim.api.nvim_create_user_command("Format", format, { desc = "Format current buffer with LSP" })

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      cpp = { "clang-format" },
      c = { "clang-format" },
    },
  },
}
