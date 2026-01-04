local M = {}

local function ensure_dap_keymaps()
	if M._dap_keys_set then
		return
	end
	vim.keymap.set(
		"n",
		"<leader>b",
		":DlvToggleBreakpoint <CR>",
		{ desc = "Включить/отключить breakpoint" }
	)
	M._dap_keys_set = true
end

M.servers = {
	gopls = {
		settings = {
			gopls = {
				analyses = {
					unusedparams = true,
				},
				staticcheck = true,
				gofumpt = true,
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
		on_attach = function()
			ensure_dap_keymaps()
		end,
	},
}

M.formatters = {
	go = { "goimports", "gofmt" },
}

return M
