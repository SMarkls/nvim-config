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
    -- Code action: <leader>la и gra работают через дефолтные маппинги
    -- vim.lsp.buf.code_action, который использует vim.ui.select.
    -- vim.ui.select переопределён в init.lua на Snacks.picker.ui_select,
    -- поэтому список действий показывается во floating-окне, а не в cmdline.
    { "<leader>la", function() vim.lsp.buf.code_action() end, desc = "Код экшн" },
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
  -- lazy.nvim init = function() ... end ставил autocmd User VeryLazy,
  -- чтобы toggle-маппинги регистрировались отложенно. В нашей
  -- реализации vim.pack плагины загружаются синхронно, и VeryLazy
  -- нужно эмулировать вручную. Чтобы не ловить ошибки "global Snacks
  -- is nil" (callback может выполниться раньше, чем _G.Snacks будет
  -- установлен), вызываем содержимое прямо здесь.
  init = function()
    _G.dd = function(...)
      require("snacks").debug.inspect(...)
    end
    _G.bt = function()
      require("snacks").debug.backtrace()
    end
    vim.print = _G.dd -- Override print to use snacks for `:=` command

    local snacks = require("snacks")
    -- Create some toggle mappings
    snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
    snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
    snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
    snacks.toggle.diagnostics():map("<leader>ud")
    snacks.toggle.line_number():map("<leader>ul")
    snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
    snacks.toggle.treesitter():map("<leader>uT")
    snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
    -- inlay hints отключены глобально (lsp.lua чистит capability)
    snacks.toggle.indent():map("<leader>ug")
    snacks.toggle.dim():map("<leader>uD")
  end,
}
