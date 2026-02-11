return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  opts = {
    nbsp = "\xc2\xa0",
    file_icon_padding = " ",
    winopts = {
      split = "belowright new",
      preview = {
        hidden = true,
      },
    },
    fzf_opts = {
      ["--layout"] = "reverse-list",
    },
    files = {
      git_icons = false,
      file_icons = false,
      color_icons = false,
    },
    git = {
      files = {
        git_icons = false,
        file_icons = false,
        color_icons = false,
      },
    },
  },
  keys = {
    { "<leader>f", "<cmd>FzfLua files<cr>", desc = "Search files in current dir" },
    { "<leader>g", "<cmd>FzfLua git_files<cr>", desc = "Search files in current git repo" },
  },
}
