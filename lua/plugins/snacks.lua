return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 1000,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      }
    }
  },
  keys = {
    -- Top Pickers & Explorer
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Поиск файлов" },
    { "<leader>fw", function() Snacks.picker.grep() end, desc = "Поиск слов в проекте" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "История команд" },
    { "<leader>n", function() Snacks.picker.notifications() end, desc = "История нотификаций" },
    { "<leader>e", function() Snacks.explorer() end, desc = "Файловая система" },
    -- find
    --{ "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Поиск по проектам" },
    -- git
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Ветки" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Лог" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
    -- Grep
    { "<leader>ff", function() Snacks.picker.lines() end, desc = "Поиск по открытому файлу" },
    { "<leader>fs", function() Snacks.picker.grep_word() end, desc = "Поиск слова или выделенного", mode = { "n", "x" } },
    -- search
    -- { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "Команды" },
    { "<leader>ad", function() Snacks.picker.diagnostics() end, desc = "Ошибки" },
    { "<leader>aD", function() Snacks.picker.diagnostics_buffer() end, desc = "Ошибки в файле" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Поиск подсказок" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Поиск и вставка иконок" },
--    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Поиск сочетаний клавиш" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "Почитать Man" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Цветовые схемы" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Дефиниция" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Объявление" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "Использования" },
    { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Имплементация" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Объявление типа" },
    --{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    --{ "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- Other
    --{ "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    --{ "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Переименовать файл" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Спрятать все нотификации" },
    { "<c-/>",      function() Snacks.terminal() end, desc = "Терминал" },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Следующее вхождение", mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Предыдущее вхождение", mode = { "n", "t" } },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
