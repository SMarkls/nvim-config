return {
	"mfussenegger/nvim-dap-python",
	config = function()
    --require"dap-python".setup("~/.virtualenvs/debugpy/bin/python") -- выбрать, если не хотите глобально ставить debugpy
    require"dap-python".setup("python3")
	end,
}
