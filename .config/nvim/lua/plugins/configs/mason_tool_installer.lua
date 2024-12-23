return {
	ensure_installed = { "prettierd", "stylua" },
	start_delay = 3000,
	integrations = {
		["mason-lspconfig"] = true,
	},
}
