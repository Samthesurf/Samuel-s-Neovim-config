vim.o.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.guifont = "JetBrainsMono Nerd Font:h10:b"
if vim.g.neovide then
	vim.opt.guifont = "JetBrainsMono Nerd Font:h10:b"
	vim.g.neovide_transparency = 0.95
	vim.g.neovide_background_color = "#1f528f"
end
-- on save current directory for the buffer becomes the directory for Neovim
vim.cmd([[au BufWritePre * cd %:p:h]])
vim.api.nvim_set_var("mapleader", " ")
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
vim.api.nvim_set_keymap("n", "dir", ":pwd<CR>", { noremap = true, silent = true })
-- Change diagnostic signs.
vim.fn.sign_define("DiagnosticSignError", { text = "❌", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "ℹ️", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
-- vim.api.nvim_set_keymap('n','x','_x',{desc = "delete without yanking"})
vim.o.completeopt = "menuone,noselect"
vim.opt.cursorline = true
vim.opt.smartcase = true
vim.opt.clipboard:append("unnamedplus")
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

require("lazy").setup({
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2", -- or ,
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	},
	{
		"nvim-tree/nvim-web-devicons",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"williamboman/mason.nvim",
	 	-- opts = function ()
			 ensure_installed = {
				"pyright",
				"ruff",
				"ruff-lsp",
				"jedi-language-server",
				"gopls",
				"black",
				"lua-language-server",
				"debugpy",
				"html-lsp",
				"emmet-language-server",
				"vale",
			}
          -- return ensure_installed
      ,
        config = function(_,opts)
            require("mason").setup(opts)
		vim.api.nvim_create_user_command("MasonInstallAll", function()
		vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
		end, {})
    end,
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"folke/trouble.nvim",
	},
	{
		--"mfussenegger/nvim-lint"
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"folke/which-key.nvim",
	},
	{
		"folke/flash.nvim",
		-- enabled = false,
		event = "VeryLazy",
		-- -@type Flash.Config
		opts = {},
        -- stylua: ignore
        keys = {
            {
                's', mode = { "n", "o", "x" }, function() require("flash").jump() end, desc = "Jump"
            },
            {
                "r",
                mode = "o",
                function() require("flash").remote() end,
                desc =
                "Remote Flash"
            },
            {
                "R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc =
                "Treesitter Search"
            },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"lewis6991/gitsigns.nvim",
	},
	{
		--"neoclide/coc.nvim", branch = 'release',
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"CRAG666/code_runner.nvim",
		config = true,
	},
	{
		"CRAG666/betterTerm.nvim",
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"folke/zen-mode.nvim",
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"junegunn/fzf",
	},
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>db",
				mode = "n",
				":DapToggleBreakpoint<CR>",
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dc",
				mode = "n",
				":DapContinue<CR>",
				desc = "Start debugging",
			},
			{
				"<leader>dt",
				mode = "n",
				":DapStepOver<CR>",
				desc = "Step Over",
			},
		},
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
	},
	{
		"goolord/alpha-nvim",
		config = function()
			local dashboard = require("alpha.themes.dashboard")
			local logo = [[
  ████████                       ██           ████     ██          ██
 ██░░░░░░                       ░░█          ░██░██   ░██         ░░
░██         ██████   ██████████  ░   ██████  ░██░░██  ░██ ██    ██ ██ ██████████
░█████████ ░░░░░░██ ░░██░░██░░██    ██░░░░   ░██ ░░██ ░██░██   ░██░██░░██░░██░░██
░░░░░░░░██  ███████  ░██ ░██ ░██   ░░█████   ░██  ░░██░██░░██ ░██ ░██ ░██ ░██ ░██
       ░██ ██░░░░██  ░██ ░██ ░██    ░░░░░██  ░██   ░░████ ░░████  ░██ ░██ ░██ ░██
 ████████ ░░████████ ███ ░██ ░██    ██████   ░██    ░░███  ░░██   ░██ ███ ░██ ░██   TM.
░░░░░░░░   ░░░░░░░░ ░░░  ░░  ░░    ░░░░░░    ░░      ░░░    ░░    ░░ ░░░  ░░  ░░   
      ]]
			dashboard.section.header.val = vim.split(logo, "\n")
      -- stylua: ignore
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file",       "<cmd> Telescope find_files <cr>"),
        dashboard.button("n", " " .. " New file",        "<cmd> ene <BAR> startinsert <cr>"),
        dashboard.button("r", " " .. " Recent files",    "<cmd> Telescope oldfiles <cr>"),
        dashboard.button("g", " " .. " Find text",       "<cmd> Telescope live_grep <cr>"),
        dashboard.button("c", " " .. " Config",          "<cmd> e $MYVIMRC <cr>"),
        dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
        dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
        dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
      }
			require("alpha").setup(dashboard.opts)
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"folke/neodev.nvim",
		opts = {},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
		},
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
    {
		"iamcco/markdown-preview.nvim",
		event = "VeryLazy",
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "rcarriga/nvim-notify", "MunifTanjim/nui.nvim" },
		opts = {
			-- add any options here
		},
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
    {
		"petertriho/nvim-scrollbar",
	},
	{
		-- "MunifTanjim/nui.nvim",
	},
	{
		"rcarriga/nvim-notify",
	},
	{
		"EdenEast/nightfox.nvim",
	},
	{
		"marko-cerovac/material.nvim",
		event = "VeryLazy",
	},
	{
		"rebelot/kanagawa.nvim",
	},
	{
		"xiyaowong/transparent.nvim",
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		enabled = false,
	},
	{
		"natecraddock/workspaces.nvim",
	},
	{
		"christoomey/vim-tmux-navigator",
	},
	{
		"907th/vim-auto-save",
	},
	{
		-- "stevearc/conform.nvim",
		-- event = "BufReadPre",
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = { "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
		"johngrib/vim-game-snake",
		event = "VeryLazy",
	},
	{
		"pwntester/octo.nvim",
		event = "VeryLazy",
	},
	{
		"ThePrimeagen/refactoring.nvim",
		event = "VeryLazy",
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy",
	},
	{
		"norcalli/nvim-colorizer.lua",
	},
    {
        "Exafunction/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function ()
            require("codeium").setup({})
        end
    },{
        "RRethy/nvim-base16",
    }
})

