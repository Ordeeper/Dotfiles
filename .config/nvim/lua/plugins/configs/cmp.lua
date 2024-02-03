local cmp = require "cmp"
local mapping_cmp = require("core.mappings").plugins.cmp

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    experimental = {
        ghost_text = true
    },
    mapping = cmp.mapping.preset.insert(mapping_cmp()),
    sources = cmp.config.sources(
        {
            { name = "nvim_lsp" },
            { name = "luasnip" }, -- For luasnip users.
        },
        {
            { name = "buffer" },
            { name = "path" },
            { name = "calc" },
        }
    )
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources(
        {
            { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        },
        {
            { name = "buffer" },
        }
    )
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" }
    },
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources(
        {
            { name = "path" }
        },
        {
            { name = "cmdline" }
        })
})

local servers = require("plugins.configs.mason_lspconfig").ensure_installed
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Set up lspconfig.
for _, server in ipairs(servers) do
    require("lspconfig")[server].setup {
        capabilities = capabilities,
    }
end
