local function build_command()
    if vim.fn.has("win32") == 1 then
        return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    end
    return "make"
end

local function get_default_acp_provider()
    if vim.env.AVANTE_ACP_PROVIDER and vim.env.AVANTE_ACP_PROVIDER ~= "" then
        return vim.env.AVANTE_ACP_PROVIDER
    end
    if (vim.env.AVANTE_OPENAI_API_KEY and vim.env.AVANTE_OPENAI_API_KEY ~= "")
        or (vim.env.OPENAI_API_KEY and vim.env.OPENAI_API_KEY ~= "")
        or (vim.env.CODEX_API_KEY and vim.env.CODEX_API_KEY ~= "") then
        return "codex"
    end
    if (vim.env.AVANTE_GEMINI_API_KEY and vim.env.AVANTE_GEMINI_API_KEY ~= "")
        or (vim.env.GEMINI_API_KEY and vim.env.GEMINI_API_KEY ~= "") then
        return "gemini-cli"
    end
    if (vim.env.AVANTE_ANTHROPIC_API_KEY and vim.env.AVANTE_ANTHROPIC_API_KEY ~= "")
        or (vim.env.ANTHROPIC_API_KEY and vim.env.ANTHROPIC_API_KEY ~= "") then
        return "claude-code"
    end
    return "codex"
end

local function switch_avante_provider(include_regular, include_acp)
    local ok_config, config = pcall(require, "avante.config")
    local ok_api, api = pcall(require, "avante.api")
    if not ok_config or not ok_api then
        vim.notify("Avante is not available yet. Run :Lazy sync and restart.", vim.log.levels.WARN)
        return
    end

    local items = {}

    if include_regular then
        for _, name in ipairs(vim.tbl_keys(config.providers or {})) do
            table.insert(items, { name = name, label = name .. " (LLM)" })
        end
    end

    if include_acp then
        for _, name in ipairs(vim.tbl_keys(config.acp_providers or {})) do
            table.insert(items, { name = name, label = name .. " (ACP)" })
        end
    end

    table.sort(items, function(a, b) return a.name < b.name end)

    if #items == 0 then
        vim.notify("No Avante providers are configured.", vim.log.levels.WARN)
        return
    end

    vim.ui.select(items, {
        prompt = "Avante Provider> ",
        format_item = function(item)
            return item.label
        end,
    }, function(choice)
        if choice then
            api.switch_provider(choice.name)
        end
    end)
end

return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = build_command(),
    opts = {
        provider = get_default_acp_provider(),
        mode = "agentic",
        behaviour = {
            auto_approve_tool_permissions = false,
            acp_follow_agent_cursor = true,
        },
        acp_providers = {
            ["claude-code"] = {
                command = "npx",
                args = { "-y", "@zed-industries/claude-code-acp" },
                env = {
                    NODE_NO_WARNINGS = "1",
                    ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY"),
                },
            },
            codex = {
                command = "npx",
                args = { "-y", "@zed-industries/codex-acp" },
                env = {
                    NODE_NO_WARNINGS = "1",
                    CODEX_API_KEY = os.getenv("CODEX_API_KEY"),
                    OPENAI_API_KEY = os.getenv("OPENAI_API_KEY"),
                },
            },
            ["gemini-cli"] = {
                command = "gemini",
                args = { "--experimental-acp" },
                env = {
                    NODE_NO_WARNINGS = "1",
                    GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
                },
            },
        },
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "ibhagwan/fzf-lua",
        "echasnovski/mini.pick",
        "nvim-tree/nvim-web-devicons",
        {
            "zbirenbaum/copilot.lua",
            event = "InsertEnter",
            opts = {
                suggestion = { enabled = false },
                panel = { enabled = false },
            },
        },
        {
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = { insert_mode = true },
                    use_absolute_path = true,
                },
            },
        },
        {
            "MeanderingProgrammer/render-markdown.nvim",
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
    keys = {
        { "<leader>aa", "<cmd>AvanteAsk<cr>",  mode = { "n", "v" }, desc = "Avante Ask" },
        { "<leader>ac", "<cmd>AvanteChat<cr>", mode = { "n", "v" }, desc = "Avante Chat" },
        { "<leader>ae", "<cmd>AvanteEdit<cr>", mode = "v",          desc = "Avante Edit Selection" },
        {
            "<leader>ap",
            function()
                switch_avante_provider(true, true)
            end,
            desc = "Avante Switch Provider",
        },
        {
            "<leader>sp",
            function()
                switch_avante_provider(false, true)
            end,
            desc = "Avante ACP Providers",
        },
        { "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "Avante Refresh" },
    },
}
