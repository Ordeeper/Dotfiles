require("core.mappings").plugins.neo_tree()

return {
	window = {
		mappings = {
			["t"] = "open",
			["<CR>"] = "open",
		},
	},
	filesystem = {
		follow_current_file = {
			enabled = true,
		},
	},
}
