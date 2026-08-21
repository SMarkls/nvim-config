-- Nvim 0.12: встроенный plugin manager vim.pack.
-- Документация: :help vim.pack
-- Все плагины ставятся в `stdpath('data')..'/site/pack/core/opt'`.
-- Лок-файл: 'packlockfile' (по умолчанию nvim-pack-lock.json в stdpath('config')).
-- Команды:
--   :packupdate            — обновить все
--   :packupdate <name>     — обновить конкретный
--   :packdel <name>        — удалить
--   :packupdate ++offline  — без скачивания
--   :packupdate ++lockfile — установить ревизии из лок-файла

local gh = function(repo) return "https://github.com/" .. repo end

-- Плагины бывшей конфигурации на lazy.nvim. version = nil => используется
-- ветка по умолчанию (main/master). После первого запуска фиксируйте
-- ревизии в лок-файле.
vim.pack.add({
	-- Менеджер LSP-серверов (mason не заменяется vim.pack)
	gh("williamboman/mason.nvim"),

	-- LSP
	{ src = gh("neovim/nvim-lspconfig") },
	{ src = gh("mfussenegger/nvim-lint") },
	{ src = gh("p00f/clangd_extensions.nvim") },

	-- Completion (оставляем nvim-cmp + vsnip)
	{ src = gh("hrsh7th/nvim-cmp") },
	{ src = gh("hrsh7th/cmp-nvim-lsp") },
	{ src = gh("hrsh7th/cmp-buffer") },
	{ src = gh("hrsh7th/cmp-path") },
	{ src = gh("hrsh7th/cmp-cmdline") },
	{ src = gh("hrsh7th/vim-vsnip") },
	{ src = gh("hrsh7th/cmp-vsnip") },

	-- Treesitter
	{ src = gh("nvim-treesitter/nvim-treesitter") },
	{ src = gh("nvim-treesitter/nvim-treesitter-textobjects") },
	{ src = gh("nvim-treesitter/nvim-treesitter-context") },
	{ src = gh("windwp/nvim-ts-autotag") },

	-- LSP / форматтеры / дебаг
	{ src = gh("stevearc/conform.nvim") },
	{ src = gh("mfussenegger/nvim-dap") },
	{ src = gh("mfussenegger/nvim-dap-python") },
	{ src = gh("rcarriga/nvim-dap-ui") },
	{ src = gh("nvim-neotest/nvim-nio") },

	-- Утилиты
	{ src = gh("folke/snacks.nvim"), priority = 1000 },
	{ src = gh("folke/trouble.nvim") },
	{ src = gh("folke/which-key.nvim") },
	{ src = gh("akinsho/bufferline.nvim") },
	{ src = gh("nvim-tree/nvim-web-devicons") },
	{ src = gh("lewis6991/gitsigns.nvim") },
	{ src = gh("okuuva/auto-save.nvim") },
	{ src = gh("m4xshen/autoclose.nvim") },

	-- Terminal
	{ src = gh("akinsho/toggleterm.nvim") },
	{ src = gh("nvim-lua/plenary.nvim") },
	{ src = gh("MunifTanjim/nui.nvim") },
	{ src = gh("nvim-telescope/telescope.nvim") },

	-- Прыжки / движение
	{ src = "https://codeberg.org/andyg/leap.nvim" },

	-- Цветовая схема
	{ src = gh("folke/tokyonight.nvim"), priority = 1000 },

	-- Rust
	{ src = gh("mrcjkb/rustaceanvim"), version = vim.version.range("^6") },
})

