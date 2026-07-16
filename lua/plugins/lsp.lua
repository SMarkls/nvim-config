-- Nvim 0.12: глубокая миграция LSP на нативный стек + nvim-cmp как
-- пользовательский completion поверх. Используется новый API:
-- vim.lsp.config / vim.lsp.enable / vim.lsp.completion / vim.lsp.inlay_hint.
-- Документация: :help lsp, :help lsp-quickstart

return {
	"neovim/nvim-lspconfig",
	config = function()
		local langs = require("plugins.languages.langs")

		-- Capabilities: nvim-cmp требует стандартный набор, добавляем
		-- positionEncodings и поддержку фич 0.12 (pull diagnostics,
		-- multiline semantic tokens, inline completion).
		local base_capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			require("cmp_nvim_lsp").default_capabilities()
		)
		base_capabilities.general.positionEncodings = { "utf-16" }

		-- Pull diagnostics (textDocument/diagnostic) — новое в 0.12
		base_capabilities.textDocument = base_capabilities.textDocument or {}
		base_capabilities.textDocument.diagnostic = vim.tbl_deep_extend(
			"force",
			base_capabilities.textDocument.diagnostic or {},
			{
				dynamicRegistration = true,
				relatedDocumentSupport = true,
			}
		)
		-- Multiline semantic tokens
		base_capabilities.textDocument.semanticTokens = base_capabilities.textDocument.semanticTokens or {}
		base_capabilities.textDocument.semanticTokens.multilineTokenSupport = true
		-- Inline completion (если сервер поддерживает)
		base_capabilities.textDocument.inlineCompletion = { dynamicRegistration = true }
		-- Annotated text edits
		base_capabilities.textDocument.editing = base_capabilities.textDocument.editing or {}
		-- Workspace diagnostics + codeLens refresh
		base_capabilities.workspace = base_capabilities.workspace or {}
		base_capabilities.workspace.diagnostics = { refreshSupport = true }
		base_capabilities.workspace.codeLens = { refreshSupport = true }

		-- Inlay hints полностью отключены. Чистим capability, чтобы сервер
		-- не отправлял данные и UI нечего было показывать.
		base_capabilities.textDocument.inlayHint = nil
		if base_capabilities.workspace then
			base_capabilities.workspace.inlayHint = nil
		end

		-- vim.ui.select переопределён в init.lua на Snacks.picker.ui_select,
		-- поэтому code action / code lens и т.п. показываются во
		-- floating-окне, а не в cmdline. Дополнительной обработки не
		-- требуется.

		-- Конфигурация диагностики (virtual_text выключен — используется
		-- statusline и Snacks)
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

		-- Глобальные дефолты LspAttach (будут применены к каждому
		-- подключённому клиенту). Дублируют ручной on_attach, но дают
		-- унифицированную точку входа под новые фичи 0.12.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach-0.12", { clear = true }),
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if not client then
					return
				end
				local bufnr = ev.buf

				-- K → hover (по умолчанию уже K, но перебиваем, чтобы был border)
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover({ border = "rounded" })
				end, { buffer = bufnr, desc = "Отобразить сигнатуру" })
				vim.keymap.set(
					"n",
					"<Leader>D",
					vim.lsp.buf.type_definition,
					{ buffer = bufnr, desc = "Объявление типа" }
				)
				vim.keymap.set(
					"n",
					"<Leader>lr",
					vim.lsp.buf.rename,
					{ buffer = bufnr, desc = "Переименовать" }
				)
				-- gra (code action) и <leader>la: дефолтный handler
				-- vim.lsp.buf.code_action использует vim.ui.select,
				-- который переопределён в init.lua на Snacks.picker — список
				-- показывается во floating-окне.
				vim.keymap.set("n", "<Leader>lf", function()
					vim.lsp.buf.format({ async = true })
				end, { buffer = bufnr, desc = "Форматировать файл" })

				-- Включить omnifunc — ручное LSP-дополнение через
				-- |i_CTRL-X_CTRL-O|. Автотриггер через vim.lsp.completion
				-- выключен намеренно: конфликтует с nvim-cmp (всплывает
				-- на каждое нажатие, в т.ч. на "."), который настроен
				-- на ручной trigger по <C-Space>.
				vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Auto-format on save (если сервер не поддерживает
				-- textDocument/willSaveWaitUntil)
				if not client:supports_method("textDocument/willSaveWaitUntil")
					and client:supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("lsp-format-" .. client.id, { clear = true }),
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
						end,
					})
				end

				-- Inlay hints отключены глобально (см. очистку capabilities
				-- выше и init.lua). Здесь намеренно ничего не включаем.

				-- Для серверов, не сигнализирующих activeParameterSupport
				-- корректно (например, lua_ls) — оставляем поведение
				-- pre-0.12: значения вне диапазона = nil.
				if client.server_capabilities.signatureHelpProvider
					and not client.server_capabilities.signatureHelpProvider.activeParameterSupport then
					client.server_capabilities.signatureHelpProvider.activeParameterSupport = false
				end
			end,
		})

		-- Кодовое зеркало on_attach для серверов, у которых он свой
		-- (например ruff отключает hover).
		local function default_on_attach(client, bufnr)
			if client.name == "ruff" and client.server_capabilities then
				client.server_capabilities.hoverProvider = false
			end
		end

		-- Применяем конфигурацию и включаем каждый сервер
		local server_definitions = langs.servers()

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
				opts.capabilities = vim.tbl_deep_extend(
					"force",
					{},
					base_capabilities,
					opts.capabilities or {}
				)

				-- Дополнительный on_attach из langs/<lang>.lua
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
