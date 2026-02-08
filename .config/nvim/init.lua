require("options")
require("mappings")
require("autocmds")

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",  lazypath, })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    require("plugins.format"),
    require("plugins.completion"),
    require("plugins.autopairs"),
    require("plugins.alternate"),
    require("plugins.treesitter"),
    require("plugins.lualine"),
    require("plugins.fzf"),
    require("plugins.colorscheme"),
})

vim.cmd.colorscheme 'tokyonight'
