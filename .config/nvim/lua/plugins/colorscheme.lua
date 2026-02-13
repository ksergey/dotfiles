return {
  "rebelot/kanagawa.nvim",
  config = function()
    require("kanagawa").setup({
      transparent = false,
    })

    vim.cmd("colorscheme kanagawa-wave")
  end,
}

-- return {
--   "EdenEast/nightfox.nvim",
--   priority = 1000,
--   config = function(_, opts)
--     require("nightfox").setup({
--       options = {
--         transparent = true,
--         dim_inactive = true,
--         styles = {
--           comments = "italic",
--           keywords = "bold",
--           functions = "italic,bold",
--         },
--         inverse = {
--           search = true,
--           match_paren = true,
--         },
--       },
--       groups = {
--         all = {
--           CursorLine = { bg = "#353A54" },
--           CursorColumn = { bg = "#353A54" },
--         },
--       },
--     })
--
--     vim.cmd.colorscheme 'duskfox'
--   end,
-- }

-- return {
--   "ellisonleao/gruvbox.nvim",
--   priority = 1000 ,
--   config = true,
--   opts = {
--     terminal_colors = true,
--   }
-- }
