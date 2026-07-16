local M = {}

M.servers = {
	pyright = {
		settings = {
			pyright = {
				-- Using Ruff's import organizer
				disableOrganizeImports = true,
			},
			python = {
				analysis = {
					-- Ignore all files for analysis to exclusively use Ruff for linting
					-- ignore = { '*' },
					autoImportCompletions = true,
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					diagnosticMode = "openFilesOnly",
				},
			},
		},
	},
	ruff = {
		init_options = {
			settings = {
				configurationPreference = "filesystemFirst",
			},
		},
		on_attach = function(client)
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end,
	},
}

M.formatters = {
	python = {
		"ruff_fix",
		"ruff_format",
		"ruff_organize_imports",
	},
}

return M
