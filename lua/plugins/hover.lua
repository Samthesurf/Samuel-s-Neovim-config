return {
	"lewis6991/hover.nvim",
	config = function()
		require("hover").config({
			providers = {
				"hover.providers.diagnostic",
				"hover.providers.lsp",
				"hover.providers.dap",
				"hover.providers.man",
				"hover.providers.dictionary",
			},
			preview_opts = {
				border = "single",
			},
			-- Whether the contents of a currently open hover window should be moved
			-- to a :h preview-window when pressing the hover keymap.
			preview_window = false,
			title = false,
			mouse_providers = {
				"hover.providers.lsp",
			},
			mouse_delay = 500,
		})

		local map = vim.keymap.set

		map("n", "K", function()
			require("hover").open()
		end, { desc = "hover.nvim (open)" })

		map("n", "gK", function()
			require("hover").enter()
		end, { desc = "hover.nvim (enter)" })

		map("n", "<C-p>", function()
			require("hover").switch("previous")
		end, { desc = "hover.nvim (previous source)" })

		map("n", "<C-n>", function()
			require("hover").switch("next")
		end, { desc = "hover.nvim (next source)" })

		vim.o.mousemoveevent = true
		map("n", "<MouseMove>", function()
			require("hover").mouse()
		end, { desc = "hover.nvim (mouse)" })
	end,
}
