return {
	{
		"folke/trouble.nvim",
	},
	{
		--"mfussenegger/nvim-lint"
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
	{
		"folke/flash.nvim",
		-- enabled = false,
		event = "VeryLazy",
		-- -@type Flash.Config
		opts = {},
        -- stylua: ignore
        keys = {
            {
                's', mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Jump"
            },
            {
                "r",
                mode = "o",
                function() require("flash").remote() end,
                desc =
                "Remote Flash"
            },
            {
                "R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc =
                "Treesitter Search"
            },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
		end,
	},
	{
		--"neoclide/coc.nvim", branch = 'release',
	},
	{
		"CRAG666/code_runner.nvim",
		cmd = "RunCode",
		keys = { { "<A-r>", ":RunCode<CR>:starti<CR>", desc = "Run the Code" } },
		config = function()
			require("code_runner").setup({})
		end,
		dependencies = { "CRAG666/betterTerm.nvim" },
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({})
		end,
	},
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"folke/neodev.nvim",
		opts = {},
		ft = { "lua", "vim" },
		config = function()
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui" }, types = true },
			})
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
		},
	},
	{
		"iamcco/markdown-preview.nvim",
		ft = { "markdown" },
	},
	{
		"rcarriga/nvim-notify",
	},
	{
		"xiyaowong/transparent.nvim",
	},
	{
		"christoomey/vim-tmux-navigator",
	},
	{
		"907th/vim-auto-save",
		event = "BufReadPre",
	},
	{
		-- "stevearc/conform.nvim",
		-- event = "BufReadPre",
	},
	{
		"johngrib/vim-game-snake",
		event = "VeryLazy",
	},
	{
		"pwntester/octo.nvim",
		event = "VeryLazy",
	},
	{
		"ThePrimeagen/refactoring.nvim",
		event = "VeryLazy",
	},
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({})
		end,
	},
	{
		"Exafunction/codeium.nvim",
		event = "BufReadPre",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			require("codeium").setup({})
		end,
	},
	{
		"RRethy/nvim-base16",
	},
	{
		-- "aikooo7/funnyfiles.nvim",
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^3", --Recommended
		ft = { "rust" },
	},
	{
		"chrisgrieser/nvim-genghis",
	},
	{
		"smjonas/inc-rename.nvim",
		event = "BufReadPre",
		config = function()
			require("inc_rename").setup()
		end,
	},
	{
		"mg979/vim-visual-multi",
		event = "BufReadPre",
	},
	{
		"kosayoda/nvim-lightbulb",
		event = "BufReadPre",
		config = function()
			require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
		end,
	},
	{
		"roobert/activate.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{
				"<leader>P",
				'<Cmd>lua require"activate".list_plugins()<CR>',
				desc = "Plugins",
			},
		},
	},
	{
		"nvim-neotest/nvim-nio",
	},
	{
		"mistricky/codesnap.nvim",
		build = "make",
		opts = {
			save_path = "~/Pictures/Code_screenshots/",
			has_breadcrumbs = true,
			bg_theme = "sea",
			watermark = "@SamuelSurfboard",
			bg_x_padding = 52,
			bg_y_padding = 82,
			watermark_font_family = "JetBrainsMono Nerd Font",
			watermark_font_size = 20,
			watermark_color = "orange",
		},
	},
}
