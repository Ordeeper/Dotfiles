local M = {}

M.blankline = {
    exclude = {
        buftypes = { "terminal" },
        filetypes = {
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

    },
}

M.mason_lspconfig = {
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
    ensure_installed = {
        "lua_ls", "rust_analyzer", "pylsp", "bashls", "tsserver", "html", "cssls",
        "tailwindcss", "clangd",
    },
}

return M
