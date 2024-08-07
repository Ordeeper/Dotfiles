local M = {}

-- Setup Mason
require("mason").setup({
    PATH = "skip",

    ui = {
        icons = {
            package_pending = " ",
            package_installed = "󰄳 ",
            package_uninstalled = " 󰚌",
        },

        keymaps = {
            toggle_server_expand = "<CR>",
            install_server = "i",
            update_server = "u",
            check_server_version = "c",
            update_all_servers = "U",
            check_outdated_servers = "C",
            uninstall_server = "X",
            cancel_installation = "<C-c>",
        },
    },
    max_concurrent_installers = 10,
})

-- Setup Mason-Lspconfig
M.ensure_installed = {
    "lua_ls", "rust_analyzer", "pylsp", "bashls", "tsserver", "html", "cssls",
    "tailwindcss", "clangd", "intelephense", "volar",
}
require("mason-lspconfig").setup {
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
    ensure_installed = M.ensure_installed,
}

-- Setup Lsp
local lspconfig = require "lspconfig"
lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
lspconfig.rust_analyzer.setup {
    settings = {
        ["rust-analyzer"] = {},
    },
}
lspconfig.pylsp.setup {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { "W391" },
                    maxLineLength = 100,
                }
            }
        }
    }
}
lspconfig.bashls.setup {}
lspconfig.tsserver.setup {}
lspconfig.html.setup {}
lspconfig.cssls.setup {}
lspconfig.tailwindcss.setup {}
lspconfig.clangd.setup {}
lspconfig.intelephense.setup {}
lspconfig.volar.setup {}
lspconfig.astro.setup {}

return M
