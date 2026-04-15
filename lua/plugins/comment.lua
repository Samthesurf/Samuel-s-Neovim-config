return {
	{
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		lazy = false,
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		main = "ts_context_commentstring",
		opts = {
			enable_autocmd = false,
		},
	},
}
