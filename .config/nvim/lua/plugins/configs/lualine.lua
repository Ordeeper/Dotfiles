local custom_theme = require("lualine.themes.auto")

custom_theme.normal.b.bg = "None"
custom_theme.insert.b.bg = "None"
custom_theme.visual.b.bg = "None"
custom_theme.replace.b.bg = "None"
custom_theme.command.b.bg = "None"
custom_theme.inactive.b.bg = "None"

custom_theme.normal.c.bg = "None"
custom_theme.insert.c.bg = "None"
custom_theme.visual.c.bg = "None"
custom_theme.replace.c.bg = "None"
custom_theme.command.c.bg = "None"
custom_theme.inactive.c.bg = "None"

return {
    options = {
        icons_enabled = true,
        theme = custom_theme,
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
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { { "filetype", colored = false }, "progress" },
        lualine_z = { "location" }
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
