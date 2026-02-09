-- Keymaps to open in splits
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp', 'h', 'hpp' },
  callback = function()
    vim.keymap.set("n", "<leader>s", "<cmd>FSHere<cr>", { buffer = true, silent = true })
  end,
})

return {
  "derekwyatt/vim-fswitch",
}
