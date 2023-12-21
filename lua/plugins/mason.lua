return {
	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		opts = function()
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
				"codelldb",
			}
			return ensure_installed
		end,
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			vim.api.nvim_create_user_command("MasonInstallAll", function()
				vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
			end, {})
		end,
	},
}
