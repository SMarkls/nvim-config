return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("telescope").setup({})
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Поиск файлов в проекте" })
		vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "Поиск слов в проекте" })
		vim.keymap.set(
			"n",
			"<leader>fb",
			builtin.buffers,
			{ desc = "Поиск буфферов (открытых файлов)" }
		)
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Поиск подсказок" })
		vim.keymap.set(
			"n",
			"<leader>fu",
			':lua require("telescope.builtin").lsp_references()<CR>',
			{ desc = "Поиск использований" }
		)
	end,
}
