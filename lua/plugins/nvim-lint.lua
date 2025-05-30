return {
	"mfussenegger/nvim-lint",
	config = function()
    local langs = require"plugins.languages.langs"
    local linters_by_ft = {}
    for _, lang in pairs(langs) do
      if type(lang.linter) == "function" then 
        local result = lang.linter()
        for ft, linters in pairs(result) do
          linters_by_ft[ft] = linters
        end
      end
    end
		require("lint").linters_by_ft = linters_by_ft
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
