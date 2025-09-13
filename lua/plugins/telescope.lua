return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({})
		local builtin = require("telescope.builtin")
		vim.keymap.set(
			"n",
			"<leader>fb",
			builtin.buffers,
			{ desc = "Поиск буфферов (открытых файлов)" }
		)
		vim.keymap.set(
			"n",
			"<leader>fu",
			':lua require("telescope.builtin").lsp_references()<CR>',
			{ desc = "Поиск использований" }
		)
	end,
}
