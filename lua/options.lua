local opt = vim.opt
local map = vim.keymap.set
vim.o.mouse = ""
opt.number = true
opt.relativenumber = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.expandtab = true
opt.termguicolors = true
opt.guifont = "JetBrainsMono Nerd Font:h10:b"
if vim.g.neovide then
	opt.guifont = "JetBrainsMono Nerd Font:h11:b"
	vim.g.neovide_transparency = 0.65
	vim.g.neovide_background_color = "#1f528f"
end
-- vim.api.nvim_set_var("mapleader", " ")
-- Change diagnostic signs.
vim.diagnostic.config({
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = '✘',
                [vim.diagnostic.severity.WARN] = '',
                [vim.diagnostic.severity.INFO] = '',
                [vim.diagnostic.severity.HINT] = '',
            }
        }
    })
-- map('n','x','_x',{desc = "delete without yanking"})
vim.o.completeopt = "menuone,noselect"
opt.cursorline = true
opt.smartcase = true
opt.clipboard:append("unnamedplus")
vim.cmd([[let g:auto_save = 1]])
vim.cmd([[let g:auto_save_silent = 1]])

