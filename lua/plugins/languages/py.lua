local M = {}

local function ensure_dap_keymaps()
	if M._dap_keys_set then
		return
	end
	vim.keymap.set(
		"n",
		"<leader>b",
		":DapToggleBreakpoint <CR>",
		{ desc = "Включить/отключить breakpoint" }
	)
	vim.keymap.set("n", "<F1>", ":DapStepInto <CR>", { desc = "Шаг с заходом" })
	vim.keymap.set("n", "<F2>", ":DapStepOver <CR>", { desc = "Шаг с обходом" })
	vim.keymap.set("n", "<F3>", ":DapStepOut <CR>", { desc = "Шаг с выходом" })
	M._dap_keys_set = true
end

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
		on_attach = function()
			ensure_dap_keymaps()
		end,
	},
	ruff = {
		init_options = {
			settings = {
				configurationPreference = "filesystemFirst",
				lineLength = 80,
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
