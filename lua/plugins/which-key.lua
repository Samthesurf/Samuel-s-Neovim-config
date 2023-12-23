return {
	"folke/which-key.nvim",
	config = function()
		require("which-key").setup({
			plugins = {
				spelling = { enabled = true },
				marks = { enabled = true },
				registers = { enabled = true },
				presets = {
					operators = true,
					motions = true,
					text_objects = true,
					windows = true,
					nav = true,
					z = true,
					g = true,
				},
			},
		})
	end,
}
