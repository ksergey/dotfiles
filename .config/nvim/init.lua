vim.opt.termguicolors = true -- enable 24-bit RGB colors
vim.deprecate = function() end -- Disable annoying deprecated message

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load default configurations and plugins
for _, source in ipairs({
    "plugins",
    "options",
    "mappings",
    "autocmds",
}) do
    local ok, fault = pcall(require, source)
    if not ok then
        vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault)
    end
end

vim.cmd.colorscheme 'rose-pine'
