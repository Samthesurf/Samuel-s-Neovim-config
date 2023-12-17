return {
    {
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            opts = {},
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
            config = function()
                require("kanagawa").setup({
                    transparent = true,
                    -- terminalColors = false,
                })
                vim.cmd([[colorscheme kanagawa]])
            end,
        },
        {
            "navarasu/onedark.nvim",
            config = function()
                require("onedark").setup({
                    style = "warmer",
                    transparent = true,
                })
            end,
        },
        {
            "CantoroMC/ayu-nvim",
        },
        {
            "arturgoms/moonbow.nvim",
        },
        {
            -- "nvim-pack/nvim-spectre",
        },
        {
            "fynnfluegge/monet.nvim",
            name = "monet",
            config = function()
                require("monet").setup({
                    transparent_background = true,
                })
                -- vim.cmd([[colorscheme monet]])
            end,
        },
        {
            "catppuccin/nvim",
            name = "catppuccin",
            priority = 1000,
            config = function()
                require("catppuccin").setup({ flavour = "macchiato" })
            end,
        },
    },
}
