local M = {}

M.lsp_name = "pyright"

function M.lsp(capabilities)
	vim.lsp.config[M.lsp_name] = {
		capabilities = capabilities,
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
	}

	vim.lsp.config("ruff", {
		capabilities = capabilities,
		init_options = {
			settings = {
				configurationPreference = "filesystemFirst",
				lineLength = 80,
			},
		},
	})
	vim.lsp.enable("ruff")

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client == nil then
				return
			end
			if client.name == "ruff" then
				-- Disable hover in favor of Pyright
				client.server_capabilities.hoverProvider = false
			end
		end,
		desc = "LSP: Disable hover capability from Ruff",
	})
end

function M.formatter()
	return {
		python = {
			"ruff_fix",
			"ruff_format",
			"ruff_organize_imports",
		},
	}
end

function M.linter()
	return {
		python = { "ruff" },
	}
end

function M.keybindings()
	vim.keymap.set(
		"n",
		"<leader>b",
		":DapToggleBreakpoint <CR>",
		{ desc = "Включить/отключить breakpoint" }
	)
	vim.keymap.set("n", "<F1>", ":DapStepInto <CR>", { desc = "Шаг с заходом" })
	vim.keymap.set("n", "<F2>", ":DapStepOver <CR>", { desc = "Шаг с обходом" })
	vim.keymap.set("n", "<F3>", ":DapStepOut <CR>", { desc = "Шаг с выходом" })
end

return M
