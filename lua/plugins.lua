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
		config = function()
			require("code_runner").setup({})
		end,
	},
	{
		"CRAG666/betterTerm.nvim",
		config = function()
			require("betterTerm").setup({})
		end,
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
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"folke/neodev.nvim",
		opts = {},
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
		event = "VeryLazy",
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
		"simrat39/rust-tools.nvim",
		config = function()
			require("rust-tools").setup({})
		end,
	},
	{
		"chrisgrieser/nvim-genghis",
	},
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
	},
}
