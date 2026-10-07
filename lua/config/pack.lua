-- vim.pack управляет установкой, версиями и подключением пакетов.
-- Конфигурации ниже — обычные Lua-модули с прямыми setup() и keymap.set().
-- :packupdate / :packdel; ревизии хранятся в nvim-pack-lock.json.
local gh = function(repo) return "https://github.com/" .. repo end

vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("TreesitterPackUpdate", { clear = true }),
	callback = function(event)
		local data = event.data
		if data.spec.name == "nvim-treesitter" and (data.kind == "install" or data.kind == "update") then
			vim.cmd.packadd("nvim-treesitter")
			require("nvim-treesitter").update()
		end
	end,
})

require("plugins.rustacenvim")

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
	{ src = gh("folke/snacks.nvim") },
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
	{ src = gh("nickkadutskyi/jb.nvim") },

	-- Rust
	{ src = gh("mrcjkb/rustaceanvim"), version = vim.version.range("^6") },
})

vim.o.background = "light"
vim.cmd.colorscheme("jb")

require("plugins.snacks")
require("plugins.mason")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.cmp")
require("plugins.bufferline")
require("plugins.autoclose")
require("plugins.autotag")
require("plugins.clangd_extensions")
require("plugins.conform")
require("plugins.gitsigns")
require("plugins.leap")
require("plugins.nvim-dap")
require("plugins.nvim-dap-python")
require("plugins.nvim-dap-ui")
require("plugins.nvim-lint")
require("plugins.telescope")
require("plugins.terminal")
require("plugins.trouble")
require("plugins.which-key")
require("plugins.autosave")
