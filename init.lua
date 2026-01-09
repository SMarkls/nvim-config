-- Основные настройки
vim.opt.number = true -- Показывать номера строк
vim.opt.relativenumber = true -- Относительные номера строк
vim.opt.expandtab = true -- Использовать пробелы вместо табуляции
vim.opt.shiftwidth = 2 -- Размер отступа при сдвиге
vim.opt.tabstop = 2 -- Размер табуляции
vim.opt.smartindent = false -- Включить умный отступ
vim.opt.wrap = false -- Отключить перенос строк
vim.opt.termguicolors = true -- Включить 24-битные цвета
vim.opt.cursorline = true -- Подсветка текущей строки
vim.opt.splitright = true -- Открывать вертикальные сплиты справа
vim.opt.splitbelow = true -- Открывать горизонтальные сплиты снизу

-- Настройки поиска
vim.opt.ignorecase = true -- Игнорировать регистр при поиске
vim.opt.smartcase = true -- Учитывать регистр, если в поиске есть заглавные буквы
vim.opt.hlsearch = true -- Подсвечивать результаты поиск

-- Интерфейс
vim.opt.showcmd = true -- Показывать команды внизу
vim.opt.showmode = false -- Не показывать режим (например, -- INSERT --)
vim.opt.scrolloff = 8 -- Предварительный скролл перед концом экрана
vim.opt.signcolumn = "yes"

-- Быстрые команды
vim.g.mapleader = " " -- Устанавливаем пробел как leader key

-- Буфер обмена
vim.opt.clipboard = "unnamedplus" -- Буфер обмена работает только через TMux

-- Отключаем стандартные отображения, которые могут отвлекать
vim.opt.ruler = false
vim.opt.showtabline = 0

-- Fillchars
vim.opt.fillchars = {
	vert = "|",
	fold = " ",
	--  eob = " ",
	msgsep = "⎺",
	foldopen = "▼",
	foldsep = "|",
	foldclose = "▶",
}

vim.opt.exrc = true

-- Плагины
require("config.colorscheme")
require("config.lazy")
require("config.keymap")
