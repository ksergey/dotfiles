-- @see plugins/alternate.lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.keymap.set("n", "<leader>s", ":Ouroboros<CR>", {
      buffer = true,
    })
  end
})

-- Drop spaces at end of line on write
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]]
})