-- vim.keymap.set('n', '<Esc>', '<Esc>:w<CR>', { desc = "trying auto save" })
-- vim.keymap.set('i', '<Esc>', '<Esc>:w<CR>', { desc = "trying auto save" })
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
require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})
require("telescope").load_extension("undo")
require("telescope").load_extension("fzf")
require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-lspconfig").setup({})
require("gitsigns").setup({})
require("colorizer").setup({})
vim.cmd[[au BufEnter * :ColorizerToggle]]
require("treesitter-context").setup({})
require("nvim-autopairs").setup({})
-- require('telescope').load_extension('dap')
require("workspaces").setup({})
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
local colors = require("tokyonight.colors").setup()
require("scrollbar").setup({
	handle = {
		color = "#b2beb5",
	},
	marks = {
		Search = { color = colors.orange },
		Error = { color = colors.error },
		Warn = { color = colors.warning },
		Info = { color = colors.info },
		Hint = { color = colors.hint },
		Misc = { color = colors.purple },
	},
})
require("barbecue").setup({
	theme = {
		-- this highlight is used to override other highlights
		-- you can take advantage of its bg and set a background throughout your winbar
		-- (e.g. basename will look like this: { fg = "#c0caf5", bold = true })
		normal = { fg = "#c0caf5" },

		-- these highlights correspond to symbols table from config
		ellipsis = { fg = "#737aa2" },
		separator = { fg = "#737aa2" },
		modified = { fg = "#737aa2" },

		-- these highlights represent the _text_ of three main parts of barbecue
		dirname = { fg = "#737aa2" },
		basename = { bold = true },
		context = {},

		-- these highlights are used for context/navic icons
		context_file = { fg = "#ac8fe4" },
		context_module = { fg = "#ac8fe4" },
		context_namespace = { fg = "#ac8fe4" },
		context_package = { fg = "#ac8fe4" },
		context_class = { fg = "#ac8fe4" },
		context_method = { fg = "#ac8fe4" },
		context_property = { fg = "#ac8fe4" },
		context_field = { fg = "#ac8fe4" },
		context_constructor = { fg = "#ac8fe4" },
		context_enum = { fg = "#ac8fe4" },
		context_interface = { fg = "#ac8fe4" },
		context_function = { fg = "#ac8fe4" },
		context_variable = { fg = "#ac8fe4" },
		context_constant = { fg = "#ac8fe4" },
		context_string = { fg = "#ac8fe4" },
		context_number = { fg = "#ac8fe4" },
		context_boolean = { fg = "#ac8fe4" },
		context_array = { fg = "#ac8fe4" },
		context_object = { fg = "#ac8fe4" },
		context_key = { fg = "#ac8fe4" },
		context_null = { fg = "#ac8fe4" },
		context_enum_member = { fg = "#ac8fe4" },
		context_struct = { fg = "#ac8fe4" },
		context_event = { fg = "#ac8fe4" },
		context_operator = { fg = "#ac8fe4" },
		context_type_parameter = { fg = "#ac8fe4" },
	},
})
local function lspinfo()
	local msg = "No Active Lsp"
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return msg
	end
	local active_clients = {}
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			table.insert(active_clients, client.name)
		end
	end
	if #active_clients > 0 then
		return table.concat(active_clients, ", ")
	else
		return msg
	end
