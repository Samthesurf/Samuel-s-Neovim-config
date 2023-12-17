return {
    {
        {
            "neovim/nvim-lspconfig",
            config = function()
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
                nvim_lsp.tsserver.setup({})
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
            end,
        },
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
            config = function(_, opts)
                -- require("mason").setup(opts)
                vim.api.nvim_create_user_command("MasonInstallAll", function()
                    vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
                end, {})
            end,
        },
    },
}
