
local M = {}

M.lsp_name="gopls"

function M.lsp(capabilities, lspconfig)
  lspconfig.gopls.setup({
    capabilities = capabilities,
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
  })
end

function M.keybindings()
  vim.keymap.set("n", "<leader>b", ":DlvToggleBreakpoint <CR>", { desc = "Включить/отключить breakpoint" })
end

function M.formatter()
  return {
    go = { "goimports", "gofmt" },
  }
end

return M;
