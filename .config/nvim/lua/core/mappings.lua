--------- n, v, i, t = Mode Names ---------

--------- Local Variables ---------
local M = {}
local g = vim.g

function M.setup()
    M.global()
    M.insert()
    M.normal()
    M.visual()
    M.terminal()
    M.plugins = M.plugins() -- Get the returned object
end

function M.global()
    g.mapleader = " "
end

function M.insert()
    --------- Go to Beginning and End ---------
    vim.keymap.set("i", "<C-b>", "<ESC>^i") -- Beginning of Line
    vim.keymap.set("i", "<C-e>", "<END>") -- End of Line

    --------- Navigate Within Insert Mode ---------
    vim.keymap.set("i", "<C-h>", "<Left>") -- Move Left
    vim.keymap.set("i", "<C-l>", "<Right>") -- Move Right
    vim.keymap.set("i", "<C-k>", "<Up>") -- Move Up
    vim.keymap.set("i", "<C-j>", "<Down>") -- Move Down
end

function M.normal()
    vim.keymap.set("n", "<ESC>", ":noh <CR>", {silent = true}) -- Clear Highlights

    --------- Switch Between Windows ---------
    vim.keymap.set("n", "<C-h>", "<C-w>h") -- Window Left
    vim.keymap.set("n", "<C-l>", "<C-w>l") -- Window Right
    vim.keymap.set("n", "<C-k>", "<C-w>k") -- Window Up
    vim.keymap.set("n", "<C-j>", "<C-w>j") -- Window Down

    vim.keymap.set("n", "<C-s>", "<cmd> w <CR>") -- Save File
    vim.keymap.set("n", "<C-x>", "<cmd> x <CR>") -- Save and Exit
    vim.keymap.set("n", "<C-q>", "<cmd> q! <CR>") -- Don't Save and Exit
    vim.keymap.set("n", "<C-c>", "<cmd> %y+ <CR>") -- Copy Whole File
    vim.keymap.set("n", "<leader>n", "<cmd> set nu! <CR>") -- Toggle Line Number
    vim.keymap.set("n", "<leader>rn", "<cmd> set rnu! <CR>") -- Toggle Relative Number
    vim.keymap.set("n", "<leader>ch", "<cmd> enew <CR>") -- New Buffer
end

function M.visual()
end

function M.terminal()
    vim.keymap.set("t", "ESC", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true)) -- Escape Terminal Mode
end

function M.plugins()
    local plugins = {}

    --------- NvimTree ---------
    function plugins.nvimtree()
        vim.keymap.set("n", "<leader>h", ":NvimTreeToggle <CR>", {silent = true}) -- Toggle NvimTree
    end

    --------- Cmp ---------
    function plugins.cmp()
        local cmp = require("cmp")
        cmp.setup ({
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            })
        })
    end

    --------- Lspconfig ---------
    function plugins.lspconfig()
        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
        vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                -- Buffer local mappings.
                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set("n", "<space>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
                vim.keymap.set("n", "<space>rx", vim.lsp.buf.rename, opts)
                vim.keymap.set({"n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<space>f", function()
                    vim.lsp.buf.format { async = true }
                end, opts)
            end
        })
    end
    return plugins
end

M.setup()
return M
