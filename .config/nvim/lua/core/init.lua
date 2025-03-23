require("core.mappings")

------ Local Variables ------
local opt = vim.opt

------ Miscellaneous ------
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 600
opt.undofile = true
opt.scrolloff = 7

------ Indenting ------
opt.foldcolumn = "0"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.expandtab = false
opt.smarttab = true
opt.softtabstop = 4
opt.tabstop = 4
opt.shiftwidth = 4
opt.list = true
opt.listchars = {
	space = "⋅",
	tab = "│⋅",
}

------ Numbers ------
opt.number = true
opt.numberwidth = 3
opt.ruler = true

------ Style ------
-- opt.termguicolors = true
opt.fillchars = { eob = " " }
opt.cursorline = true
opt.laststatus = 3 -- Global Statusline
opt.showmode = false

-- Interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- Go to previous/next line with h,l,left arrow and right arrow
-- When cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")
