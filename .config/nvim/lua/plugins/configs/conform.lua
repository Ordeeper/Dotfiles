return {
	formatters_by_ft = {
		lua = { "stylua" },
		["_"] = { "prettierd" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = { timeout_ms = 1000 },
}
