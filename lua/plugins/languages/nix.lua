local M = {}

M.servers = {
	["nil_ls"] = {
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