end

local lspinfo_component = {
	function()
		return lspinfo()
	end,
	icon = " LSP:",
	color = { fg = "#87ceeb", gui = "bold" },
}
local function surfer()
	return [[SamuelSurf]]
end
require("lualine").setup({
	options = {
		-- section_separators = { left = '', right = '' },
		-- component_separators = { left = '', right = '' },
		theme = "ayu_mirage",
	},
	sections = {
		lualine_c = { "filename" },
		lualine_x = { lspinfo_component, surfer, "filetype" },
	},
})
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
vim.g.transparent_enabled = true
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
-- Format Python files on save
vim.cmd([[au BufWritePre *.py :lua vim.lsp.buf.format{timeout_ms = 10000}]])
require("neodev").setup({
	library = { plugins = { "nvim-dap-ui" }, types = true },
})
require("code_runner").setup({})
require("betterTerm").setup({})
vim.cmd([[
  augroup toggleterm
    autocmd!
    autocmd TermOpen * call settabvar(1, 'toggleterm_directory', expand('%:p:h'))
  augroup END
]])
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
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})
vim.keymap.set(
	"n",
	"<leader>/",
	"<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
	{ desc = "Comment line" }
)
vim.keymap.set(
	"x",
	"<leader>/",
	"<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
	{ desc = "Comment line" }
)
vim.api.nvim_set_keymap("n", "<leader>ft", ":Telescope live_grep<CR>", { noremap = true })
vim.keymap.set("n", "<C-m>", ":Mason<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>cl", ":LspInfo<cr>", { desc = "Lsp Info" })
vim.api.nvim_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })
vim.api.nvim_set_keymap("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>S", ":BufferLineCyclePrev<cr>", { desc = "Prev buffer", silent = true })
vim.keymap.set("n", "<leader>ih", ":lua vim.lsp.inlay_hint(0,nil)<CR>", { desc = "Toggle Inlay Hints", silent = true })
vim.keymap.set("n", "<leader>s", ":BufferLineCycleNext<cr>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<leader>bp", ":BufferLinePick<CR>", { desc = "Pick buffers", silent = true })
vim.api.nvim_set_keymap("n", "<leader>k", ":lua vim.lsp.buf.definition()<CR>", { desc = "Show definition" })
vim.keymap.set("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", { desc = "Code actions" })
vim.keymap.set("n", ":Q", ":q", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>fd", ":lua vim.lsp.buf.format{timeout_ms = 12000}<CR>", { desc = "Format" })
vim.api.nvim_set_keymap("n", "p", "P", { noremap = true })
vim.api.nvim_set_keymap("n", "yy", "0y$", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>a", "gg0vG$", { desc = "highlight entire document" })
vim.api.nvim_set_keymap("n", "<leader>vs", ":VimGameSnake<CR>", { desc = "Play Vim Snake" })
vim.api.nvim_set_keymap("n", "<leader>ss", ":echo g:VimSnakeScore<CR>", { desc = "See Snake score" })
vim.keymap.set("n", "<leader>ga", ":G add .<CR>", { desc = "git add your changes", silent = true })
vim.keymap.set("n", "<leader>gc", ":G commit<CR>:starti<CR>", { desc = "add a commit message" })
vim.keymap.set("n", "<leader>gp", ":G push<CR>", { desc = "Push changes to Github" })
vim.keymap.set("n", "<C-Left>", "<C-w>>", { desc = "Increasing width" })
vim.keymap.set("n", "<C-Right>", "<C-w><", { desc = "Decreasing width" })
vim.keymap.set("n", "<C-Up>", "<C-w>+", { desc = "Increasing height" })
vim.keymap.set("n", "<C-Down>", "<C-w>-", { desc = "Decreasing height" })
vim.keymap.set("n", "<leader>tb", ":Telescope buffers<CR>", { desc = "open buffers", silent = true })
vim.keymap.set("n", "<leader>te", ":terminal<CR>starti<CR>", { desc = "open Terminal", silent = true })
-- Define the key mappings
vim.api.nvim_set_keymap("n", "<A-1>", ":ToggleTerm direction=horizontal size=20<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-2>", ":ToggleTerm direction=vertical size=60<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-3>", ":ToggleTerm direction=float<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>qa", ":qall<CR>", { desc = "Close Neovim" })
vim.api.nvim_set_keymap("n", "<leader>of", ":Telescope oldfiles<CR>", { desc = "Recent Files" })
vim.api.nvim_set_keymap("n", "<leader>fz", ":cd ~<CR>:FZF<CR>", { desc = "fzf" })
vim.api.nvim_set_keymap("n", "<leader>wa", ":wqall<CR>", { desc = "Save and exit Neovim" })
vim.api.nvim_set_keymap("n", "<leader>tk", ":Telescope keymaps<CR>", { desc = "Keymaps" })
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { desc = "half page up" })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { desc = "half page down" })
vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { desc = "exit", silent = true })
--Running code lol
-- NOTE: If clangd or clang doesn't work as intended, do the following
-- 1) for Linux: clang -v, check the location of GCC it's checking to run, then do sudo apt install libstdc++-12-dev if the gcc version is 12 or 13 if the version is 13
-- 2) for Windows, use the visual studio installer and install clang instead of other sources, and then add clang to path in environment variables
-- vim.cmd([[
-- augroup exe_code
--     autocmd!
--     autocmd FileType python noremap <buffer> <F5>
--     	\ :sp<CR>:term python3 %<CR> i
--     autocmd FileType cpp noremap <buffer> <F5>
--     \ :sp<CR>:term clang++ % -o %:r;%:r<CR> i
--     autocmd FileType c noremap <buffer> <F5>
--     \ :sp<CR>:term clang % -o %:r;%:r<CR> i
-- augroup END
-- ]])
-- Time to improve the code running experience lol
vim.cmd([[
augroup exe_code
    autocmd!
    autocmd FileType python noremap <buffer> <F4>
    	\ :TermExec cmd="python3 %" size=20<CR>:wincmd j<CR>:starti<CR>
    autocmd FileType cpp noremap <buffer> <F4>
    \ :w<CR>:TermExec cmd="clang++ % -o %:r;./%:r" direction=float <CR>
    autocmd FileType c noremap <buffer> <F4>
    \ :w<CR>:TermExec cmd="clang % -o %:r;./%:r" direction=float <CR>
augroup END
]])

