return {
	"stevearc/conform.nvim",
	config = function()
		local langs = require("plugins.languages.langs")
		local formatters_by_ft = {}
		for _, lang in pairs(langs) do
			local formatters = lang.formatters or (type(lang.formatter) == "function" and lang.formatter())
			if type(formatters) == "table" then
				for ft, tools in pairs(formatters) do
					formatters_by_ft[ft] = tools
				end
			end
		end
		require("conform").setup({
			formatters_by_ft = formatters_by_ft,
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
