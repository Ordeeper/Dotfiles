-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {

	"nvim-lua/plenary.nvim",

	-- Colorschemes
	-- Fallback Colorschemes
	--[[{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("tokyonight-night")
		end
	},]]

	{
		"AlphaTechnolog/pywal.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			-- Load the Colorscheme
			vim.cmd.colorscheme("pywal")
		end
	},

	-- Lsp stuff
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		config = function()
			require("mason").setup()
		end
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		cmd = { "LspInstall", "LspInstallAll", "LspUninstall", "LspUninstallAll" },
		config = function()
			local opts = require "plugins.configs.mason_lspconfig"
			vim.api.nvim_create_user_command("LspInstallAll", function()
				vim.cmd("LspInstall " .. table.concat(opts.ensure_installed, " "))
			end, {})
			vim.api.nvim_create_user_command("LspUninstallAll", function()
				vim.cmd("LspUninstall " .. table.concat(opts.ensure_installed, " "))
			end, {})
		end
	},

	{
		"neovim/nvim-lspconfig",
		init = function()
			require("core.utils").lazy_load "nvim-lspconfig"
		end,
		config = function()
			require("core.mappings").plugins.lspconfig()
		end
	},

	-- Load luasnips + Cmp related in insert mode only
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require "plugins.configs.cmp"
		end,
		dependencies = {
			-- Cmp sources plugins
			{
				"neovim/nvim-lspconfig",
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-calc",
				"rafamadriz/friendly-snippets",
			},

			{
				"L3MON4D3/LuaSnip",
				config = function()
					require("luasnip.loaders.from_vscode").lazy_load()
				end
			},

			-- Autopairing of (){}[] etc
			{
				"windwp/nvim-autopairs",
				opts = {
					fast_wrap = {},
					disable_filetype = { "TelescopePrompt", "vim" },
				},
				config = function(_, opts)
					require("nvim-autopairs").setup(opts)
					-- Setup cmp for autopairs
					local cmp_autopairs = require "nvim-autopairs.completion.cmp"
					require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end
			},
		},
	},

	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup()
		end
	},

	{
		"sontungexpt/sttusline",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			require("core.utils").lazy_load "sttusline"
		end,
		event = { "BufEnter" },
		opts = function()
			return require "plugins.configs.sttusline"
		end,
		config = function(_, opts)
			require("sttusline").setup(opts)
		end
	},

	--[[{
        "nvim-lualine/lualine.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        init = function()
            require("core.utils").lazy_load "nvim-lspconfig"
        end,
        lazy = false,
        opts = function()
            return require "plugins.configs.lualine"
        end,
        config = function(_, opts)
            require("lualine").setup(opts)
        end
    },]]

	{
		"akinsho/bufferline.nvim",
		lazy = false,
		dependencies = "nvim-tree/nvim-web-devicons",
		version = "*",
		opts = function()
			return require "plugins.configs.bufferline"
		end,
		config = function(_, opts)
			require("bufferline").setup(opts)
		end
	},

	{
		"nvim-treesitter/nvim-treesitter",
		init = function()
			require("core.utils").lazy_load "nvim-treesitter"
		end,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		opts = function()
			return require "plugins.configs.treesitter"
		end,
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end
	},

	{
		"windwp/nvim-ts-autotag",
		lazy = false,
		config = function()
			require("nvim-ts-autotag").setup()
		end
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		init = function()
			require("core.utils").lazy_load "indent-blankline.nvim"
		end,
		opts = function()
			return require("plugins.configs.others").blankline
		end,
		config = function(_, opts)
			require("ibl").setup(opts)
		end
	},

	{
		"nvim-telescope/telescope.nvim",
		version = false,
		dependencies = {
			{ "nvim-telescope/telescope-fzf-native.nvim",  build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
		},
		event = "VimEnter",
		init = function()
			require("core.utils").lazy_load "telescope.nvim"
		end,
		opts = function()
			return require "plugins.configs.telescope_conf"
		end,
		config = function(_, opts)
			local telescope = require("telescope")
			telescope.setup(opts)
			telescope.load_extension("fzf")
			telescope.load_extension("file_browser")
		end
	},

	{
		"norcalli/nvim-colorizer.lua",
		init = function()
			require("core.utils").lazy_load "nvim-colorizer.lua"
		end,
		config = function()
			require("colorizer").setup()
		end
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
			require("core.utils").lazy_load "gitsigns.nvim"
		end,
		config = function()
			require("gitsigns").setup()
		end
	},

	{
		"folke/zen-mode.nvim",
		dependencies = "folke/twilight.nvim",
		init = function()
			require("core.utils").lazy_load "zen-mode.nvim"
		end,
		opts = function()
			return require "plugins.configs.zen_mode"
		end
	},

	{
		"barrett-ruth/live-server.nvim",
		init = function()
			require("core.utils").lazy_load "live-server.nvim"
		end,
		opts = function()
			return require "plugins.configs.live_server"
		end,
		cmd = { "LiveServerStart", "LiveServerStop" },
		config = true
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		init = function()
			require("core.utils").lazy_load "render-markdown.nvim"
		end,
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = { "markdown", "Avante" },
		config = function()
			require("render-markdown").enable()
		end
	},

	{
		"Exafunction/codeium.nvim",
		event = "InsertEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end
	},

	{
		"kevinhwang91/nvim-ufo",
		init = function()
			require("core.utils").lazy_load "nvim-ufo"
		end,
		dependencies = "kevinhwang91/promise-async",
		event = "VimEnter",
		config = function()
			require("ufo").setup({
				provider_selector = function(bufnr, filetype, buftype)
					return { "treesitter", "indent" }
				end
			})
		end
	},

	{
		"akinsho/toggleterm.nvim",
		init = function()
			require("core.utils").lazy_load "toggleterm.nvim"
		end,
		version = "*",
		event = "VimEnter",
		opts = function()
			return require "plugins.configs.toggleterm"
		end,
		config = function(_, opts)
			require("toggleterm").setup(opts)
		end
	},

}

local lazy_nvim = require "plugins.configs.lazy_nvim"
require("lazy").setup(default_plugins, lazy_nvim)
