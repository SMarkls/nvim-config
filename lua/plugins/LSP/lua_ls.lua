local M = {}

function M.setup(capabilities, lspconfig)
  lspconfig.lua_ls.setup({
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
  })
end

return M;
