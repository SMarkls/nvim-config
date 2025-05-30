
local M = {}

M.lsp_name="ts_ls"

function M.lsp(capabilities, lspconfig)
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


function M.formatter()
  return {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
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
return M;
