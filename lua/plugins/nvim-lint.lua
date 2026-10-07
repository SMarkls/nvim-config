local langs = require("plugins.languages.langs")
local linters_by_ft = langs.linters()
require("lint").linters_by_ft = linters_by_ft
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function(args)
		local lint = require("lint")
		local fts = lint.linters_by_ft or {}
		local ft_linters = fts[vim.bo[args.buf].filetype] or {}
		if #ft_linters > 0 then
			lint.try_lint()
		end
	end,
})
