return {
	{
		"derekwyatt/vim-fswitch",
		init = function()
			vim.keymap.set("n", "<Leader>s", ":FSHere<CR>", {})
		end,
	},
}
