-- <leader> is a space now
local map = vim.keymap.set

-- Comment
vim.keymap.set("n", "mm", "gcc", { desc = "Toggle comment", remap = true })
vim.keymap.set("v", "mm", "gc", { desc = "Toggle comment", remap = true })

-- Tabs
vim.keymap.set("n", "1", "<cmd>:tabprevious<cr>", { desc = "Select previouse tab" })
vim.keymap.set("n", "2", "<cmd>:tabnew<cr>", { desc = "Create new tab" })
vim.keymap.set("n", "3", "<cmd>:tabnext<cr>", { desc = "Select next tab" })

-- Close current buffer
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Close current buffer", remap = true })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")

-- Toggles
vim.keymap.set("n", "<leader>n", "<cmd>set invnumber<cr>", { desc = "Toggle show line numbers", remap = true })
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<cr>", { desc = "Toggle wrap lines", remap = true })
vim.keymap.set("n", "<leader>h", "<cmd>set hlsearch!<cr>", { desc = "Toggle search highlight", remap = true })
vim.keymap.set("n", "<leader>p", "<cmd>set paste!<cr>", { desc = "Toggle paste mode", remap = true })
