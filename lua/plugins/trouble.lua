require("trouble").setup({})

vim.keymap.set("n", "<leader>aA", "<Cmd>Trouble diagnostics toggle focus=true<CR>", { desc = "Список ошибок" })
vim.keymap.set("n", "<leader>aa", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", { desc = "Диагностика текущего буфера" })
vim.keymap.set("n", "<leader>cs", "<Cmd>Trouble symbols toggle focus=false<CR>", { desc = "Ошибки в символах" })
vim.keymap.set("n", "<leader>cl", "<Cmd>Trouble lsp toggle focus=false win.position=right<CR>", { desc = "LSP Definitions / references" })
vim.keymap.set("n", "<leader>aL", "<Cmd>Trouble loclist toggle<CR>", { desc = "Location List" })
vim.keymap.set("n", "<leader>aF", "<Cmd>Trouble qflist toggle<CR>", { desc = "Quickfix List" })
