return {
	{
		"ervandew/supertab",
		init = function()
			vim.g.SuperTabCrMapping = 0
			vim.g.SuperTabDefaultCompletionType = "<c-n>"
		end,
	},
}
