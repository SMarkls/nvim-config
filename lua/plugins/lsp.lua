return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")
		local configs = require("lspconfig/configs")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)
		-- Здесь важно перечислить все LSP, которые мы используем
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
			end,
		})
	end,
}
