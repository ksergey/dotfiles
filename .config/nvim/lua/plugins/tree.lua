vim.keymap.set("n", "<F12>", "<cmd>NvimTreeToggle<cr>", { remap = true })

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
}
