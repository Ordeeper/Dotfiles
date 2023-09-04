require "core.mappings"

------ Local Variables ------
local opt = vim.opt
local api = vim.api

------ Load Custom Highlights ------
api.nvim_create_autocmd("VimEnter", {
    command = "colorscheme highlight"
})

------ Miscellaneous ------
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 600
opt.undofile = true

------ Indenting ------
opt.expandtab = true
opt.smarttab = true
opt.softtabstop = 4
opt.tabstop = 4
opt.shiftwidth = 4
opt.list = true
opt.listchars = { space = "⋅" }

------ Numbers ------
opt.number = true
opt.numberwidth = 3
opt.ruler = true

------ Style ------
opt.termguicolors = true
opt.fillchars = { eob = " " }
opt.cursorline = true
opt.laststatus = 3 -- Global Statusline
opt.showmode = false

-- Interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- Go to previous/next line with h,l,left arrow and right arrow
-- When cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"
