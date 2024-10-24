local api = vim.api
local float_border_hl = api.nvim_get_hl_by_name("FloatBorder", true)
local mapping_toggleterm = require("core.mappings").plugins.toggleterm

return {
	mapping_toggleterm(),
	direction = "float",
	start_in_insert = true,
	float_opts = {
		border = "curved"
	},
	highlights = {
		FloatBorder = {
			guifg = string.format("#%06x", float_border_hl.foreground or 0),
			guibg = string.format("#%06x", float_border_hl.background or 0),
		},
	},
}
