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
	M.plugins = M.plugins()
end

function M.global()
	g.mapleader = " "
end

function M.insert()
	--------- Miscellaneous ---------

	--------- Navigate Within Insert Mode ---------
	keymap("i", "<C-h>", "<Left>", { noremap = true }) -- Move Left
	keymap("i", "<C-l>", "<Right>", { noremap = true }) -- Move Right
	keymap("i", "<C-k>", "<Up>", { noremap = true }) -- Move Up
	keymap("i", "<C-j>", "<Down>", { noremap = true }) -- Move Down
end

function M.normal()
	keymap("n", "<ESC>", "<cmd> noh <CR>", { silent = true }) -- Clear Highlights

	--------- Miscellaneous ---------
	keymap("n", "<leader>n", "<cmd> set nu! <CR>", { noremap = true, silent = true }) -- Toggle Line Number
	keymap("n", "<leader>rn", "<cmd> set rnu! <CR>", { noremap = true, silent = true }) -- Toggle Relative Number
	keymap("n", "<leader>rn", "<cmd> set rnu! <CR>", { noremap = true, silent = true }) -- Toggle Relative Number

	--------- Switch Between Windows ---------
	keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true }) -- Window Left
	keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true }) -- Window Right
	keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true }) -- Window Up
	keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true }) -- Window Down

	--------- Buffers  ---------
	keymap("n", "<tab>", "<cmd> bn <CR>", { noremap = true, silent = true }) -- Next Buffer
	keymap("n", "<S-tab>", "<cmd> bp <CR>", { noremap = true, silent = true }) -- Preview Buffer
	keymap("n", "<leader>ch", "<cmd> enew <CR>", { noremap = true, silent = true }) -- New Buffer
	keymap("n", "<C-n>", "<cmd> vsplit <CR>", { noremap = true, silent = true }) -- Vertical Split
	keymap("n", "<C-m>", "<cmd> split <CR>", { noremap = true, silent = true }) -- Horizontal Split
	keymap("n", "<C-d>", "<cmd> bd! <CR>", { noremap = true, silent = true }) -- Kill Buffer
	keymap("n", "<C-c>", "<cmd> w | bd <CR>", { noremap = true, silent = true }) -- Save and Kill Buffer
	keymap("n", "<C-s>", "<cmd> w <CR>", { noremap = true, silent = true }) -- Save File
	keymap("n", "<C-x>", "<cmd> xall! <CR>", { noremap = true, silent = true }) -- Save all and Exit
	keymap("n", "<C-q>", "<cmd> q! <CR>", { noremap = true, silent = true }) -- Don't Save and Exit
end

function M.visual()
	keymap("v", "gp", [[:s/\%V\w\+/\L\u&/g<CR>:noh<CR>]], { noremap = true, silent = true })
end

function M.terminal()
	--------- Buffers  ---------
	keymap("t", "<C-d>", "<cmd> bd! <CR>", { noremap = true, silent = true }) -- Kill Buffer
	keymap("t", "<C-q>", "<cmd> q! <CR>", { noremap = true, silent = true }) -- Don't Save and Exit
end

