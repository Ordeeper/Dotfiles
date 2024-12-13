return {
	options = {
		icons_enabled = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode", "vim.fn.fnamemodify(vim.fn.getcwd(), ':t')" },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = { "diagnostics", "diff", { "filetype", colored = false } },
		lualine_z = { { "branch", icons_enabled = false }, "progress" }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = { "lazy" }
}
