local opt = vim.opt
local api = vim.api

local success, pywal_core = pcall(require, "pywal.core")

if success then
	local colors = pywal_core.get_colors()
	--api.nvim_set_hl(0, "MatchParen", { bg = "#4A5057", fg = colors.color5 })
	--api.nvim_set_hl(0, "CursorLine", { bg = "#0E1117" })
	api.nvim_set_hl(0, "CursorLineNr", { fg = colors.color5 })
	api.nvim_set_hl(0, "NormalFloat", {
		bg = colors.background,
	})
	api.nvim_set_hl(0, "FloatBorder", {
		fg = colors.color1,
		bg = colors.background,
	})

	api.nvim_set_hl(0, "StatusLine", { bold = true })
end
