local M = {}

M.servers = {
	["nil"] = {
		settings = {
			["nil"] = {
				formatting = {
					command = { "nixfmt" },
				},
			},
		},
	},
}

M.formatters = {
	nix = { "nixfmt" },
}

return M
