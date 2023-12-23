-- on save current directory for the buffer becomes the directory for Neovim
vim.cmd([[au BufWritePre * cd %:p:h]])
--Running code lol
-- NOTE: If clangd or clang doesn't work as intended, do the following
-- 1) for Linux: clang -v, check the location of GCC it's checking to run, then do sudo apt install libstdc++-12-dev if the gcc version is 12 or 13 if the version is 13
-- 2) for Windows, use the visual studio installer and install clang instead of other sources, and then add clang to path in environment variables
-- vim.cmd([[
-- augroup exe_code
--     autocmd!
--     autocmd FileType python noremap <buffer> <F5>
--     	\ :sp<CR>:term python3 %<CR> i
--     autocmd FileType cpp noremap <buffer> <F5>
--     \ :sp<CR>:term clang++ % -o %:r;%:r<CR> i
--     autocmd FileType c noremap <buffer> <F5>
--     \ :sp<CR>:term clang % -o %:r;%:r<CR> i
-- augroup END
-- ]])
-- Time to improve the code running experience lol
vim.cmd([[
augroup exe_code
    autocmd!
    autocmd FileType python noremap <buffer> <F4>
    	\ :TermExec cmd="python3 %" size=20<CR>:wincmd j<CR>:starti<CR>
    autocmd FileType cpp noremap <buffer> <F4>
    \ :w<CR>:TermExec cmd="clang++ % -o %:r;./%:r" direction=float <CR>
    autocmd FileType c noremap <buffer> <F4>
    \ :w<CR>:TermExec cmd="clang % -o %:r;./%:r" direction=float <CR>
augroup END
]])
vim.cmd([[au BufEnter * :ColorizerToggle]])
-- Format Python files on save
vim.cmd([[au BufWritePre *.py :lua vim.lsp.buf.format{timeout_ms = 10000}]])
-- Format Lua files on save
-- vim.cmd([[au BufWritePre *.lua :lua vim.lsp.buf.format{timeout_ms = 10000}]])
