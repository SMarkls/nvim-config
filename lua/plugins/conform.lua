local langs = require("plugins.languages.langs")
local formatters_by_ft = langs.formatters()
require("conform").setup({
	formatters_by_ft = formatters_by_ft,
})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf, timeout_ms = 10000, lsp_format = "fallback" })
	end,
})
