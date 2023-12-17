local function lspinfo()
    local msg = "No Active Lsp"
    local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
        return msg
    end
    local active_clients = {}
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            table.insert(active_clients, client.name)
        end
    end
    if #active_clients > 0 then
        return table.concat(active_clients, ", ")
    else
        return msg
    end
end

local lspinfo_component = {
    function()
        return lspinfo()
    end,
    icon = " LSP:",
    color = { fg = "#87ceeb", gui = "bold" },
}
local function surfer()
    return [[SamuelSurf]]
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                section_separators = { left = "", right = "" },
                component_separators = "|",
                theme = "moonbow",
                globalstatus = true,
                --separator = { left = '', right = '' }, right_padding = 2
            },
            sections = {
                lualine_a = {
                    { "mode", separator = { left = "", right = "" }, right_padding = 2 },
                },
                lualine_c = { "filename" },
                lualine_x = { lspinfo_component, surfer, "filetype" },
                lualine_z = {
                    { "location", separator = { left = "", right = "" }, left_padding = 2 },
                },
            },
        })
    end,
}
