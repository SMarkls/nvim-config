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
	["rust-analyzer"] = {
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
		on_attach = function(_, bufnr)
			ensure_dap_keymaps()
			vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
		end,
	},
}

return M
