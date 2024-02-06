return {
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstallAll", "MasonInstall" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
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
			require("java").setup()
			local mason_lspconfig = require("mason-lspconfig")

			local mason_tool_installer = require("mason-tool-installer")
			mason_lspconfig.setup({
				automatic_installation = true,
			})
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			mason_tool_installer.setup({
				ensure_installed = {
					"openjdk-17",
				},
			})
			vim.api.nvim_create_user_command("MasonInstallAll", function()
				vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
			end, {})
		end,
	},
}
