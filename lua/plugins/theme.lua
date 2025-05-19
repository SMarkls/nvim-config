return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		transparent_background = true,
		dim_inactive = {
			enabled = false, -- dims the background color of inactive window
			shade = "dark",
			percentage = 0.15, -- percentage of the shade to apply to the inactive window
		},
		integrations = {
			gitsigns = true,
			nvimtree = true,
			treesitter = true,
		},
	},
}
