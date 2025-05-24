
local M = {}
function M.setup(capabilities, lspconfig)
  lspconfig.ts_ls.setup({
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
  })
end

return M;
