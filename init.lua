---@diagnostic disable: undefined-global
local map = vim.keymap.set
vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		-- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- map('n', '<Esc>', '<Esc>:w<CR>', { desc = "trying auto save" })
-- map('i', '<Esc>', '<Esc>:w<CR>', { desc = "trying auto save" })
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
require("rust-tools").setup{}
require("gitsigns").setup({})
require("colorizer").setup({})
require("treesitter-context").setup({})
require("nvim-autopairs").setup({})
-- require('telescope').load_extension('dap')
require("Comment").setup({
	pre_hook = function(ctx)
		local U = require("Comment.utils")

		local status_utils_ok, utils = pcall(require, "ts_context_commentstring.utils")
		if not status_utils_ok then
			return
		end

		local location = nil
		if ctx.ctype == U.ctype.block then
			location = utils.get_cursor_location()
		elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
			location = utils.get_visual_start_location()
		end

		local status_internals_ok, internals = pcall(require, "ts_context_commentstring.internals")
		if not status_internals_ok then
			return
		end

		return internals.calculate_commentstring({
			key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
			location = location,
		})
	end,
})
-- local colors = require("tokyonight.colors").setup()
-- require("scrollbar").setup({
-- 	handle = {
-- 		color = "#b2beb5",
-- 	},
-- 	marks = {
-- 		Search = { color = colors.orange },
-- 		Error = { color = colors.error },
-- 		Warn = { color = colors.warning },
-- 		Info = { color = colors.info },
-- 		Hint = { color = colors.hint },
-- 		Misc = { color = colors.purple },
-- 	},
-- })
require("hover").setup {
            init = function()
                -- Require providers
                require("hover.providers.lsp")
                -- require('hover.providers.gh')
                -- require('hover.providers.gh_user')
                -- require('hover.providers.jira')
                -- require('hover.providers.man')
                require('hover.providers.dictionary')
            end,
            preview_opts = {
                border = 'single'
            },
            -- Whether the contents of a currently open hover window should be moved
            -- to a :h preview-window when pressing the hover keymap.
            preview_window = false,
            title = false,
            mouse_providers = {
                'LSP'
            },
            mouse_delay = 500
        }

        -- Setup keymaps
        -- map("n", "K", require("hover").hover, {desc = "hover.nvim"})
        map("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})

        -- Mouse support
        map('n', '<MouseMove>', require('hover').hover_mouse, { desc = "hover.nvim (mouse)" })
        vim.o.mousemoveevent = true


require("fzf-lua").setup({
    lsp ={
        code_actions = {
            previewer = 'codeaction_native',
            preview_pager = "delta --side-by-side -- width=$FZF_PREVIEW_COLUMNS --hunk-header-style='omit' --file-style='omit'",
        },
    },
})
require("keymaps")
require("plugins")
require("autocommands")
require("options")
require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
--which-key
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
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		-- null_ls.builtins.formatting.black,
		-- null_ls.builtins.diagnostics.mypy,
	},
})
vim.g.transparent_enabled = false
-- require("conform").setup({
-- 	formatters_by_ft = {
-- 		lua = { "stylua" },
-- 		python = { "black" },
-- 	},
-- 	format_on_save = {
-- 		timeout_ms = 20000,
-- 		lsp_fallback = false,
-- 	},
-- })
require("neodev").setup({
	library = { plugins = { "nvim-dap-ui" }, types = true },
})

require("notify").setup({
  background_colour = "#b2beb5",
})
-- vim.g.ayu_avoid_italics = true
-- vim.g.ayu_mirage = true
require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = true, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})

--nvim-cmp
require("nvim-cmp")
