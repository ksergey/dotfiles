return {
  "sheerun/vim-polyglot",
  -- event = "VeryLazy",
  lazy = false,
  init = function()
    vim.g.polyglot_disabled = {'autoindent'}
    vim.g.cpp_attributes_highlight = 1
    vim.g.cpp_member_highlight = 1
    vim.g.cpp_operator_highlight = 1
    vim.g.cpp_simple_highlight = 1
  end
}
