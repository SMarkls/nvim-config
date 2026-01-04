local M = {}

M.lsp_name = "ts_ls"

function M.lsp(capabilities)
	vim.lsp.config[M.lsp_name] = {
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		cmd = { "typescript-language-server", "--stdio" },
		capabilities = capabilities,
		settings = {
			typescript = {
				inlayHints = {
					parameterNames = { enabled = "literals" },
					parameterTypes = { enabled = true },
					variableTypes = { enabled = true },
					propertyDeclarationTypes = { enabled = true },
					functionLikeReturnTypes = { enabled = true },
					enumMemberValues = { enabled = true },
				},
			},
			javascript = {
				inlayHints = {
					parameterNames = { enabled = "literals" },
					parameterTypes = { enabled = true },
					variableTypes = { enabled = true },
					propertyDeclarationTypes = { enabled = true },
					functionLikeReturnTypes = { enabled = true },
					enumMemberValues = { enabled = true },
				},
			},
		},
	}
end

function M.formatter()
	return {
		javascript = { "prettier", "biome" },
		typescript = { "prettier", "biome" },
		javascriptreact = { "prettier", "biome" },
		typescriptreact = { "prettier", "biome" },
	}
end

function M.linter()
	return {
		typescript = { "eslint" },
		typescriptreact = { "eslint" },
		javascript = { "eslint" },
		javascriptreact = { "eslint" },
	}
end

return M
