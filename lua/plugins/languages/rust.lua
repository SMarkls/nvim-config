local M = {}

M.lsp_name = "rust-analyzer"

function M.lsp(capabilities)
	vim.lsp.config[M.lsp_name] = {
		capabilities = capabilities,
		settings = {
			["rust-analyzer"] = {
				imports = {
					granularity = {
						group = "module",
					},
					prefix = "self",
				},
				cargo = {
					buildScripts = {
						enable = true,
					},
				},
				procMacro = {
					enable = true,
				},
			},
		},
		root_markers = { { "Config.toml" }, ".git" },
	}
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client == nil then
				return
			end
			if client.name == "rust-analyzer" then
				vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
			end
		end,
	})
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
