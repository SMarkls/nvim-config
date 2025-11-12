local M = {}

M.lsp_name="nil"

function M.lsp(capabilities)
  vim.lsp.config[M.lsp_name]= {
    capabilities = capabilities,
    settings = {
      ['nil'] = {
         formatting = {
            command = { "nixfmt" },
         },
      },
   }
  }
end

function M.formatter()
  return {
    go = { "nixfmt" },
  }
end

return M;
