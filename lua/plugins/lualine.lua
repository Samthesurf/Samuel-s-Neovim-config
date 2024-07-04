local colors = require("catppuccin.palettes").get_palette "macchiato"

local modecolor = {
    n = colors.red,
    i = colors.cyan,
    v = colors.purple,
    V = colors.red,
    c = colors.yellow,
    no = colors.red,
    s = colors.yellow,
    S = colors.yellow,
    ic = colors.yellow,
    R = colors.green,
    Rv = colors.purple,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ["r?"] = colors.cyan,
    ["!"] = colors.red,
    t = colors.bright_red,
}

local theme = {
    normal = {
        a = { fg = colors.bg_dark, bg = colors.blue },
        b = { fg = colors.blue, bg = colors.white },
        c = { fg = colors.white, bg = colors.bg_dark },
        z = { fg = colors.white, bg = colors.bg_dark },
    },
    insert = { a = { fg = colors.bg_dark, bg = colors.orange } },
    visual = { a = { fg = colors.bg_dark, bg = colors.green } },
    replace = { a = { fg = colors.bg_dark, bg = colors.green } },
}

local space = {
    function()
        return " "
    end,
    color = { bg = colors.bg_dark, fg = colors.blue },
}

local filename = {
    "filename",
    color = { bg = colors.blue, fg = colors.bg, gui = "bold" },
    separator = { left = "", right = "" },
}

local filetype = {
    "filetype",
    icons_enabled = false,
    color = { bg = colors.gray2, fg = colors.blue, gui = "italic,bold" },
    separator = { left = "", right = "" },
}

local branch = {
    "branch",
    icon = "",
    color = { bg = colors.green, fg = colors.bg, gui = "bold" },
    separator = { left = "", right = "" },
}

local location = {
    "location",
    color = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
    separator = { left = "", right = "" },
}

local diff = {
    "diff",
    color = { bg = colors.gray2, fg = colors.bg, gui = "bold" },
    separator = { left = "", right = "" },
    symbols = { added = " ", modified = " ", removed = " " },

    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.yellow },
        removed = { fg = colors.red },
    },
}

local modes = {
    "mode",
    color = function()
        local mode_color = modecolor
        return { bg = mode_color[vim.fn.mode()], fg = colors.bg_dark, gui = "bold" }
    end,
    separator = { left = "", right = "" },
}

local function getLspName()
    local buf_clients = vim.lsp.buf_get_clients()
    local buf_ft = vim.bo.filetype
    if next(buf_clients) == nil then
        return "  No servers"
    end
    local buf_client_names = {}

    for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
            table.insert(buf_client_names, client.name)
        end
    end

       local hash = {}
    local unique_client_names = {}

    for _, v in ipairs(buf_client_names) do
        if not hash[v] then
            unique_client_names[#unique_client_names + 1] = v
            hash[v] = true
        end
    end
    local language_servers = table.concat(unique_client_names, ", ")

    return "  " .. language_servers
end

local dia = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = " ", warn = " ", info = " ", hint = " " },
    diagnostics_color = {
        error = { fg = colors.red },
        warn = { fg = colors.yellow },
        info = { fg = colors.purple },
        hint = { fg = colors.cyan },
    },
    color = { bg = colors.gray2, fg = colors.blue, gui = "bold" },
    separator = { left = "" },
}

local lspf = {
    function()
        return getLspName()
    end,
    separator = { left = "", right = "" },
    color = { bg = colors.purple, fg = colors.bg, gui = "italic,bold" },
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
				theme = "tokyonight",
				globalstatus = true,
				--separator = { left = '', right = '' }, right_padding = 2
			},
			sections = {
				lualine_a = {
					{ "mode", separator = { left = "", right = "" }, right_padding = 2 },
				},
				lualine_c = {"filename"},
				lualine_x = {lspf, surfer, filetype},
				lualine_z = {
					{ "location", separator = { left = "", right = "" }, left_padding = 2 },
				},
			},
		})
	end,
}
