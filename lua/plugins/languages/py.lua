
local M = {}

M.lsp_name="ruff"

function M.lsp(capabilities, lspconfig)
  lspconfig.ruff.setup({
    init_options = {
      settings = {
        configurationPreference = "filesystemFirst",
        lineLength = 80,
      }
    }
  })
end

function M.formatter()
  return {
    python = {
      "ruff_fix",
      "ruff_format",
      "ruff_organize_imports",
    }
  }
end

function M.linter()
 return {
    python = { "ruff" }
 }
end

function M.keybindings()
  vim.keymap.set("n", "<leader>b", ":DapToggleBreakpoint <CR>", { desc = "Включить/отключить breakpoint" })
  vim.keymap.set("n", "<F1>", ":DapStepInto <CR>", { desc = "Шаг с заходом" })
  vim.keymap.set("n", "<F2>", ":DapStepOver <CR>", { desc = "Шаг с обходом" })
  vim.keymap.set("n", "<F3>", ":DapStepOut <CR>", { desc = "Шаг с выходом" })
end

return M;
