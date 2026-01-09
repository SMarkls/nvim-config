return {
	"neovim/nvim-lspconfig",
	config = function()
		local langs = require("plugins.languages.langs")
		local base_capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)
		base_capabilities.general.positionEncodings = { "utf-16" }

		vim.diagnostic.config({
			virtual_text = false,
			update_in_insert = false,
			severity_sort = true,
			underline = true,
			float = {
				border = "rounded",
				source = "if_many",
			},
		})

		local function default_on_attach(_, bufnr)
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
			local function map(lhs, rhs, desc)
				vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
			end
			map("K", function()
				vim.lsp.buf.hover({ border = "rounded" })
			end, "Отобразить сигнатуру")
			map("<Leader>D", vim.lsp.buf.type_definition, "Объявление типа")
			map("<Leader>lr", vim.lsp.buf.rename, "Переименовать")
			map("<Leader>la", vim.lsp.buf.code_action, "Код экшн")
			vim.keymap.set("n", "<Leader>lf", function()
				vim.lsp.buf.format({ async = true })
			end, { buffer = bufnr, desc = "Форматировать файл" })
		end

		local server_definitions = {}
		for _, lang in pairs(langs) do
			if lang.servers then
				for name, definition in pairs(lang.servers) do
					server_definitions[name] = definition
				end
			end
		end

		for name, definition in pairs(server_definitions) do
			local opts
			if type(definition) == "function" then
				opts = definition(base_capabilities) or {}
			elseif type(definition) == "table" then
				opts = vim.tbl_deep_extend("force", {}, definition)
			else
				opts = {}
			end

			if opts.enabled ~= false then
				opts.capabilities = vim.tbl_deep_extend("force", {}, base_capabilities, opts.capabilities or {})
				local extra_attach = opts.on_attach
				opts.on_attach = function(client, bufnr)
					default_on_attach(client, bufnr)
					if type(extra_attach) == "function" then
						extra_attach(client, bufnr)
					end
				end
				vim.lsp.config(name, opts)
				vim.lsp.enable(name)
			end
		end
	end,
}
