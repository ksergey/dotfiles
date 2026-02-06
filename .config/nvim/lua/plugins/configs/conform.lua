vim.keymap.set("n", "<leader>z", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "[F]ormat buffer" })
