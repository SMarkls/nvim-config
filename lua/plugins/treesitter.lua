return {
	"nvim-treesitter/nvim-treesitter",
	confg = function()
		require("nvim-treesitter.configs").setup({
			ensure_insalled = { "lua", "markdown" },
			highlight = {
				enable = true,
			},
		})
	end,
}
