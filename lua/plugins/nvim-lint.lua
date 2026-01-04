return {
	"mfussenegger/nvim-lint",
	config = function()
		local langs = require("plugins.languages.langs")
		local linters_by_ft = {}
		for _, lang in pairs(langs) do
			local linters = lang.linters or (type(lang.linter) == "function" and lang.linter())
			if type(linters) == "table" then
				for ft, tools in pairs(linters) do
					linters_by_ft[ft] = tools
				end
			end
		end
		require("lint").linters_by_ft = linters_by_ft
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
