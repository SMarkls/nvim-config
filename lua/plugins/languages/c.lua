local M = {}

M.lsp_name = "clangd"

function M.lsp(capabilities)
	vim.lsp.config[M.lsp_name] = {
		capabilities = capabilities,
		root_markers = {
			"compile_commands.json",
			"compile_flags.txt",
			"configure.ac", -- AutoTools
			"Makefile",
			"configure.ac",
			"configure.in",
			"config.h.in",
			"meson.build",
			"meson_options.txt",
			"build.ninja",
			".git",
		},
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--header-insertion=iwyu",
			"--completion-style=detailed",
			"--function-arg-placeholders",
			"--fallback-style=llvm",
		},
		init_options = {
			usePlaceholders = true,
			completeUnimported = true,
			clangdFileStatus = true,
		},
	}
end

return M
