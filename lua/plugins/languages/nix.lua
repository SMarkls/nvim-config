local M = {}

M.lsp_name="nil"

function M.lsp(capabilities, lspconfig)
  lspconfig.nil_ls.setup({
    capabilities = capabilities,
    settings = {
      ['nil'] = {
         formatting = {
            command = { "nixfmt" },
         },
      },
   }
  })
end

function M.formatter()
  return {
    go = { "nixfmt" },
  }
end

return M;
