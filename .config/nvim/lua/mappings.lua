-- <leader> is a space now
local map = vim.keymap.set

-- Fuck F1
vim.keymap.set({ "n", "i", "v", "x" }, "<F1>", "<esc>")

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

-- Move around panes Alt+h/j/k/l
vim.keymap.set("", "<A-h>", "<C-w>h", { remap = true })
vim.keymap.set("", "<A-j>", "<C-w>j", { remap = true })
vim.keymap.set("", "<A-k>", "<C-w>k", { remap = true })
vim.keymap.set("", "<A-l>", "<C-w>l", { remap = true })

-- Moving
vim.keymap.set("n", "<PageUp>", "<C-u><C-u>")
vim.keymap.set("i", "<PageUp>", "<C-o><C-u><C-o><C-u>")
vim.keymap.set("n", "<PageDown>", "<C-d><C-d>")
vim.keymap.set("i", "<PageDown>", "<C-o><C-d><C-o><C-d>")
vim.keymap.set("n", "<Up>", "gk")
vim.keymap.set("i", "<Up>", "<C-o>gk")
vim.keymap.set("n", "<Down>", "gj")
vim.keymap.set("i", "<Down>", "<C-o>gj")
