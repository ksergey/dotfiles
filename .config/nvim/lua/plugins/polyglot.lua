return {
  "sheerun/vim-polyglot",
  -- event = "VeryLazy",
  lazy = false,
  init = function()
    vim.g.polyglot_disabled = {'autoindent'}
  end
}

