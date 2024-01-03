return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = { "Neotree", "Neotree right" },
	keys = {
		{
			"\\",
			[[<cmd>Neotree right<cr>]],
			desc = "File explorer 1",
		},
		{
			"<leader>e",
			":Neotree filesystem reveal right toggle<CR>",
			{ desc = "file explorer", noremap = true, silent = true },
		},
	},
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("neo-tree").setup({
			enable_git_status = true,
			enable_diagnostics = true,
			sources = { "filesystem", "buffers", "git_status", "document_symbols" },
			buffers = {
				follow_current_file = {
					enabled = true,
				},
			},
			filesystem = {
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_hidden = false,
				},
			},
			symbols = {
				follow_cursor = true,
			},
		})
	end,
}
