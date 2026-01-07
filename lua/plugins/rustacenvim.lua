return {
	"mrcjkb/rustaceanvim",
	version = "^6", -- Recommended
	lazy = false, -- This plugin is already lazy
	config = function()
		vim.g.rustaceanvim = vim.tbl_deep_extend("force", {
			tools = {
				inlay_hints = {
					auto = false,
				},
			},
		}, vim.g.rustaceanvim or {})
	end,
}
