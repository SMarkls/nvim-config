return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		{ "nvim-treesitter/nvim-treesitter-textobjects" }, -- Syntax aware text-objects
		{
			"nvim-treesitter/nvim-treesitter-context", -- Show code context
			opts = { enable = true, mode = "topline", line_numbers = true },
		},
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"lua",
				"markdown",
				"go",
				"gomod",
				"gosum",
				"gowork",
				"proto",
				"yaml",
				"python",
				"json",
				"javascript",
				"typescript",
			},
			indent = { enable = true },
			auto_install = true,
			sync_install = false,
			highlight = {
				enable = true,
				disable = { "csv" }, -- preferring chrisbra/csv.vim
			},
			textobjects = { select = { enable = true, lookahead = true } },
		})
	end,
}
