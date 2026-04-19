return {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("kanagawa-paper").setup({
            -- enable undercurls for underlined text
            undercurl = true,
            -- transparent background
            transparent = false,
            -- highlight background for the left gutter
            gutter = false,
            -- background for diagnostic virtual text
            diag_background = true,
            -- dim inactive windows. Disabled when transparent
            dim_inactive = false,
            -- set colors for terminal buffers
            terminal_colors = true,
            -- cache highlights and colors for faster startup.
            -- see Cache section for more details.
            cache = false,

            styles = {
                -- style for comments
                comment = { italic = true },
                -- style for functions
                functions = { italic = false },
                -- style for keywords
                keyword = { italic = false, bold = false },
                -- style for statements
                statement = { italic = false, bold = false },
                -- style for types
                type = { italic = false },
            },
        })

        vim.cmd.colorscheme("kanagawa-paper-ink")
    end,
    opts = {},
}
