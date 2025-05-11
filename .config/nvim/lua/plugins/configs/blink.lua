local mapping_cmp = require("core.mappings").plugins.blink

return {
	keymap = mapping_cmp(),
	sources = {
		default = { "lsp", "path", "snippets", "buffer", "codeium" },
		providers = {
			codeium = { name = "Codeium", module = "codeium.blink", async = true },
		},
	},
	completion = {
		ghost_text = {
			enabled = true,
		},
		list = {
			selection = {
				preselect = true,
				auto_insert = false,
			},
		},
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 0,
			window = { border = "rounded" },
		},
		menu = { border = "rounded" },
	},
	cmdline = {
		keymap = { preset = "inherit" },
		completion = {
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
			},
			menu = { auto_show = true },
		},
	},
	signature = {
		enabled = true,
		window = {
			border = "rounded",
		},
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
}
