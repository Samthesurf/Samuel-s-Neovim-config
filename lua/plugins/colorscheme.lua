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
			"marko-cerovac/material.nvim",
			event = "VeryLazy",
            config = function()
                require("material").setup({
                    disable = {
                        background = true,
                    }
                })
            end
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
                vim.cmd.colorscheme "onedark"
			end,
		},
		{
			"CantoroMC/ayu-nvim",
		},
		{
			"fynnfluegge/monet.nvim",
			name = "monet",
			config = function()
				require("monet").setup({
					-- transparent_background = true,
				})
				-- vim.cmd([[colorscheme monet]])
			end,
		},
		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 1000,
			config = function()
				require("catppuccin").setup({ flavour = "macchiato" })
			end,
		},
	},
}
