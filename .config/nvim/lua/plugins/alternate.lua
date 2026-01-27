return {
  "jakemason/ouroboros.nvim",
  dependencies = {
		"nvim-lua/plenary.nvim"
	},
  opts = {
    filetypes = {
      c = { "h" },
      h = { "cpp", "c" },
      cpp = { "h", "hpp" },
      hpp = { "cpp" },
    },
    search_dirs = {
      ".",
    },
    create_file_if_missing = true,
  },
}
