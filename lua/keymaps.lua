local map = vim.keymap.set
map("n", "<BS>", "dh")
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
map("n", "<Esc>", ":noh<CR>", {silent = true})
map("n", "dir", ":pwd<CR>", { noremap = true, silent = true })

map("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", { desc = "Comment line" })
map(
    "x",
    "<leader>/",
    "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    { desc = "Comment line" }
)
map("n", "<leader>ft", ":Telescope live_grep<CR>", { noremap = true })
map("n", "<C-m>", ":Mason<CR>", { noremap = true })
map("n", "<leader>cl", ":LspInfo<cr>", { desc = "Lsp Info" })
map("n", "K", ":lua vim.lsp.buf.hover()<CR>", { desc = "Hover" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>S", ":BufferLineCyclePrev<cr>", { desc = "Prev buffer", silent = true })
map("n", "<leader>ih", ":lua vim.lsp.inlay_hint.enable(0,nil)<CR>", { desc = "Toggle Inlay Hints", silent = true })
map("n", "	", ":BufferLineCycleNext<cr>", { desc = "Next buffer", silent = true })
map("n", "<leader>bp", ":BufferLinePick<CR>", { desc = "Pick buffers", silent = true })
map("n", "<leader>bm", ":BufferLineMoveNext<CR>", { desc = "Change buffer position", silent = true })
map("n", "<leader>k", ":lua vim.lsp.buf.definition()<CR>", { desc = "Show definition" })
map("n", ":Q", ":q", { noremap = true })
map("n", "<leader>fd", ":lua vim.lsp.buf.format{timeout_ms = 12000}<CR>", { desc = "Format" })
map("n", "p", "P", { noremap = true })
map("n", "yy", "0y$", { noremap = true })
map("n", "<leader>a", "gg0vG$", { desc = "highlight entire document" })
map("n", "<leader>l", ":Lazy<CR>", { desc = "Lazy UI", silent = true})
map("n", "<leader>vs", ":VimGameSnake<CR>", { desc = "Play Vim Snake" })
map("n", "<leader>ss", ":echo g:VimSnakeScore<CR>", { desc = "See Snake score" })
map("n", "<leader>ga", ":G add .<CR>", { desc = "git add your changes", silent = true })
map("n", "<leader>gc", ":G commit<CR>", { desc = "add a commit message" })
map("n", "<leader>gp", ":G push<CR>", { desc = "Push changes to Github" })
map("n", "<C-Left>", "<C-w>>", { desc = "Increasing width" })
map("n", "<C-Right>", "<C-w><", { desc = "Decreasing width" })
map("n", "<C-Up>", "<C-w>+", { desc = "Increasing height" })
map("n", "<C-Down>", "<C-w>-", { desc = "Decreasing height" })
map("n", "<leader>tb", ":Telescope buffers<CR>", { desc = "open buffers", silent = true })
map("n", "<leader>te", ":terminal<CR>starti<CR>", { desc = "open Terminal", silent = true })
map("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, { desc = "Lsp Rename", silent = true, expr = true })
map("n", "<leader>nf", ":Neotree position=float<CR>", { desc = "Floating file view", silent = true })
map("n", "<leader>nc", ":Neotree position=current<CR>", { desc = "Huge file view", silent = true })
-- Define the key mappings
map("n", "<A-1>", ":ToggleTerm direction=horizontal size=20<CR>", { noremap = true, silent = true })
map("n", "<A-2>", ":ToggleTerm direction=vertical size=60<CR>", { noremap = true, silent = true })
map("n", "<A-3>", ":ToggleTerm direction=float<CR>", { noremap = true, silent = true })
map("i", "<C-s>", "<Esc>:w<CR>", { noremap = true, silent = true })
map("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
map("n", "<leader>qa", ":qall<CR>", { desc = "Close Neovim" })
map(
    "n",
    "<leader>of",
    [[<cmd>lua require("fzf-lua").setup({'default'})<CR>:FzfLua oldfiles<CR>]],
    { desc = "Recent Files" }
)
map("n", "<leader>fz", [[<cmd>cd ~<CR>:lua require("fzf-lua").setup({'fzf-vim'})<CR>:Files<CR>]], { desc = "fzf" })
map(
    "n",
    "<leader>ff",
    [[<cmd>lua require('fzf-lua').setup({'default'})<CR>:FzfLua files<CR>]],
    { desc = "search current dir" }
)
map("n", "<leader>wa", ":wqall<CR>", { desc = "Save and exit Neovim" })
map("n", "<leader>tk", ":FzfLua keymaps<CR>", { desc = "Keymaps" })
map("n", "<C-d>", "<C-d>zz", { desc = "half page up" })
map("n", "<C-u>", "<C-u>zz", { desc = "half page down" })
map("n", "<leader>q", ":q<CR>", { desc = "exit", silent = true })
map(
    "n",
    "<leader>fl",
    [[<cmd>lua require("fzf-lua").setup({'default'})<CR>: FzfLua<CR>]],
    { desc = "fzf lua", silent = true }
)
map("n", "<leader>ed", ":Neotree document_symbols right<CR>", { desc = "document symbols", silent = true })
map(
    "n",
    "<leader>fc",
    [[<cmd>lua require("fzf-lua").setup({'default'})<CR>:FzfLua colorschemes<CR>]],
    { desc = "colorschemes", silent = true }
)
-- map("n", "<leader>tf", ":Telescope file_browser<CR>", { desc = "File pick", silent = true })
-- map("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
--     desc = "Search current word",
-- })
-- map("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
--     desc = "Search current word",
-- })
-- map("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
--     desc = "Search on current file",
-- })
map({ "n", "v" }, "<leader>ca", function()
    require("fzf-lua").lsp_code_actions({
        winopts = {
            relative = "cursor",
            width = 0.6,
            height = 0.6,
            row = 1,
            preview = { vertical = "up:50%" },
        },
    })
end, { desc = "Code actions" })

map("n", "<leader>eg", ":Neotree git_status toggle<CR>", { desc = "file git status", noremap = true, silent = true })
map("n", "i", "a")
-- <A means alt
map("n", "<leader>d", ":bw!<CR>", { desc = "delete tab", silent = true })
map("n", "<leader>n", ":New<CR>", { desc = "Create new file", silent = true })
map("n","<leader>nd","<cmd>NoiceDismiss<CR>", {desc = "delete Noice notification", silent = true})
map("n", "<leader>tt", function()
    require("trouble").open()
end, { desc = "Trouble" })
map("n", "<leader>tw", function()
    require("trouble").open("workspace_diagnostics")
end, { desc = "workspace trouble" })
map("n", "<leader>td", function()
    require("trouble").open("document_diagnostics")
end, { desc = "document trouble" })
map("n", "<leader>tq", function()
    require("trouble").open("quickfix")
end, { desc = "quickfix" })
map("n", "<leader>tl", function()
    require("trouble").open("loclist")
end, { desc = "loclist" })
map("n", "gR", function()
    require("trouble").open("lsp_references")
end, { desc = "references" })

-- restore the session for the current directory
map("n", "<leader>ps", [[<cmd>lua require("persistence").load()<cr>]], { desc = "restore session for dir" })

-- restore the last session
map("n", "<leader>pl", [[<cmd>lua require("persistence").load({ last = true })<cr>]], { desc = "restore last session" })

-- stop Persistence => session won't be saved on exit
map("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], { desc = "Don't save session" })
-- Code screenshots
map("x", "<leader>cc", ":CodeSnap<CR>", {desc = "save screenshots to clipboard"})
map("x", "<leader>cs", ":CodeSnapSave<CR>", {desc = "save screenshots to ~/Pictures/Code_screenshots/"})
