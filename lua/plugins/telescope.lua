return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5", -- or ,
		dependencies = { "nvim-lua/plenary.nvim", { "nvim-telescope/telescope-fzf-native.nvim", build = "make" } },
		config = function()
			require("telescope").setup({
				defaults = {
					prompt_prefix = "   ",
					selection_caret = "  ",
					entry_prefix = "  ",
					sorting_strategy = "ascending",
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
							results_width = 0.8,
						},
						vertical = {
							mirror = false,
						},
						width = 0.87,
						height = 0.80,
						preview_cutoff = 120,
					},
					color_devicons = true,
					set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
					file_sorter = require("telescope.sorters").get_fuzzy_file,
					-- border = false
				},
				-- extensions_list = { "file_browser", "fzf", "undo" , "themes"},
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
					-- file_browser = {
						-- display_stat = {date = false, size = false, mode = false},
						-- theme - "ivy",
						-- select_buffer = true,
					-- },
				},
			})
			-- require("telescope").load_extension("undo")
			require("telescope").load_extension("fzf")
			-- require("telescope").load_extension("file_browser")
			-- require('telescope').load_extension('dap')
			-- require("telescope.themes").setup{}
		end,
	},
	{
		-- "nvim-telescope/telescope-file-browser.nvim",
		-- dependencies = "nvim-telescope/telescope.nvim",
	},
}
