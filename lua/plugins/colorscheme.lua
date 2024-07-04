return {
	{
		{
			"folke/tokyonight.nvim",
			lazy = false,
			priority = 1000,
			opts = {},
		},
		{
			"EdenEast/nightfox.nvim",
		},
		{
			"ray-x/starry.nvim",
			config = function()
				require("starry").setup({
					disable = {
						background = true,
					},
				})
				-- vim.cmd([[colorscheme starry]])
			end,
		},
		{
			"rebelot/kanagawa.nvim",
			config = function()
				require("kanagawa").setup({
					transparent = true,
					-- terminalColors = false,
				})
				-- vim.cmd([[colorscheme kanagawa]])
			end,
		},
		{
			"navarasu/onedark.nvim",
			config = function()
				require("onedark").setup({
					style = "warmer",
					-- transparent = true,
				})
				-- vim.cmd.colorscheme "onedark"
			end,
		},
		{
			"CantoroMC/ayu-nvim",
			config = function()
				-- vim.g.ayu_avoid_italics = true
				-- vim.g.ayu_mirage = true
			end,
		},
		{
			"fynnfluegge/monet.nvim",
			name = "monet",
			config = function()
				require("monet").setup({
					transparent_background = true,
				})
				-- vim.cmd([[colorscheme monet]])
			end,
		},
		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 1000,
			config = function()
				require("catppuccin").setup({
					transparent_background = true,
					-- flavour = "macchiato",
				})
				vim.cmd.colorscheme("catppuccin-mocha")
			end,
		},
		{
			"sainnhe/gruvbox-material",
			config = function()
				-- vim.cmd.colorscheme "gruvbox-material"
			end,
		},
		{
			"scottmckendry/cyberdream.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				require("cyberdream").setup({
					-- Recommended - see "Configuring" below for more config options
					transparent = true,
					italic_comments = true,
					hide_fillchars = true,
					borderless_telescope = true,
					terminal_colors = true,
				})
				-- vim.cmd("colorscheme cyberdream") -- set the colorscheme
			end,
		},
	},
}
