-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {
	"nvim-lua/plenary.nvim",

	-- Colorschemes {
	{
		"folke/tokyonight.nvim",
		dependencies = "AlphaTechnolog/pywal.nvim",
		lazy = false,
		priority = 1000,
		opts = function()
			return require("plugins.configs.tokyonight")
		end,
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	-- Lsp stuff
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		cmd = { "LspInstall", "LspInstallAll", "LspUninstall", "LspUninstallAll" },
		config = function()
			local opts = require("plugins.configs.mason_lspconfig")
			vim.api.nvim_create_user_command("LspInstallAll", function()
				vim.cmd("LspInstall " .. table.concat(opts.ensure_installed, " "))
			end, {})
			vim.api.nvim_create_user_command("LspUninstallAll", function()
				vim.cmd("LspUninstall " .. table.concat(opts.ensure_installed, " "))
			end, {})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		init = function()
			require("core.utils").lazy_load("nvim-lspconfig")
		end,
		config = function()
			require("core.mappings").plugins.lspconfig()
		end,
	},

	{
		"saghen/blink.cmp",
		init = function()
			require("core.utils").lazy_load("blink.cmp")
		end,
		dependencies = {
			"rafamadriz/friendly-snippets",

			{
				"Exafunction/windsurf.nvim",
				dependencies = {
					"nvim-lua/plenary.nvim",
					"hrsh7th/nvim-cmp",
				},
				config = function()
					require("codeium").setup({})
				end,
			},
		},
		version = "*",
		opts = function()
			return require("plugins.configs.blink")
		end,
		opts_extend = { "sources.default" },
	},

	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end,
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "VimEnter",
		init = function()
			require("core.utils").lazy_load("lualine.nvim")
		end,
		opts = function()
			return require("plugins.configs.lualine")
		end,
		config = function(_, opts)
			require("lualine").setup(opts)
		end,
	},

	{
		"akinsho/bufferline.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		event = "VimEnter",
		version = "*",
		opts = function()
			return require("plugins.configs.bufferline")
		end,
		config = function(_, opts)
			require("bufferline").setup(opts)
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		init = function()
			require("core.utils").lazy_load("nvim-treesitter")
		end,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = function()
			return require("plugins.configs.treesitter")
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},

	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		init = function()
			require("core.utils").lazy_load("indent-blankline.nvim")
		end,
		opts = function()
			return require("plugins.configs.others").blankline
		end,
		config = function(_, opts)
			require("ibl").setup(opts)
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		version = false,
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			{ "nvim-telescope/telescope-file-browser.nvim" },
		},
		event = "VimEnter",
		init = function()
			require("core.utils").lazy_load("telescope.nvim")
		end,
		opts = function()
			return require("plugins.configs.telescope_conf")
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
		end,
	},

	{
		"brenoprata10/nvim-highlight-colors",
		init = function()
			require("core.utils").lazy_load("nvim-highlight-colors")
		end,
		opts = function()
			return require("plugins.configs.highlight_colors")
		end,
		config = function(_, opts)
			require("nvim-highlight-colors").setup(opts)
		end,
	},

	--[[{
        "nvim-neorg/neorg",
        init = function()
            require("core.utils").lazy_load "neorg"
        end,
        ft = "norg",
        cmd = "Neorg",
        build = ":Neorg sync-parsers",
        dependencies = "nvim-lua/plenary.nvim",
        opts = function()
            return require "plugins.configs.neorg"
        end,
        config = function(_, opts)
            require("neorg").setup(opts)
        end
    },]]

	{
		"lewis6991/gitsigns.nvim",
		init = function()
			require("core.utils").lazy_load("gitsigns.nvim")
		end,
		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"folke/zen-mode.nvim",
		dependencies = "folke/twilight.nvim",
		init = function()
			require("core.utils").lazy_load("zen-mode.nvim")
		end,
		opts = function()
			return require("plugins.configs.zen_mode")
		end,
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		init = function()
			require("core.utils").lazy_load("render-markdown.nvim")
		end,
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown", "Avante" },
		config = function()
			require("render-markdown").enable()
		end,
	},

	{
		"barrett-ruth/live-server.nvim",
		init = function()
			require("core.utils").lazy_load("live-server.nvim")
		end,
		opts = function()
			return require("plugins.configs.live_server")
		end,
		cmd = { "LiveServerStart", "LiveServerStop" },
		config = true,
	},

	{
		"kevinhwang91/nvim-ufo",
		init = function()
			require("core.utils").lazy_load("nvim-ufo")
		end,
		dependencies = "kevinhwang91/promise-async",
		event = "VimEnter",
		config = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end,
			})
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		init = function()
			require("core.utils").lazy_load("toggleterm.nvim")
		end,
		version = "*",
		event = "VimEnter",
		opts = function()
			return require("plugins.configs.toggleterm")
		end,
		config = function(_, opts)
			require("toggleterm").setup(opts)
		end,
	},

	{
		"coffebar/neovim-project",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
			"Shatur/neovim-session-manager",
		},
		event = "VimEnter",
		init = function()
			require("core.utils").lazy_load("neovim-project")
			vim.opt.sessionoptions:append("globals")
		end,
		opts = function()
			return require("plugins.configs.neovim_project")
		end,
		config = function(_, opts)
			require("neovim-project").setup(opts)
		end,
	},

	{
		"mistricky/codesnap.nvim",
		build = "make",
		init = function()
			require("core.utils").lazy_load("codesnap.nvim")
		end,
		keys = {
			require("core.mappings").plugins.codesnap(),
		},
		config = function(_, opts)
			require("codesnap").setup(opts)
		end,
	},

	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
		opts = function()
			return require("plugins.configs.typescript_tools")
		end,
		config = function(_, opts)
			require("typescript-tools").setup(opts)
		end,
	},

	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = function()
			return require("plugins.configs.conform")
		end,
		config = function(_, opts)
			require("conform").setup(opts)
			require("core.mappings").plugins.conform()
		end,
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "BufEnter",
		opts = function()
			return require("plugins.configs.mason_tool_installer")
		end,
		config = function(_, opts)
			require("mason-tool-installer").setup(opts)
		end,
	},

	{
		"akinsho/flutter-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		config = function(_)
			require("flutter-tools").setup({})
		end,
		lazy = false,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			return require("plugins.configs.neo_tree_conf")
		end,
		config = function(_, opts)
			require("neo-tree").setup(opts)
		end,
		lazy = false,
	},

	{
		"nvim-focus/focus.nvim",
		version = "*",
		opts = function()
			return require("plugins.configs.focus")
		end,
		config = function(_, opts)
			require("focus").setup(opts)
		end,
		event = "VimEnter",
	},

	{
		"sunjon/shade.nvim",
		init = function()
			require("core.utils").lazy_load("shade.nvim")
		end,
		config = function()
			require("shade").setup()
		end,
	},
}

local lazy_nvim = require("plugins.configs.lazy_nvim")
require("lazy").setup(default_plugins, lazy_nvim)
