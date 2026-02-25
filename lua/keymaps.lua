local map = vim.keymap.set

local function get_codesnap_config()
	local ok_cfg_mod, cfg_mod = pcall(require, "codesnap.config")
	if not ok_cfg_mod then
		vim.notify("CodeSnap: config module is not available", vim.log.levels.ERROR)
		return nil
	end

	local ok_cfg, cfg = pcall(cfg_mod.get_config)
	if not ok_cfg then
		vim.notify("CodeSnap: " .. tostring(cfg), vim.log.levels.ERROR)
		return nil
	end

	return cfg
end

local function codesnap_default_output_dir()
	return vim.fn.expand("~/Pictures/Code_screenshots")
end

local function codesnap_filename(ext)
	return string.format("codesnap-%s.%s", os.date("%Y%m%d-%H%M%S"), ext)
end

local function normalize_codesnap_path(raw_path)
	local output_dir = codesnap_default_output_dir()
	local ok_mkdir, mkdir_err = pcall(vim.fn.mkdir, output_dir, "p")
	if not ok_mkdir then
		vim.notify("CodeSnap: failed to create output dir: " .. tostring(mkdir_err), vim.log.levels.ERROR)
		return nil
	end

	local arg = vim.trim(raw_path or "")
	local save_path = arg ~= "" and vim.fn.expand(arg) or (output_dir .. "/" .. codesnap_filename("png"))
	local has_ext = save_path:match("%.[^/\\]+$") ~= nil
	local is_dir = vim.fn.isdirectory(save_path) == 1 or save_path:sub(-1) == "/"

	if is_dir then
		save_path = vim.fn.fnamemodify(save_path, ":p") .. codesnap_filename("png")
	elseif not has_ext then
		save_path = save_path .. ".png"
	end

	local parent_dir = vim.fn.fnamemodify(save_path, ":h")
	local ok_parent, parent_err = pcall(vim.fn.mkdir, parent_dir, "p")
	if not ok_parent then
		vim.notify("CodeSnap: failed to create parent dir: " .. tostring(parent_err), vim.log.levels.ERROR)
		return nil
	end

	return save_path
end

local function codesnap_save_with_fallback(save_path)
	local ok_codesnap, codesnap = pcall(require, "codesnap")
	if not ok_codesnap then
		return false, "plugin is not available"
	end

	local ok_save, save_err = pcall(codesnap.save, save_path)
	if ok_save then
		vim.cmd("delmarks <>")
		return true
	end

	-- Work around save() bug in some CodeSnap versions without patching plugin files.
	local cfg = get_codesnap_config()
	if cfg == nil then
		return false, "failed to load codesnap config"
	end

	local ok_module, codesnap_module = pcall(require, "codesnap.module")
	if not ok_module then
		return false, "cannot load module"
	end

	local ok_gen, generator = pcall(codesnap_module.load_generator)
	if not ok_gen then
		return false, "cannot load generator"
	end

	if type(generator.save) == "function" then
		ok_save, save_err = pcall(generator.save, save_path, cfg)
	elseif type(generator.save_snapshot) == "function" then
		cfg.save_path = save_path
		ok_save, save_err = pcall(generator.save_snapshot, cfg)
	else
		ok_save = false
		save_err = "no compatible save function found"
	end

	if not ok_save then
		return false, save_err
	end

	vim.cmd("delmarks <>")
	return true
end

local function save_codesnap_file(raw_path)
	local save_path = normalize_codesnap_path(raw_path)
	if save_path == nil then
		return
	end

	local ok_save, save_err = codesnap_save_with_fallback(save_path)
	if not ok_save then
		vim.notify("CodeSnap save failed: " .. tostring(save_err), vim.log.levels.ERROR)
		return
	end

	vim.notify("CodeSnap saved: " .. save_path)
end

local function copy_codesnap_clipboard()
	local temp_path = vim.fn.tempname() .. ".png"
	local ok_save, save_err = codesnap_save_with_fallback(temp_path)
	if not ok_save then
		vim.notify("CodeSnap copy failed: " .. tostring(save_err), vim.log.levels.ERROR)
		return
	end

	local escaped_path = vim.fn.shellescape(temp_path)
	local clipboard_cmd = nil

	if vim.fn.executable("wl-copy") == 1 then
		clipboard_cmd = "wl-copy --type image/png < " .. escaped_path
	elseif vim.fn.executable("xclip") == 1 then
		clipboard_cmd = "xclip -selection clipboard -t image/png -i < " .. escaped_path
	elseif vim.fn.executable("xsel") == 1 then
		clipboard_cmd = "xsel --clipboard --input < " .. escaped_path
	end

	if clipboard_cmd == nil then
		vim.notify("CodeSnap copy failed: no clipboard tool found", vim.log.levels.ERROR)
		return
	end

	local job_id = vim.fn.jobstart({ "sh", "-c", clipboard_cmd }, { detach = true })
	if job_id <= 0 then
		vim.notify("CodeSnap copy failed: could not start clipboard process", vim.log.levels.ERROR)
		return
	end

	vim.defer_fn(function()
		pcall(vim.fn.delete, temp_path)
	end, 10000)

	vim.notify("CodeSnap copied to clipboard")
end

pcall(vim.api.nvim_del_user_command, "CodeSnap")
vim.api.nvim_create_user_command("CodeSnap", function()
	copy_codesnap_clipboard()
end, {
	range = true,
	desc = "Take snapshot and copy to clipboard",
})

pcall(vim.api.nvim_del_user_command, "CodeSnapSave")
vim.api.nvim_create_user_command("CodeSnapSave", function(opts)
	save_codesnap_file(opts.args)
end, {
	nargs = "?",
	complete = "file",
	range = true,
	desc = "Save snapshot to file or directory",
})

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
map("n", "K", function()
    local ok, hover = pcall(require, "hover")
    if ok then
        hover.open()
        return
    end
    vim.lsp.buf.hover()
end, { desc = "Hover" })
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
map("n", "<leader>n", ":enew<CR>", { desc = "Create new file", silent = true })
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
map("x", "<leader>cc", copy_codesnap_clipboard, {desc = "save screenshots to clipboard"})
map("x", "<leader>cs", save_codesnap_file, {desc = "save screenshots to ~/Pictures/Code_screenshots/"})
