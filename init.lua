-- Основные настройки
vim.opt.number = true                -- Показывать номера строк
vim.opt.relativenumber = true        -- Относительные номера строк
vim.opt.expandtab = true             -- Использовать пробелы вместо табуляции
vim.opt.shiftwidth = 4               -- Размер отступа при сдвиге
vim.opt.tabstop = 2                  -- Размер табуляции
vim.opt.smartindent = false          -- Включить умный отступ
vim.opt.wrap = false                 -- Отключить перенос строк
vim.opt.termguicolors = true         -- Включить 24-битные цвета
vim.opt.cursorline = true            -- Подсветка текущей строки
vim.opt.splitright = true            -- Открывать вертикальные сплиты справа
vim.opt.splitbelow = true            -- Открывать горизонтальные сплиты снизу

-- Настройки поиска
vim.opt.ignorecase = true            -- Игнорировать регистр при поиске
vim.opt.smartcase = true             -- Учитывать регистр, если в поиске есть заглавные буквы
vim.opt.hlsearch = true              -- Подсвечивать результаты поиск

-- Интерфейс
vim.opt.showcmd = true               -- Показывать команды внизу
vim.opt.showmode = true              -- Не показывать режим (например, -- INSERT --)

-- Быстрые команды
vim.g.mapleader = " "                -- Устанавливаем пробел как leader key
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open current directory" })
-- vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })

-- Буфер обмена
vim.opt.clipboard = "unnamedplus"


-- Отключаем стандартные отображения, которые могут отвлекать
vim.opt.ruler = false
vim.opt.showtabline = 0
vim.opt.laststatus = 0

-- Настройка цветов
vim.cmd[[colorscheme default]]        -- Выбираем цветовую схему (можно изменить)

-- Плагины
require("config.lazy")
