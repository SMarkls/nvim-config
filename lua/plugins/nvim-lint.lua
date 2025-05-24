return {
	"mfussenegger/nvim-lint",
	config = function()
		-- ЗДЕСЬ НУЖНО УКАЗАТЬ ВСЕ ЛИНТЕРЫ, КОТОРЫЕ ДОЛЖНЫ ИСПОЛЬЗОВАТЬСЯ
		require("lint").linters_by_ft = {
			typescript = { "eslint" },
			typescriptreact = { "eslint" },
			javascript = { "eslint" },
			javascriptreact = { "eslint" },
      lua = { "selene" },
		}
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
