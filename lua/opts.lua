local opts = {
	defaults = { lazy = true },
	install = {
		colorscheme = "kanagawa",
	},
	ui = {
		icons = {
			ft = "",
			lazy = "󰂠 ",
			loaded = "",
			not_loaded = "",
		},
	},
}
require("lazy").setup({ opts })
