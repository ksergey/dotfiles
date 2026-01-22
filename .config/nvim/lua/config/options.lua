vim.opt.expandtab = true            -- Преобразовать табы в пробелы
vim.opt.smarttab = true             -- Умная вставка табов
vim.opt.smartindent = true          -- Автоматические отступы
vim.opt.tabstop = 2                 -- Какой ширины выглядит символ таба в файле
vim.opt.softtabstop = 2             -- На сколько колонок двигает/удаляет Tab и Backspace
vim.opt.shiftwidth = 2              -- Размер отступа для >> и <<

vim.opt.number = true               -- Показывать номера строк
vim.opt.numberwidth = 2             -- Ширина колонки с номерами
vim.opt.fillchars = { eob = " "  }  -- Убрать символ ~ в конце буфера (визуальный мусор)
vim.opt.cursorline = true           -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true           -- open new vertical split bottom
vim.opt.splitright = true           -- open new horizontal splits right

vim.opt.incsearch = true            -- search as characters are entered
vim.opt.hlsearch = true             -- highlight matches
vim.opt.ignorecase = true           -- Игнорировать регистр при поиске
vim.opt.smartcase = true            -- Но учитывать, если в запросе есть заглавные буквы

vim.opt.termguicolors = true        -- Поддержка 24-bit цветов
vim.opt.mouse = ""                  -- Включить мышь во всех режимах
vim.opt.wrap = true                 -- Автоматический перенос длинных строк

vim.opt.undofile = true             -- Сохранять историю отмен между сессиями
vim.opt.swapfile = false            -- Отключить swap-файлы (они раздражают)
vim.opt.fileencoding = "utf-8"      -- Кодировка файлов
vim.opt.clipboard = "unnamedplus"   -- Использовать системный буфер обмена

vim.o.showtabline = 2
