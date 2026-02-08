vim.keymap.set("n", "<leader>f", "<cmd>Files<cr>", { desc = "Search files in current dir", remap = true })
vim.keymap.set("n", "<leader>g", "<cmd>GitFiles<cr>", { desc = "Search files in current git repo", remap = true })

return {
  "junegunn/fzf.vim",
  dependencies = {
    { "junegunn/fzf", build = "./install --all", }
  },
  event = { "VeryLazy" },
  config = function()
    vim.cmd([[ let g:fzf_preview_window = '' ]])
  end
}
