--------- n, v, i, t = Mode Names ---------

--------- Local Variables ---------
local M = {}
local g = vim.g
local keymap = vim.keymap.set

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
    keymap("i", "<C-b>", "<ESC>^i") -- Beginning of Line
    keymap("i", "<C-e>", "<END>")   -- End of Line

    --------- Navigate Within Insert Mode ---------
    keymap("i", "<C-h>", "<Left>")  -- Move Left
    keymap("i", "<C-l>", "<Right>") -- Move Right
    keymap("i", "<C-k>", "<Up>")    -- Move Up
    keymap("i", "<C-j>", "<Down>")  -- Move Down
end

function M.normal()
    keymap("n", "<ESC>", "<cmd> noh <CR>", { silent = true }) -- Clear Highlights

    --------- Miscellaneous ---------
    keymap("n", "<C-s>", "<cmd> w <CR>")             -- Save File
    keymap("n", "<C-x>", "<cmd> x <CR>")             -- Save and Exit
    keymap("n", "<C-q>", "<cmd> q! <CR>")            -- Don't Save and Exit
    keymap("n", "<leader>n", "<cmd> set nu! <CR>")   -- Toggle Line Number
    keymap("n", "<leader>rn", "<cmd> set rnu! <CR>") -- Toggle Relative Number

    --------- Switch Between Windows ---------
    keymap("n", "<C-h>", "<C-w>h") -- Window Left
    keymap("n", "<C-l>", "<C-w>l") -- Window Right
    keymap("n", "<C-k>", "<C-w>k") -- Window Up
    keymap("n", "<C-j>", "<C-w>j") -- Window Down

    --------- Buffers  ---------
    keymap("n", "<tab>", "<cmd> bn <CR>")        -- Next Buffer
    keymap("n", "<S-tab>", "<cmd> bp <CR>")      -- Preview Buffer
    keymap("n", "<leader>ch", "<cmd> enew <CR>") -- New Buffer
    keymap("n", "<C-d>", "<cmd> bd! <CR>")       -- Kill Buffer
    keymap("n", "<C-c>", "<cmd> w | bd <CR>")    -- Save and Kill Buffer
end

function M.visual()
end

function M.terminal()
    keymap("t", "ESC", vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true)) -- Escape Terminal Mode
end

function M.plugins()
    local plugins = {}

    --------- Telescope ---------
    function plugins.telescope()
        local actions = require "telescope.actions"
        local fb_actions = require "telescope".extensions.file_browser.actions
        local get_status = require "telescope.state".get_status
        local select_one_or_multi = require("core.utils").select_one_or_multi

        keymap("n", "<leader>f", "<cmd> Telescope live_grep <CR>", {noremap = true})
        keymap("n", "<leader>h", "<cmd> Telescope file_browser <CR>", { noremap = true })

        return {
                -- Mapping Telescope
                i = {
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-b>"] = function(bufnr)
                        get_status(bufnr).picker.layout_config.scroll_speed = 1
                        return actions.preview_scrolling_up(bufnr)
                    end,
                    ["<C-f>"] = function(bufnr)
                        get_status(bufnr).picker.layout_config.scroll_speed = 1
                        return actions.preview_scrolling_down(bufnr)
                    end,
                    ["<ScrollWheelUp>"] = function(bufnr)
                        get_status(bufnr).picker.layout_config.scroll_speed = 1
                        return actions.preview_scrolling_up(bufnr)
                    end,
                    ["<ScrollWheelDown>"] = function(bufnr)
                        get_status(bufnr).picker.layout_config.scroll_speed = 1
                        return actions.preview_scrolling_down(bufnr)
                    end,
                    ["<C-q>"] = actions.close,
                    ["<C-d>"] = actions.close,
                    ["<CR>"] = select_one_or_multi,
                },
                n = {
                    ["<C-b>"] = function(bufnr)
                        get_status(bufnr).picker.layout_config.scroll_speed = 1
                        return actions.preview_scrolling_up(bufnr)
                    end,
                    ["<C-f>"] = function(bufnr)
                        get_status(bufnr).picker.layout_config.scroll_speed = 1
                        return actions.preview_scrolling_down(bufnr)
                    end,
                    ["<ScrollWheelUp>"] = function(bufnr)
                        get_status(bufnr).picker.layout_config.scroll_speed = 1
                        return actions.preview_scrolling_up(bufnr)
                    end,
                    ["<ScrollWheelDown>"] = function(bufnr)
                        get_status(bufnr).picker.layout_config.scroll_speed = 1
                        return actions.preview_scrolling_down(bufnr)
                    end,
                    ["<C-q>"] = actions.close,
                    ["<C-d>"] = actions.close,
                    ["<CR>"] = select_one_or_multi,
                }
            },
            {
                -- Mapping Telescope File Browser
                i = {
                    ["<C-c>"] = fb_actions.create,
                    ["<C-x>"] = fb_actions.remove,
                    ["<C-r>"] = fb_actions.rename,
                    ["<C-m>"] = fb_actions.move,
                    ["<C-y>"] = fb_actions.copy,
                    ["<C-s>"] = fb_actions.toggle_all,
                    ["<C-g>"] = fb_actions.goto_parent_dir,
                    ["<C-e>"] = fb_actions.goto_home_dir,
                    ["<C-w>"] = fb_actions.goto_cwd,
                    ["<C-t>"] = fb_actions.change_cwd,
                    ["<C-h>"] = fb_actions.toggle_hidden,
                },
                n = {
                    ["c"] = fb_actions.create,
                    ["x"] = fb_actions.remove,
                    ["r"] = fb_actions.rename,
                    ["m"] = fb_actions.move,
                    ["y"] = fb_actions.copy,
                    ["s"] = fb_actions.toggle_all,
                    ["g"] = fb_actions.goto_parent_dir,
                    ["e"] = fb_actions.goto_home_dir,
                    ["w"] = fb_actions.goto_cwd,
                    ["t"] = fb_actions.change_cwd,
                    ["h"] = fb_actions.toggle_hidden,
                }
            }
    end

    --------- NvimTree (Disabled) ---------
    function plugins.nvimtree()
        keymap("n", "<leader>h", "<cmd> NvimTreeToggle <CR>", { silent = true }) -- Toggle NvimTree
    end

    --------- Cmp ---------
    function plugins.cmp()
        local cmp = require("cmp")
        return {
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }
    end

    --------- Lspconfig ---------
    function plugins.lspconfig()
        keymap("n", "<leader>ç", vim.diagnostic.open_float)
        keymap("n", "<leader>[", vim.diagnostic.goto_prev)
        keymap("n", "<leader>]", vim.diagnostic.goto_next)
        keymap("n", "<leader>~", vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                -- Buffer local mappings.
                local opts = { buffer = ev.buf }
                keymap("n", "gD", vim.lsp.buf.declaration, opts)
                keymap("n", "gd", vim.lsp.buf.definition, opts)
                keymap("n", "K", vim.lsp.buf.hover, opts)
                keymap("n", "gi", vim.lsp.buf.implementation, opts)
                keymap("n", "<C-ç>", vim.lsp.buf.signature_help, opts)
                keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
                keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
                keymap("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                keymap("n", "<leader>D", vim.lsp.buf.type_definition, opts)
                keymap("n", "<leader>rx", vim.lsp.buf.rename, opts)
                keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                keymap("n", "gr", vim.lsp.buf.references, opts)
                keymap("n", "<leader>t", function()
                    vim.lsp.buf.format { async = true }
                end, opts)
            end
        })
    end

    return plugins
end

M.setup()
return M
