return {
	ensure_installed = { "prettierd", "stylua", "beautysh" },
	start_delay = 3000,
	integrations = {
		["mason-lspconfig"] = true,
	},
}
