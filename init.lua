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

-- Буфер обмена (system clipboard через xclip/xsel/wl-copy)
vim.opt.clipboard = "unnamedplus"

-- Отключаем стандартные отображения, которые могут отвлекать
vim.opt.ruler = false
-- 0.12: дефолтный 'statusline' — выражение, отображает diagnostics,
-- progress и exit code терминала. lualine снят.
-- bufferline рендерится в 'tabline' — включаем адаптивный показ.
vim.opt.showtabline = 2
vim.opt.winbar = ""

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
vim.opt.secure = true

-- Nvim 0.12: включение UI2 (экспериментальный новый message/cmdline UI).
-- Убирает "Press ENTER", подсвечивает набираемую команду, pager как
-- buffer+window. Документация: :help ui2
pcall(function()
	require("vim._core.ui2").enable()
end)

-- Inlay hints отключены на уровне LSP capabilities (lsp.lua чистит
-- textDocument.inlayHint). Никаких глобальных stub'ов не нужно:
-- vim.lsp.inlay_hint — обычный Lua-модуль, vim.lsp — таблица, но
-- плагины получают оригинальный модуль через require('vim.lsp.inlay_hint'),
-- поэтому присваивание vim.lsp.inlay_hint = ... бесполезно.
-- Snacks.setup ниже сам ставит vim.ui.select = Snacks.picker.select,
-- не переопределяем вручную.

-- Плагины (vim.pack) + конфигурация остальных модулей
require("config.pack")
require("config.keymap")
