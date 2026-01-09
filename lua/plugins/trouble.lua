return {
	"folke/trouble.nvim",
	opts = {},
	cmd = "Trouble",
	keys = {
		{
			"<leader>aA",
			"<cmd>Trouble diagnostics toggle focus=true<cr>",
			desc = "Список ошибок",
		},
		{
			"<leader>aa",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Диагностика текущего буффера",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Ошибки в символах",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>aL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>aF",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Быстрое исправление ошибок",
		},
	},
}
