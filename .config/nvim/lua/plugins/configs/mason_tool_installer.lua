return {
	ensure_installed = { "prettierd", "stylua", "beautysh", "pretty-php" },
	start_delay = 3000,
	integrations = {
		["mason-lspconfig"] = true,
	},
}
