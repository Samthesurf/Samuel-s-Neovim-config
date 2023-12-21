return {
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
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
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"folke/which-key.nvim",
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
	},
	{
		--"neoclide/coc.nvim", branch = 'release',
	},
	{
		"CRAG666/code_runner.nvim",
		config = true,
	},
	{
		"CRAG666/betterTerm.nvim",
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
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
	{},
	{
		"folke/zen-mode.nvim",
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>db",
				mode = "n",
				":DapToggleBreakpoint<CR>",
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dc",
				mode = "n",
				":DapContinue<CR>",
				desc = "Start debugging",
			},
			{
				"<leader>dt",
				mode = "n",
				":DapStepOver<CR>",
				desc = "Step Over",
			},
		},
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
	},
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"folke/neodev.nvim",
		opts = {},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
		},
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	{
		"iamcco/markdown-preview.nvim",
		event = "VeryLazy",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "rcarriga/nvim-notify", "MunifTanjim/nui.nvim" },
		opts = {
			-- add any options here
		},
	},
	{
		"petertriho/nvim-scrollbar",
	},
	{
		-- "MunifTanjim/nui.nvim",
	},
	{
		"rcarriga/nvim-notify",
	},
	{
		"xiyaowong/transparent.nvim",
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		enabled = false,
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
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
	},
	{
		"norcalli/nvim-colorizer.lua",
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
	},
	{
		"chrisgrieser/nvim-genghis",
	},
	{
		"ibhagwan/fzf-lua",
	},
	{
		"lewis6991/hover.nvim",
	},
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
	},
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		config = function()
			require("chatgpt").setup()
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
}
