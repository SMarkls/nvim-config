return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)

		-- Здесь важно перечислить все LSP, которые мы используем
    local servers = {
      "ts_ls",
      "gopls",
      "lua_ls"
    }

    for _, server in ipairs(servers) do
      local module = require("plugins.LSP." .. server)
      module.setup(capabilities, lspconfig)
    end

		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			virtual_text = false,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Объявление" })
				vim.keymap.set(
					"n",
					"K",
					vim.lsp.buf.hover,
					{ buffer = ev.buf, desc = "Отобразить сигнатуру" }
				)
				vim.keymap.set(
					"n",
					"gi",
					vim.lsp.buf.implementation,
					{ buffer = ev.buf, desc = "Имплементация" }
				)
				vim.keymap.set(
					"n",
					"<C-k>",
					vim.lsp.buf.signature_help,
					{ buffer = ev.buf, desc = "Подсказка по сигнатуре" }
				)
				vim.keymap.set(
					"n",
					"<Leader>D",
					vim.lsp.buf.type_definition,
					{ buffer = ev.buf, desc = "Объявление типа" }
				)
				vim.keymap.set(
					"n",
					"<Leader>lr",
					vim.lsp.buf.rename,
					{ buffer = ev.buf, desc = "Переименовать" }
				)
				vim.keymap.set(
					"n",
					"<Leader>la",
					vim.lsp.buf.code_action,
					{ buffer = ev.buf, desc = "Код экшн" }
				)
				vim.keymap.set("n", "<Leader>lf", function()
					vim.lsp.buf.format({ async = true })
				end, { buffer = ev.buf, desc = "Форматировать файл" })

        local client_id = ev.client_id or ev.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        for _, v in ipairs(servers) do
          if v == client.name then
            local mod = require("plugins.LSP." .. v)
            if type(mod.keybindings) == "function" then
              mod.keybindings()
            end
          end
        end
			end,
		})
	end,
}
