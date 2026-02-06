-- Description: init plugins config
local builtin_plugins = {
    -- Formatter
    -- Lightweight yet powerful formatter plugin for Neovim
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    cpp = { "clang-format" },
                    c = { "clang-format" },
                },
            })

            local function format()
                require("conform").format {
                    lsp_fallback = true,
                }
            end

            vim.keymap.set({ "n", "i" }, "<leader>z", format, { desc = "Format", silent = true })

            vim.api.nvim_create_user_command("Format", format, { desc = "Format current buffer with LSP" })
        end,
    },
    -- Code completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
          "hrsh7th/cmp-buffer",
          "L3MON4D3/LuaSnip",
        },
        event = { "InsertEnter" },
        config = function()
            local cmp = require("cmp")
            local types = require("cmp.types")
            local luasnip = require("luasnip")

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            -- load snippets
            require("luasnip.loaders.from_snipmate").lazy_load()

            cmp.setup({
                completion = {
                    keyword_length = 4,
                },
                snippets = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                mapping = {
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ['<cr>'] = cmp.mapping.confirm({ select = true }),
                },
                sources = cmp.config.sources({
                    { name = 'luasnip', keyword_length = 2 },
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                }),
            })
        end,
    },
    -- Alternate between header and implemetation files
    {
        "jakemason/ouroboros.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        ft = { "c", "h", "cpp", "hpp" },
        config = function()
            require("ouroboros").setup({
                extension_preferences_table = {
                    c = { h = 2 },
                    h = { cpp = 2, h = 1 },
                    cpp = { h = 2, hpp = 1 },
                    hpp = { cpp = 2, h = 1 },
                },
                -- optionally other settings
                switch_to_open_pane_if_possible = false,
            })

            -- Keymaps to open in splits
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'c', 'cpp', 'h', 'hpp' },
                callback = function()
                    vim.keymap.set("n", "<leader>s", "<cmd>Ouroboros<cr>", { buffer = true, silent = true })
                end
            })
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = { "InsertEnter" },
        config = true
    },
    -- Git integration for buffers
    -- {
    --     "lewis6991/gitsigns.nvim",
    --     event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    --     opts = function()
    --         require("plugins.configs.gitsigns")
    --     end,
    -- },
    -- Treesitter interface
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old and doesn't work on Windows
        event = { "BufReadPost", "BufNewFile", "BufWritePost" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        opts = function()
            require("plugins.configs.treesitter")
        end,
    },
    -- Statusline
    -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
          "nvim-tree/nvim-web-devicons"
        },
        opts = function()
            require("plugins.configs.lualine")
        end,
    },
    -- colorscheme
    {
        -- Rose-pine - Soho vibes for Neovim
        "rose-pine/neovim",
        name = "rose-pine",
        opts = {
            dark_variant = "main",
            extend_background_behind_borders = true,
            styles = {
                bold = true,
                italic = true,
                transparency = false,
            },
        },
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
        "junegunn/fzf.vim",
        dependencies = {
            { "junegunn/fzf", build = "./install --all", }
        },
        event = { "VeryLazy" },
        config = function()
            vim.keymap.set("n", "<leader>f", "<cmd>Files<cr>", { desc = "Search files in current dir", remap = true })
            vim.keymap.set("n", "<leader>g", "<cmd>GitFiles<cr>", { desc = "Search files in current git repo", remap = true })
        end,
    },
}

local exist, custom = pcall(require, "custom")
local custom_plugins = exist and type(custom) == "table" and custom.plugins or {}

-- Check if there is any custom plugins
-- local ok, custom_plugins = pcall(require, "plugins.custom")
require("lazy").setup({
    spec = { builtin_plugins, custom_plugins },
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json", -- lockfile generated after running update.
    defaults = {
        lazy = false, -- should plugins be lazy-loaded?
        version = nil,
        -- version = "*", -- enable this to try installing the latest stable versions of plugins
    },
    ui = {
        icons = {
            ft = "",
            lazy = "󰂠",
            loaded = "",
            not_loaded = "",
        },
    },
    install = {
        -- install missing plugins on startup
        missing = true,
    },
    checker = {
        -- automatically check for plugin updates
        enabled = true,
        -- get a notification when new updates are found
        -- disable it as it's too annoying
        notify = false,
        -- check for updates every day
        frequency = 86400,
    },
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        -- get a notification when changes are found
        -- disable it as it's too annoying
        notify = false,
    },
    performance = {
        cache = {
            enabled = true,
        },
    },
    state = vim.fn.stdpath("state") .. "/lazy/state.json", -- state info for checker and other things
})
