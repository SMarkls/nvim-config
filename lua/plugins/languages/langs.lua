local langs = {
	go = require("plugins.languages.go"),
	lua = require("plugins.languages.lua"),
	ts = require("plugins.languages.ts"),
	py = require("plugins.languages.py"),
	nix = require("plugins.languages.nix"),
	rust = require("plugins.languages.rust"),
	c = require("plugins.languages.c"),
}

local cached = nil

local function build_cache()
	local servers, formatters, linters = {}, {}, {}
	for _, lang in pairs(langs) do
		if lang.servers then
			for name, definition in pairs(lang.servers) do
				servers[name] = definition
			end
		end
		local fmt = lang.formatters or (type(lang.formatter) == "function" and lang.formatter())
		if type(fmt) == "table" then
			for ft, tools in pairs(fmt) do
				formatters[ft] = tools
			end
		end
		local lint = lang.linters or (type(lang.linter) == "function" and lang.linter())
		if type(lint) == "table" then
			for ft, tools in pairs(lint) do
				linters[ft] = tools
			end
		end
	end
	cached = { servers = servers, formatters = formatters, linters = linters }
	return cached
end

local function get_cache()
	if not cached then
		cached = build_cache()
	end
	return cached
end

local M = setmetatable({}, {
	__index = function(_, key)
		return langs[key]
	end,
	__pairs = function()
		return pairs(langs)
	end,
	__len = function()
		local n = 0
		for _ in pairs(langs) do
			n = n + 1
		end
		return n
	end,
})

function M.servers()
	return get_cache().servers
end

function M.formatters()
	return get_cache().formatters
end

function M.linters()
	return get_cache().linters
end

function M.reset_cache()
	cached = nil
end

return M
