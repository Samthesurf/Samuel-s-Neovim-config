return {
    "goolord/alpha-nvim",
    config = function()
        local dashboard = require("alpha.themes.dashboard")
        local logo = [[
  ██████  ▄▄▄      ███▄ ▄███▓ █    ██  ▓█████  ██▓         ██████  █    ██  ██▀███   ▒ ████▒
▒██    ▒ ▒████▄   ▓██▒▀█▀ ██▒ ██  ▓██▒ ▓█   ▀ ▓██▒       ▒██    ▒  ██  ▓██▒▓██ ▒ ██▒▒▓██    
░ ▓██▄   ▒██  ▀█▄ ▓██    ▓██░▓██  ▒██░ ▒███   ▒██░       ░ ▓██▄   ▓██  ▒██░▓██ ░▄█ ▒░▒████  
  ▒   ██▒░██▄▄▄▄██▒██    ▒██ ▓▓█  ░██░ ▒▓█  ▄ ▒██░         ▒   ██▒▓▓█  ░██░▒██▀▀█▄  ░░▓█▒   
▒██████▒▒▒▓█   ▓██▒██▒   ░██▒▒▒█████▓ ▒░▒████▒░██████    ▒██████▒▒▒▒█████▓ ░██▓ ▒██▒ ░▒█░ ࿐w࿐a࿐v࿐e࿐s࿐
▒ ▒▓▒ ▒ ░░▒▒   ▓▒█░ ▒░   ░  ░░▒▓▒ ▒ ▒ ░░░ ▒░ ░░ ▒░▓      ▒ ▒▓▒ ▒ ░░▒▓▒ ▒ ▒ ░ ▒▓ ░▒▓░  ▒ ░   
░ ░▒  ░  ░ ░   ▒▒ ░  ░      ░░░▒░ ░ ░ ░ ░ ░  ░░ ░ ▒      ░ ░▒  ░  ░░▒░ ░ ░   ░▒ ░ ▒   ░    ]]
        local footer = [[
 ______ (ง ͠° ͟ل͜ ͡°)ง╚(ಠ_ಠ)=┐ '''⌐(ಠ۾ಠ)¬''' ᕙ(⇀‸↼‶)ᕗ (︶︹︺) ( ͡ಠ ͜ʖ ͡ಠ) ಠ_ಠ¯ \_(ツ)_/¯  ______
            ]]
        dashboard.section.header.val = vim.split(logo, "\n")
        dashboard.section.footer.val = vim.split(footer, "\n")
        -- stylua: ignore
        dashboard.section.buttons.val = {
            dashboard.button("f", " " .. " Find file",
                "<cmd>FzfLua files<cr>"),
            dashboard.button("n", " " .. " New file", "<cmd>enew<cr>"),
            dashboard.button("b", " " .. " Folder browser", "<cmd>Yazi<cr>"),
            dashboard.button("r", " " .. " Recent files", "<cmd>FzfLua oldfiles<cr>"),
            dashboard.button("g", " " .. " Find text", "<cmd>FzfLua live_grep<cr>"),
            dashboard.button("c", " " .. " Config", "<cmd> e $MYVIMRC <cr>"),
            dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
            dashboard.button("p", "󰡦 ".. " Plugin Search", '<Cmd>lua require"activate".list_plugins()<CR>'),
            dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
            dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
        }
        require("alpha").setup(dashboard.opts)
    end,
}
