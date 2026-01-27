local opts = {
  noremap = true,   -- non-recursive
  silent = true     -- do not show message
}

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

vim.keymap.set("n", "<leader>n", ":set invnumber<CR>", opts)
vim.keymap.set("n", "<leader>b", ":set list!<CR>", opts)
vim.keymap.set("n", "<leader>w", ":set wrap!<CR>", opts)
vim.keymap.set("n", "<leader>h", ":set hlsearch!<CR>", opts)
vim.keymap.set("n", "<leader>q", ":q!<CR>", opts)

vim.keymap.set("n", "1", ":tabprevious<CR>", opts)
vim.keymap.set("n", "3", ":tabnext<CR>", opts)
vim.keymap.set("n", "2", ":tabnew<CR>", opts)

-- @see plugins/format.lua
vim.keymap.set("n", "<leader>z", ":Format<CR>", opts)