require("neo-tree").setup({
	enable_git_status = true,
	enable_diagnostics = true,
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
	config = {
		sources = {
			"document_symbols",
		},
	},
})

vim.keymap.set("n", "S", function()
	require("flash").treesitter()
end, { desc = "Flash Treesitter" })
vim.keymap.set("n", "<BS>", "dh")
vim.cmd([[let g:auto_save = 1]])
vim.cmd([[let g:auto_save_silent = 1]])
require("catppuccin").setup({ flavour = "macchiato" })
vim.cmd([[colorscheme kanagawa]])
require("bufferline").setup({
	options = {
		offsets = {
			{
				filetype = "neo-tree",
				text = "Sam's files",
				highlight = "Directory",
				separator = true, -- use a "true" to enable the default, or set your own character
			},
		},
	},
})

local nvim_lsp = require("lspconfig")
nvim_lsp.pyright.setup({
	python = {
		analysis = {
			"openFilesOnly",
		},
	},
})
nvim_lsp.bashls.setup({})
nvim_lsp.emmet_language_server.setup({})
nvim_lsp.cssls.setup({})
nvim_lsp.jsonls.setup({})
nvim_lsp.ruff_lsp.setup({})
--Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

nvim_lsp.html.setup({
	capabilities = capabilities,
})

