return {
  "nvim-treesitter/nvim-treesitter",
  opts = { ensure_installed = { 'c', 'cpp' } },
  lazy = false,
  build = ":TSUpdate"
}
