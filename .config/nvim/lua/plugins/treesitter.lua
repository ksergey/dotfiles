return {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    opts = {
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
        folding = {
            enable = true,
        },
    },
}
