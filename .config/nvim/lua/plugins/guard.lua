return {
	"nvimdev/guard.nvim",
	dependencies = {
		"nvimdev/guard-collection",
	},
	event = "BufReadPre",
	config = function()
		local ft = require("guard.filetype")

		ft("c,cpp,json"):fmt("clang-format")

		vim.g.guard_config = {
		  fmt_on_save = false,
			lsp_as_default_formatter = true,
			save_on_fmt = false,
		}

		vim.keymap.set("n", "<leader>z", ":Guard fmt<CR>", opts)
	end,
}
