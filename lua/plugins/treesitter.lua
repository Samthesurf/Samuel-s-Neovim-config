-- nvim-treesitter `main` branch: required for Neovim 0.12+ (the old `master`
-- branch crashes with "attempt to call method 'range' (a nil value)" on 0.12,
-- especially with render-markdown.nvim parsing markdown buffers).
--
-- Requirements (install once, outside nvim):
--   sudo pacman -S tree-sitter-cli   (>= 0.26.1, do NOT use the npm package)
--
-- After updating this file, run :Lazy sync inside nvim, then :TSUpdate.
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ensure_installed = {
			"bash",
			"c",
			"cpp",
			"css",
			"go",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"rust",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		}

		require("nvim-treesitter").install(ensure_installed)

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				local ft = vim.bo[ev.buf].filetype
				local lang = vim.treesitter.language.get_lang(ft)
				if not lang then
					return
				end
				if not pcall(vim.treesitter.language.add, lang) then
					return
				end
				pcall(vim.treesitter.start, ev.buf, lang)
			end,
		})
	end,
}
