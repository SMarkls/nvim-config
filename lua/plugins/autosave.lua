return {
	"okuuva/auto-save.nvim",
	version = "*", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
	cmd = "ASToggle", -- optional for lazy loading on command
	event = { "InsertLeave", "TextChanged" },
	opts = {
		enabled = true,
		trigger_events = {
			immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" }, -- vim events that trigger an immediate save
			defer_save = { "InsertLeave", "TextChanged" }, -- vim events that trigger a deferred save (saves after `debounce_delay`)
			cancel_deferred_save = { "InsertEnter" }, -- vim events that cancel a pending deferred save
		},
		debounce_delay = 1000,
	},
}
