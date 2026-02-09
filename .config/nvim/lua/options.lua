-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.deprecate = function() end -- Disable annoying deprecated message

vim.cmd([[ filetype plugin indent on ]])

-- Enable break indent
vim.opt.breakindent = true

vim.opt.backspace = { "eol", "start", "indent" } -- allow backspacing over everything in insert mode
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.encoding = "utf-8" -- the encoding
vim.opt.matchpairs = { "(:)", "{:}", "[:]", "<:>" }
vim.opt.syntax = "enable"

-- indention
local indent = 4
vim.opt.autoindent = true -- auto indentation
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = indent -- the number of spaces inserted for each indentation
vim.opt.smartindent = true -- make indenting smarter
vim.opt.softtabstop = indent -- when hitting <BS>, pretend like a tab is removed, even if spaces
vim.opt.tabstop = indent -- insert 2 spaces for a tab
vim.opt.shiftround = true -- use multiple of shiftwidth when indenting with "<" and ">"

-- tabline
vim.opt.showtabline = 2 -- always show tabs
vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"
-- search
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns unless \C or one or more capital letters in the search term
vim.opt.smartcase = true -- smart case
vim.opt.wildignore = vim.opt.wildignore + { "*/node_modules/*", "*/.git/*", "*/vendor/*" }
vim.opt.wildmenu = true -- make tab completion for files/buffers act like bash
vim.opt.inccommand = "split" -- review substitutions live, as you type

-- ui
vim.opt.cursorline = false -- highlight the current line
vim.opt.laststatus = 2 -- only the last window will always have a status line
vim.opt.lazyredraw = true -- don"t update the display while executing macros
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.opt.list = true
-- You can also add "space" or "eol", but I feel it"s quite annoying
vim.opt.listchars = {
    tab = "┊ ",
    trail = "·",
    extends = "»",
    precedes = "«",
    nbsp = "×",
}
vim.opt.termguicolors = true -- enable 24-bit RGB colors

-- Hide cmd line
vim.opt.cmdheight = 0 -- more space in the neovim command line for displaying messages

vim.opt.mouse = "" -- don't allow the mouse to be used in neovim
vim.opt.number = true -- set numbered lines
-- opt.relativenumber = true -- set relative numbered lines, to help with jumping.
vim.opt.scrolloff = 18 -- minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 3 -- minimal number of screen columns to keep to the left and right (horizontal) of the cursor if wrap is `false`
vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
vim.opt.splitbelow = true -- open new split below
vim.opt.splitright = true -- open new split to the right
vim.opt.wrap = true -- display a wrapped line

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- backups
vim.opt.backup = false -- create a backup file
vim.opt.swapfile = false -- creates a swapfile
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- autocomplete
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
vim.opt.shortmess = vim.opt.shortmess + {
    c = true,
} -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"

-- By the way, -- INSERT -- is unnecessary anymore because the mode information is displayed in the statusline.
vim.opt.showmode = false

-- perfomance
-- remember N lines in history
vim.opt.history = 100 -- keep 100 lines of history
vim.opt.redrawtime = 1500
vim.opt.timeoutlen = 250 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 100 -- signify default updatetime 4000ms is not good for async update

-- theme
vim.opt.termguicolors = true -- enable 24-bit RGB colors

-- persistent undo
-- Don"t forget to create folder $HOME/.local/share/nvim/undo
vim.opt.undofile = true -- enable persistent undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- fold
vim.opt.foldmethod = "marker"
vim.opt.foldlevel = 99

-- Disable builtin plugins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-- Enable virtual_lines feature if the current nvim version is 0.11+
if vim.fn.has("nvim-0.11") > 0 then
    vim.diagnostic.config({
        -- Use the default configuration
        -- virtual_lines = true,

        -- Alternatively, customize specific options
        virtual_lines = {
            -- Only show virtual line diagnostics for the current cursor line
            current_line = true,
        },
    })
end