-- Загрузка specs из lua/plugins/*.lua. Без lazy.nvim файлы specs
-- не выполняются автоматически, поэтому подключаем их вручную.
-- Каждый файл может вернуть:
--   * spec (таблица с полем `config`) — вызываем config()
--   * массив specs — обрабатываем каждый
--   * функцию — вызываем как setup
-- Сортировка: сначала plugins с lazy=false / priority=1000 (snacks, tokyonight),
-- потом остальные по алфавиту для детерминированности.
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "plugins")
local spec_files = vim.fn.glob(plugins_dir .. "/*.lua", true, true)

local PRIORITY_FILES = {
	"snacks.lua", -- priority=1000, lazy=false
	"tokyonight.lua", -- priority=1000, lazy=false
	"bufferline.lua", -- требует nvim-web-devicons
	"treesitter.lua", -- инфраструктура парсинга
	"languages/langs.lua", -- база для LSP-серверов
	"lsp.lua", -- конфигурация LSP
	"mason.lua", -- установка LSP-серверов
}

local function priority_index(name)
	for i, n in ipairs(PRIORITY_FILES) do
		if name:match("/?" .. vim.pesc(n) .. "$") then
			return i
		end
	end
	return math.huge
end

local function run_spec(spec)
	if type(spec) == "function" then
		pcall(spec)
		return
	end
	if type(spec) ~= "table" then
		return
	end
	if spec.config and type(spec.config) == "function" then
		pcall(spec.config)
	end
	-- lazy-стиль: { "user/plugin", opts = {...} } — setup плагина
	-- с переданными opts. Делаем ДО init, чтобы init мог пользоваться
	-- уже настроенным плагином.
	if spec.opts ~= nil then
		-- Возможные имена модулей (по приоритету):
		-- 1) spec.name (если задано явно)
		-- 2) имя репо (последний сегмент "user/repo")
		-- 3) с подстрокой .nvim (например "snacks.nvim" → "snacks")
		local candidates = {}
		if type(spec.name) == "string" then
			candidates[#candidates + 1] = spec.name
		end
		if type(spec[1]) == "string" then
			local repo = spec[1]
			local base = repo:match("([^/]+)$") or repo
			candidates[#candidates + 1] = base
			-- "snacks.nvim" → "snacks"
			local stripped = base:gsub("%.nvim$", "")
			if stripped ~= base then
				candidates[#candidates + 1] = stripped
			end
		end
		for _, mod_name in ipairs(candidates) do
			local ok, mod = pcall(require, mod_name)
			if ok and type(mod.setup) == "function" then
				pcall(mod.setup, spec.opts)
				break
			end
		end
	end
	-- lazy-стиль: init = function() ... end — вызывается сразу при загрузке.
	if spec.init and type(spec.init) == "function" then
		pcall(spec.init)
	end
	-- lazy-стиль: keys = { { lhs, rhs, desc=..., mode=... }, ... } —
	-- устанавливает keymap сразу при загрузке (lazy регистрирует их как
	-- "pending" и активирует при первом использовании; мы ставим сразу).
	if type(spec.keys) == "table" then
		for _, k in ipairs(spec.keys) do
			if type(k) == "string" then
				-- просто lhs, без действия — пропускаем
			elseif type(k) == "table" and k[1] then
				local opts = {}
				for key, val in pairs(k) do
					if type(key) == "number" then
						-- skip positional
					elseif key == "desc" or key == "mode" or key == "nowait" or key == "silent" or key == "buffer" then
						opts[key] = val
					end
				end
				if k[2] ~= nil then
					pcall(vim.keymap.set, opts.mode or "n", k[1], k[2], opts)
				end
			end
		end
	end
end

table.sort(spec_files, function(a, b)
	local pa = priority_index(a)
	local pb = priority_index(b)
	if pa ~= pb then
		return pa < pb
	end
	return a < b
end)

for _, file in ipairs(spec_files) do
	local ok, result = pcall(dofile, file)
	if not ok then
		vim.schedule(function()
			vim.notify("pack: ошибка загрузки " .. file .. ": " .. tostring(result), vim.log.levels.ERROR)
		end)
	elseif type(result) == "table" then
		-- Эвристика: spec-таблица vs массив specs
		if
			result.src
			or result.name
			or result.config
			or result.opts
			or result.event
			or result.cmd
			or result.ft
			or result.keys
			or result.lazy ~= nil
			or result.dependencies
		then
			run_spec(result)
		else
			for _, item in ipairs(result) do
				run_spec(item)
			end
		end
	end
end

-- Эмуляция lazy.nvim VeryLazy больше не нужна: snacks и другие плагины,
-- которым требовался VeryLazy, в нашей реализации вызываются
-- синхронно в init-блоках через require('snacks').toggle.* и т.п.
-- (см. plugins/snacks.lua). Оставлено как no-op для обратной
-- совместимости на случай, если какой-то плагин вешает User VeryLazy.
pcall(vim.api.nvim_exec_autocmds, "User", { pattern = "VeryLazy", modeline = false })
