local dap = require("dap")

vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Включить/отключить breakpoint" })
vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Шаг с заходом" })
vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Шаг с обходом" })
vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Шаг с выходом" })
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Продолжить выполнение / запустить отладку" })
vim.keymap.set("n", "<F6>", dap.restart, { desc = "Перезапустить отладку" })
vim.keymap.set("n", "<F8>", dap.terminate, { desc = "Остановить отладчик" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Открыть REPL отладчика" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Запустить последнюю конфигурацию" })

local function find_rust_binary()
	local cwd = vim.fn.getcwd()
	local cargo_toml = cwd .. "/Cargo.toml"
	local binary_name = nil

	if vim.fn.filereadable(cargo_toml) == 1 then
		local lines = vim.fn.readfile(cargo_toml)
		for _, line in ipairs(lines) do
			local name = line:match('^name%s*=%s*"([^"]+)"')
			if name then
				binary_name = name
				break
			end
		end
	end

	if not binary_name then
		binary_name = vim.fn.fnamemodify(cwd, ":t")
	end

	local debug_path = cwd .. "/target/debug/" .. binary_name
	if vim.fn.filereadable(debug_path) == 1 then
		return debug_path
	end

	return debug_path
end

local function rust_binary_with_args()
	local bin = find_rust_binary()
	local args_str = vim.fn.input("Аргументы программы: ", "", "file")
	local args = {}
	for arg in args_str:gmatch("%S+") do
		table.insert(args, arg)
	end
	return bin, args
end

dap.configurations.rust = {
	{
		name = "Debug binary (auto-detect)",
		type = "codelldb",
		request = "launch",
		program = find_rust_binary,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
	{
		name = "Debug binary with args",
		type = "codelldb",
		request = "launch",
		program = function()
			local bin, _ = rust_binary_with_args()
			return bin
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = function()
			local _, args = rust_binary_with_args()
			return args
		end,
	},
	{
		name = "Debug tests",
		type = "codelldb",
		request = "launch",
		program = function()
			local test_binary = vim.fn.input("Путь до тестового бинарника: ", cwd .. "/target/debug/deps/", "file")
			return test_binary
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
	{
		name = "Attach to process",
		type = "codelldb",
		request = "attach",
		program = function()
			local name = vim.fn.input("Имя процесса для attach: ", "", "file")
			return name
		end,
		stopOnEntry = false,
		waitFor = true,
	},
}
