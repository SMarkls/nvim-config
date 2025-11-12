local M = {}

M.lsp_name = "lua_ls"

function M.lsp(capabilities)
	vim.lsp.config[M.lsp_name] = {
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
				hint = {
					enable = true,
				},
			},
		},
	}
end

function M.formatter()
	return {
		lua = { "stylua" },
	}
end

function M.linter()
	return {
		lua = { "selene" },
	}
end

return M
