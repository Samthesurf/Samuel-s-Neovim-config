return {
	{
		"neovim/nvim-lspconfig",
		-- event = "BufReadPre",
		config = function()
			local nvim_lsp = require("lspconfig")
			nvim_lsp.pyright.setup({
				python = {
					analysis = {
						"openFilesOnly",
					},
				},
			})
			local servers = { "bashls", "emmet_language_server", "cssls", "tsserver", "jsonls", "ruff_lsp", "biome","jdtls" }
			for _, lsp in ipairs(servers) do
				nvim_lsp[lsp].setup({})
			end
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
			-- nvim_lsp.java_language_server.setup({
			-- 	cmd = {
			-- 		"/home/samuelsurf/.local/share/nvim/mason/packages/java-language-server/dist/lang_server_linux.sh",
			-- 	},
			-- 	root_dir = {
			-- 		vim.fn.getcwd(),
			-- 	},
			-- })
		end,
	},
}