function M.plugins()
	local plugins = {}

	--------- Telescope ---------
	function plugins.telescope()
		local actions = require("telescope.actions")
		local get_status = require("telescope.state").get_status
		local select_one_or_multi = require("core.utils").select_one_or_multi
		local focus_preview = require("core.utils").focus_preview

		keymap("n", "<leader>f", "<cmd> Telescope live_grep <CR>", { noremap = true })
		keymap("n", "<leader>H", "<cmd> Telescope find_files <CR>", { noremap = true })
		keymap("n", "<leader>j", "<cmd> Telescope buffers <CR>", { noremap = true })
		keymap("n", "gd", "<cmd> Telescope lsp_definitions <CR>", { noremap = true })

		return {
			-- Mapping Telescope
			i = {
				["<CR>"] = actions.select_default,
				["<C-t>"] = select_one_or_multi,
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-u>"] = function(bufnr)
					return focus_preview(bufnr, "<C-u>")
				end,
				["<C-p>"] = function(bufnr)
					return actions.preview_scrolling_left(bufnr)
				end,
				["<C-g>"] = function(bufnr)
					return actions.preview_scrolling_right(bufnr)
				end,
				["<C-v>"] = function(bufnr)
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
				["<C-d>"] = actions.close,
				["<C-b>"] = actions.select_vertical,
				["<C-n>"] = actions.select_horizontal,
			},
			n = {
				["<CR>"] = actions.select_default,
				["<C-k>"] = actions.move_selection_previous,
				["<C-j>"] = actions.move_selection_next,
				["<C-t>"] = select_one_or_multi,
				["<C-u>"] = function(bufnr)
					return focus_preview(bufnr, "<C-u>")
				end,
				["<C-p>"] = function(bufnr)
					return actions.preview_scrolling_left(bufnr)
				end,
				["<C-g>"] = function(bufnr)
					return actions.preview_scrolling_right(bufnr)
				end,
				["<C-v>"] = function(bufnr)
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
				["<C-d>"] = actions.close,
				["<C-b>"] = actions.select_vertical,
				["<C-n>"] = actions.select_horizontal,
				["e"] = false,
				["w"] = false,
			},
		}
	end

	--------- Focus ---------
	function plugins.focus()
	end

	--------- Live Server ---------
	function plugins.live_server()
		keymap("n", "<leader>bs", "<cmd> LiveServerStart <CR>", { silent = true })
		keymap("n", "<leader>bc", "<cmd> LiveServerStop <CR>", { silent = true })
	end

	--------- Neo Tree ---------
	function plugins.neo_tree()
		keymap("n", "<leader>h", "<cmd> Neotree toggle <CR>", { silent = true }) -- Toggle ZenMode
	end

	--------- Zen Mode ---------
	function plugins.zen_mode()
		keymap("n", "<leader>z", "<cmd> ZenMode <CR>", { silent = true }) -- Toggle ZenMode
		keymap("n", "<leader>a", "<cmd> Twilight <CR>", { silent = true }) -- Toggle NvimTree
	end

	--------- Conform ---------
	function plugins.conform()
		keymap("n", "<leader>t", require("conform").format, { silent = true })
	end

	--------- Ufo ---------
	function plugins.ufo()
		keymap("n", "zR", require("ufo").openAllFolds, { silent = true })
		keymap("n", "zM", require("ufo").closeAllFolds, { silent = true })
	end

	--------- Toggleterm ---------
	function plugins.toggleterm()
		keymap("n", "<C-g>", "<cmd> ToggleTerm <CR>", { silent = true }) -- Toggle Toggleterm
		keymap("i", "<C-g>", "<cmd> ToggleTerm <CR>", { silent = true }) -- Toggle Toggleterm
		keymap("t", "<C-g>", "<cmd> ToggleTerm <CR>", { silent = true }) -- Toggle Toggleterm
	end

	--------- Neovim Project ---------
	function plugins.neovim_project()
		keymap("n", "<leader>l", "<cmd> NeovimProjectHistory <CR>", { silent = true })
		keymap("n", "<leader>k", "<cmd> NeovimProjectDiscover <CR>", { silent = true })
		keymap("n", "<leader>R", "<cmd> NeovimProjectLoadRecent <CR>", { silent = true })
		return {
			i = "<C-x>",
			n = "x",
		}
	end

	--------- Codesnap ---------
	function plugins.codesnap()
		keymap("x", "<leader>C", "<cmd> CodeSnap <CR>")
		keymap("x", "<leader>S", "<cmd> CodeSnapSave <CR>")
	end

	--------- Blink ---------
	function plugins.blink()
		return {
			preset = "none",
			["<C-t>"] = { "show", "show_documentation", "hide_documentation", "fallback" },
			["<Tab>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward",
				"fallback",
			},
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-v>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
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
				-- keymap("n", "gd", vim.lsp.buf.definition, opts)
				keymap("n", "gt", vim.lsp.buf.hover, opts)
				keymap("n", "gi", vim.lsp.buf.implementation, opts)
				keymap("n", "ga", vim.lsp.buf.signature_help, opts)
				keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
				keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
				keymap("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				keymap("n", "<leader>D", vim.lsp.buf.type_definition, opts)
				keymap("n", "<leader>rx", vim.lsp.buf.rename, opts)
				keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				keymap("n", "gr", vim.lsp.buf.references, opts)
				-- keymap("n", "<leader>t", function()
				-- 	vim.lsp.buf.format({ async = true })
				-- end, opts)
			end,
		})
	end

	return plugins
end

M.setup()
return M
