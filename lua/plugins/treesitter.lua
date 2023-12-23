return {
	"nvim-treesitter/nvim-treesitter",
	run = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			auto_install = true,
			highlight = { enable = true },
			ensure_installed = {
				"javascript",
				"typescript",
				"lua",
				"c",
				"cpp",
				"rust",
				"go",
				"python",
				"json",
				"html",
				"css",
				"vim",
				"toml",
			},
		})
	end,
}
