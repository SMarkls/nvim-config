return {
	"stevearc/conform.nvim",
	config = function()
    local langs = require"plugins.languages.langs"
    local formatters_by_ft = {}
    for _, lang in pairs(langs) do
      if type(lang.formatter) == "function" then 
        local result = lang.formatter()
        for ft, formatters in pairs(result) do
          formatters_by_ft[ft] = formatters
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
