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
	"lua_ls", "pylsp", "bashls", "cssls", "phpactor", "yamlls", "html", "tailwindcss"
}
M.exclude_installed = {

}
require("mason-lspconfig").setup {
	-- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
	ensure_installed = M.ensure_installed,
}

-- Setup Lsp
local lspconfig = require "lspconfig"

local border = {
	{ "┌", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "┐", "FloatBorder" },
	{ "│", "FloatBorder" },
	{ "┘", "FloatBorder" },
	{ "─", "FloatBorder" },
	{ "└", "FloatBorder" },
	{ "│", "FloatBorder" },
}

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	float = { border = border },
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or border
	return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

--------- LSP ---------
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
lspconfig.phpactor.setup {}
lspconfig.yamlls.setup {}
lspconfig.tailwindcss.setup {}
lspconfig.cssls.setup {}
lspconfig.html.setup {}

-- vim.lsp.set_log_level("DEBUG")

return M
