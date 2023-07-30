local M = {}

M.blankline = {
    indentLine_enabled = 1,
    filetype_exclude = {
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "nvdash",
        "nvcheatsheet",
        "",
    },
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    show_current_context = true,
    show_current_context_start = true,
    space_char_blankline = " ",
}

M.mason_lspconfig = {
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
    ensure_installed = {
        "lua_ls", "rust_analyzer", "pylsp", "bashls", "tsserver", "html", "cssls",
        "tailwindcss", "clangd",
    },
}

return M
