return {
	"lewis6991/hover.nvim",
	config = function()
		require("hover").setup({
			init = function()
				-- Require providers
				require("hover.providers.lsp")
				-- require('hover.providers.gh')
				-- require('hover.providers.gh_user')
				-- require('hover.providers.jira')
				-- require('hover.providers.man')
				-- require("hover.providers.dictionary")
			end,
			preview_opts = {
				border = "single",
			},
			-- Whether the contents of a currently open hover window should be moved
			-- to a :h preview-window when pressing the hover keymap.
			preview_window = false,
			title = false,
			mouse_providers = {
				"LSP",
			},
			mouse_delay = 500,
		})
		local map = vim.keymap.set
		-- Setup keymaps
		-- map("n", "K", require("hover").hover, {desc = "hover.nvim"})
		map("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
        vim.o.mousemoveevent = true
		-- Mouse support
		map("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
	end,
}
