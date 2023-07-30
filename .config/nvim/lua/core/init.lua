require "core.mappings"

------ Local Variables ------
local opt = vim.opt

-------------------------------------- Options ------------------------------------------
opt.laststatus = 3 -- Global Statusline
opt.showmode = false

opt.clipboard = "unnamedplus"
-- opt.cursorline = true

------ Indenting ------
opt.expandtab = true
opt.smarttab = true
opt.softtabstop = 4
opt.tabstop = 4
opt.shiftwidth = 4
vim.opt.list = true
vim.opt.listchars:append "space:⋅"

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

------ Numbers ------
opt.number = true
opt.numberwidth = 3
opt.ruler = true

-- opt.signcolumn = "no"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 600
opt.undofile = true

-- Interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- Go to previous/next line with h,l,left arrow and right arrow
-- When cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"
