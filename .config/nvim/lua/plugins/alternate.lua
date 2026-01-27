return {
  "jakemason/ouroboros.nvim",
  dependencies = {
		"nvim-lua/plenary.nvim"
	},
  opts = {
    filetypes = {
      c = { "h" },
      h = { "c", "cpp" },
      cpp = { "h", "hpp" },
      hpp = { "cpp", "cc" },
      cc = { "hh", "h" },
    },
    search_dirs = {
      ".",
    },
    create_file_if_missing = true,
  },
}
