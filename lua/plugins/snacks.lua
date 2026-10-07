require("snacks").setup({
	bigfile = { enabled = true },
	dashboard = {
		enabled = true,
		-- Стандартная секция startup требует lazy.stats; используем vim.pack.
		sections = {
			{ section = "header" },
			{ section = "keys", gap = 1, padding = 1 },
		},
	},
	explorer = { enabled = true },
	indent = { enabled = true },
	input = { enabled = true },
	notifier = { enabled = true, timeout = 1000 },
	picker = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = false },
	statuscolumn = { enabled = true },
	words = { enabled = true },
})

vim.keymap.set("n", "<leader><space>", function() Snacks.picker.smart() end, { desc = "Поиск файлов" })
vim.keymap.set("n", "<leader>fw", function() Snacks.picker.grep() end, { desc = "Поиск слов в проекте" })
vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end, { desc = "История команд" })
vim.keymap.set("n", "<leader>n", function() Snacks.picker.notifications() end, { desc = "История нотификаций" })
vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "Файловая система" })
vim.keymap.set("n", "<leader>fp", function() Snacks.picker.projects() end, { desc = "Поиск по проектам" })
vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Ветки" })
vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Лог" })
vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end, { desc = "Git Status" })
vim.keymap.set("n", "<leader>ff", function() Snacks.picker.lines() end, { desc = "Поиск по открытому файлу" })
vim.keymap.set({ "n", "x" }, "<leader>fs", function() Snacks.picker.grep_word() end, { desc = "Поиск слова или выделенного" })
vim.keymap.set("n", "<leader>sa", function() Snacks.picker.autocmds() end, { desc = "Autocmds" })
vim.keymap.set("n", "<leader>sC", function() Snacks.picker.commands() end, { desc = "Команды" })
vim.keymap.set("n", "<leader>ad", function() Snacks.picker.diagnostics() end, { desc = "Ошибки" })
vim.keymap.set("n", "<leader>aD", function() Snacks.picker.diagnostics_buffer() end, { desc = "Ошибки в файле" })
vim.keymap.set("n", "<leader>fh", function() Snacks.picker.help() end, { desc = "Поиск подсказок" })
vim.keymap.set("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Поиск и вставка иконок" })
vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Поиск сочетаний клавиш" })
vim.keymap.set("n", "<leader>sM", function() Snacks.picker.man() end, { desc = "Почитать Man" })
vim.keymap.set("n", "<leader>uC", function() Snacks.picker.colorschemes() end, { desc = "Цветовые схемы" })
vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Дефиниция" })
vim.keymap.set("n", "gD", function() Snacks.picker.lsp_declarations() end, { desc = "Объявление" })
vim.keymap.set("n", "gr", function() Snacks.picker.lsp_references() end, { desc = "Использования", nowait = true })
vim.keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end, { desc = "Имплементация" })
vim.keymap.set("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Объявление типа" })
vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, { desc = "Код экшн" })
vim.keymap.set("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Переименовать файл" })
vim.keymap.set("n", "<leader>un", function() Snacks.notifier.hide() end, { desc = "Спрятать все нотификации" })
vim.keymap.set("n", "<c-/>",      function() Snacks.terminal() end, { desc = "Терминал" })
vim.keymap.set({ "n", "t" }, "]]",         function() Snacks.words.jump(vim.v.count1) end, { desc = "Следующее вхождение" })
vim.keymap.set({ "n", "t" }, "[[",         function() Snacks.words.jump(-vim.v.count1) end, { desc = "Предыдущее вхождение" })

_G.dd = function(...)
  require("snacks").debug.inspect(...)
end
_G.bt = function()
  require("snacks").debug.backtrace()
end
vim.print = _G.dd -- Override print to use snacks for `:=` command

local snacks = require("snacks")
-- Create some toggle mappings
snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
snacks.toggle.diagnostics():map("<leader>ud")
snacks.toggle.line_number():map("<leader>ul")
snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
snacks.toggle.treesitter():map("<leader>uT")
snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
-- inlay hints отключены глобально (lsp.lua чистит capability)
snacks.toggle.indent():map("<leader>ug")
snacks.toggle.dim():map("<leader>uD")
