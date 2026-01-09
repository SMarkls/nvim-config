local state_file = vim.fs.joinpath(vim.fn.stdpath("state"), "last-colorscheme.txt")
local augroup = vim.api.nvim_create_augroup("PersistColorscheme", { clear = true })

local function trim(name)
	return (name or ""):gsub("^%s+", ""):gsub("%s+$", "")
end

local function save_colorscheme(name)
	name = trim(name)
	if name == "" then
		return
	end
	vim.fn.mkdir(vim.fn.stdpath("state"), "p")
	pcall(vim.fn.writefile, { name }, state_file)
end

local function read_colorscheme()
	local ok, data = pcall(vim.fn.readfile, state_file)
	if not ok or not data or not data[1] then
		return nil
	end
	local name = trim(data[1])
	if name == "" then
		return nil
	end
	return name
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = augroup,
	callback = function(args)
		local name = args.match ~= "" and args.match or vim.g.colors_name
		save_colorscheme(name)
	end,
})

vim.api.nvim_create_autocmd("User", {
	group = augroup,
	pattern = "VeryLazy",
	once = true,
	callback = function()
		local name = read_colorscheme()
		if not name or name == vim.g.colors_name then
			return
		end
		local ok, err = pcall(vim.cmd.colorscheme, name)
		if not ok then
			vim.schedule(function()
				vim.notify(
					string.format(
						"Не удалось загрузить цветовую схему '%s': %s",
						name,
						err
					),
					vim.log.levels.WARN
				)
			end)
		end
	end,
})

return {}
