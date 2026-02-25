return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local has_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
			if has_cmp_lsp then
				capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
			end
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			local function setup(server, config)
				vim.lsp.config(server, config or {})
				vim.lsp.enable(server)
			end

			for _, server in ipairs({
				"ruff",
				"bashls",
				"emmet_language_server",
				"cssls",
				"gopls",
				"ts_ls",
				"jsonls",
				"biome",
				"jdtls",
			}) do
				setup(server, { capabilities = capabilities })
			end

			setup("pyright", {
				capabilities = capabilities,
				settings = {
					pyright = {
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							diagnosticMode = "openFilesOnly",
						},
					},
				},
			})

			setup("html", {
				capabilities = capabilities,
			})

			setup("clangd", {
				capabilities = capabilities,
				cmd = { "clangd", "--clang-tidy" },
				filetypes = { "c", "cpp" },
				root_markers = { "compile_commands.json", ".git" },
			})

			setup("lua_ls", {
				capabilities = capabilities,
				settings = {
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
				},
			})

			setup("powershell_es", {
				capabilities = capabilities,
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

			setup("asm_lsp", {
				capabilities = capabilities,
				root_markers = { ".asm-lsp.toml", ".git" },
			})
		end,
	},
}
