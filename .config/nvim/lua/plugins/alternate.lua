vim.api.nvim_create_autocmd('FileType', {
  pattern = { "c", "cpp", "h", "hpp" },
  callback = function()
    vim.keymap.set("n", "<leader>s", "<cmd>FSHere<cr>", { buffer = true, silent = true })
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = { "*.cpp", "*.cc" },
  callback = function()
    vim.b.fswitchlocs = "./,../include"
    vim.b.fswitchdst = "h,hpp"
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = { "*.h", "*.hpp" },
  callback = function()
    vim.b.fswitchlocs = "./,../src"
    vim.b.fswitchdst = "cpp,cc,c"
  end,
})

return {
  "derekwyatt/vim-fswitch",
}
