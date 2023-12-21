return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("bufferline").setup({
            options = {
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { "close" },
                },
                diagnostics = "nvim_lsp",
                diagnostics_indicator = function(count, level)
                    local icon = level:match("error") and " " or ""
                    return " " .. icon .. " " .. count
                end,
                separator_style = "slant",
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
    end,
}
