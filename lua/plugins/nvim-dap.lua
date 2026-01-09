local function default_rust_binary()
	local cwd = vim.fn.getcwd()
	local crate = vim.fn.fnamemodify(cwd, ":t")
	local exe = cwd .. "/target/debug/" .. crate
	return exe
end

return {
	"mfussenegger/nvim-dap",
	config = function()
		local dap = require("dap")
		dap.configurations.rust = {
			{
				name = "Debug (codelldb)",
				type = "codelldb",
				request = "launch",
				program = default_rust_binary,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
	end,
}
--					local default_bin = vim.fn.getcwd() .. "/target/debug/"
--					return vim.fn.input("Путь до бинарника: ", default_bin, "file")
--				end,