-- require'lspconfig'.pylyzer.setup{}
nvim_lsp.clangd.setup({
	cmd = { "clangd", "--clang-tidy" },
	filetypes = { "c", "cpp" },
	root_dir = require("lspconfig").util.root_pattern(".git", "compile_commands.json"),
})
local cmp1 = require("cmp")
cmp1.setup({ sources = { name = "nvim_lsp" } })
require("lspconfig").lua_ls.setup({
	Lua = {
		diagnostics = {
			libraryFiles = "Disable",
		},
		workspace = {
			checkThirdParty = false,
			maxPreload = 2,
		},
		telemetry = { enable = false },
		hint = {
			enable = true,
		},
	},
})
-- Neovim config for PowerShell Editor Services
require("lspconfig").powershell_es.setup({
	cmd = {
		"pwsh",
		"-NoLogo",
		"-NoProfile",
		"-NonInteractive",
		"-ExecutionPolicy",
		"Bypass",
		"-Command",
		"EditorServices.StartEditorServices()",
	},
	filetypes = { "powershell" },
})
-- Configure gopls
require("lspconfig").gopls.setup({
	cmd = { "gopls", "serve" },
	filetypes = { "go" },
})

vim.api.nvim_set_keymap(
	"n",
	"<leader>e",
	":Neotree filesystem reveal right toggle<CR>",
	{ desc = "file explorer", noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<leader>eg",
	":Neotree git_status toggle<CR>",
	{ desc = "file git status", noremap = true, silent = true }
)
vim.keymap.set("n", "i", "a")
-- <A means alt
vim.api.nvim_set_keymap("n", "<A-r>", ":RunCode<CR>:starti<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>d", ":bw!<CR>", { desc = "delete tab", silent = true })

--nvim-cmp
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local kind_icons = {
	Text = "󰉿",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = " ",
	Variable = "󰀫",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "󰑭",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = " ",
	Misc = " ",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		-- ["<Tab>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				nvim_lsp = "[LSP]",
				luasnip = "[Snippet]",
				buffer = "[Buffer]",
				path = "[Path]",
                codeium = "AI",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
        { name = "codeium"},
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		documentation = {
			border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		},
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})
vim.keymap.set("n", "<leader>tt", function()
	require("trouble").open()
end, { desc = "Trouble" })
vim.keymap.set("n", "<leader>tw", function()
	require("trouble").open("workspace_diagnostics")
end, { desc = "workspace trouble" })
vim.keymap.set("n", "<leader>td", function()
	require("trouble").open("document_diagnostics")
end, { desc = "document trouble" })
vim.keymap.set("n", "<leader>tq", function()
	require("trouble").open("quickfix")
end, { desc = "quickfix" })
vim.keymap.set("n", "<leader>tl", function()
	require("trouble").open("loclist")
end, { desc = "loclist" })
vim.keymap.set("n", "gR", function()
	require("trouble").open("lsp_references")
end, { desc = "references" })

-- restore the session for the current directory
vim.api.nvim_set_keymap(
	"n",
	"<leader>ps",
	[[<cmd>lua require("persistence").load()<cr>]],
	{ desc = "restore session for dir" }
)

-- restore the last session
vim.api.nvim_set_keymap(
	"n",
	"<leader>pl",
	[[<cmd>lua require("persistence").load({ last = true })<cr>]],
	{ desc = "restore last session" }
)

-- stop Persistence => session won't be saved on exit
vim.api.nvim_set_keymap(
	"n",
	"<leader>qd",
	[[<cmd>lua require("persistence").stop()<cr>]],
	{ desc = "Don't save session" }
)
