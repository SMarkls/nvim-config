-- Rustaceanvim читает настройки при загрузке; подключается до vim.pack.add().
vim.g.rustaceanvim = vim.tbl_deep_extend("force", {
	server = {
		on_attach = function(_, bufnr)
			vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
		end,
	},
}, vim.g.rustaceanvim or {})
