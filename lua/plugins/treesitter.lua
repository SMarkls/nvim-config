local treesitter = require("nvim-treesitter")
treesitter.setup({})

local M = {
	parsers = {
		"lua", "markdown", "markdown_inline", "go", "gomod", "gosum", "gowork",
		"proto", "yaml", "python", "json", "javascript", "typescript", "tsx", "c", "cpp", "rust",
	},
}

-- install() пропускает уже установленные парсеры и работает асинхронно.
M.install_task = treesitter.install(M.parsers)

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("TreesitterFeatures", { clear = true }),
	callback = function(event)
		local ft = vim.bo[event.buf].filetype
		local language = vim.treesitter.language.get_lang(ft)
		if ft == "csv" or not language then
			return
		end
		local ok, available = pcall(vim.treesitter.language.add, language)
		if not ok or not available then
			return
		end
		vim.treesitter.start(event.buf, language)
		vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

require("treesitter-context").setup({
	enable = true,
	mode = "topline",
	line_numbers = true,
	max_lines = 5,
})

require("nvim-treesitter-textobjects").setup({
	select = { lookahead = true },
})

return M
