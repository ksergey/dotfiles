-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = "200",
        })
    end,
})

-- Remove whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "",
    command = ":%s/\\s\\+$//e",
})

-- Don"t auto commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "",
    command = "set fo-=c fo-=r fo-=o",
})

vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "lua", },
    command = "set sw=2 ts=2",
})

vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "c", "cpp" },
    command = "set textwidth=120",
})

vim.api.nvim_create_autocmd("Filetype", {
  pattern = { "c", "cpp" },
  callback = function()
    -- Enable Doxygen highlighting
    vim.g.load_doxygen_syntax = 1
  end
})

vim.api.nvim_create_autocmd("Filetype", {
    pattern = { "gitcommit", "markdown", "text" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})
