
-- PLUGINS and lua configs
require'config'

vim.g.mapleader = ' '
vim.g.python3_host_prog = '~/AppData/Local/Programs/Python/Python310/python.EXE'

-- Editor preferences
vim.o.termguicolors = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.autoindent = true
vim.o.scrolloff = 5
vim.o.sidescrolloff = 10
vim.o.mouse = 'a'
vim.o.wrap = false -- Instead of nowrap
vim.o.encoding = 'UTF-8'
vim.o.formatoptions = 'qlj'
vim.o.path = vim.o.path .. '**'
vim.o.wildmenu = true
vim.o.wildignore = '**/node_modules/**'
vim.o.hidden = true
vim.o.noshowmode = true
vim.o.signcolumn = 'yes' -- Always show gutter
vim.o.ignorecase = true -- Ignore case when searching
vim.o.smartcase = true -- Case sensitive if caps or "\C"
vim.o.undofile = true -- Enable undo history

-- Hack for setting formatoptions
vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    command = 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o',
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    command = 'ColorizerAttachToBuffer',
})

vim.cmd([[

" Global variables
let $MYVIMRC='~\AppData\Local\nvim\init.lua'
let $INIT='~\AppData\Local\nvim\init.lua'
let $LUACONF='~\AppData\Local\nvim\lua\config.lua'
let $ENV='~\AppData\Local\nvim\lua\env.lua'
let $PLUGINS='~\AppData\Local\nvim\lua\plugins.lua'
let $STARTUPTHEME='~\AppData\Local\nvim\lua\startup\themes\my_theme.lua'

" Open explorer where current file is located
func! File_manager() abort
    if has("win32")
        if exists("b:netrw_curdir")
            let path = substitute(b:netrw_curdir, "/", "\\", "g")
        elseif expand("%:p") == ""
            let path = expand("%:p:h")
        else
            let path = expand("%:p")
        endif
        silent exe '!start explorer.exe /select,' .. path
    else
        echomsg "Not yet implemented!"
    endif
endfunc

" Key mappings
noremap <silent> <C-s> <Esc>:w<CR>
nnoremap <silent> gof :call File_manager()<CR>
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> gt :tabn<CR>
nnoremap <silent> gT :tabp<CR>
nnoremap <silent> <C-l> :nohlsearch<CR>
nnoremap <silent> <C-z> <Nop>
imap <C-c> <Esc>
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Emmet bindings
inoremap <C-h> <Plug>(emmet-expand-abbr)
nnoremap <C-h> <Plug>(emmet-expand-abbr)

" Visual mode
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" Telescope mappings
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fr <cmd>Telescope registers<cr>
nnoremap <leader>fs <cmd>Telescope spell_suggest<cr>
nnoremap <leader>fd <cmd>Telescope diagnostics<cr>
nnoremap <leader>so :lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <silent> gr <cmd>Telescope lsp_references<cr>
nnoremap <silent> gR :lua vim.lsp.buf.references()<CR>
" Git commands
nnoremap <leader>gs <cmd>Telescope git_status<cr>
nnoremap <leader>gc <cmd>Telescope git_commits<cr>
nnoremap <leader>gbc <cmd>Telescope git_bcommits<cr>
nnoremap <leader>gbr <cmd>Telescope git_branches<cr>
nnoremap <leader>gbl :GitBlameToggle<cr>

" NeoTree
nnoremap <leader>e <cmd>Neotree toggle<cr>
nnoremap <leader>o <cmd>Neotree focus<cr>

" LSP key mappings
let g:lsp_diagnostics_echo_cursor = 1
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD :lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>w :lua vim.lsp.buf.document_symbol()<CR>
nnoremap <leader>w :lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> [d :lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d :lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>d :lua vim.diagnostic.open_float()<CR>
"nnoremap <silent> gt :lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> :lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>af :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>rn :lua vim.lsp.buf.rename()<CR>

" Barbar keybindings
" Move to previous/next
nnoremap <silent> <A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent> <A-.> <Cmd>BufferNext<CR>
nnoremap <silent> <A-Left> <Cmd>BufferPrevious<CR>
nnoremap <silent> <A-Right> <Cmd>BufferNext<CR>
" Move between windows
nnoremap <silent> <A-h> <Cmd>wincmd h<CR>
nnoremap <silent> <A-j> <Cmd>wincmd j<CR>
nnoremap <silent> <A-k> <Cmd>wincmd k<CR>
nnoremap <silent> <A-l> <Cmd>wincmd l<CR>
" Re-order to previous/next
nnoremap <silent> <A-<> <Cmd>BufferMovePrevious<CR>
nnoremap <silent> <A->> <Cmd>BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent> <A-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent> <A-2> <Cmd>BufferGoto 2<CR>
nnoremap <silent> <A-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent> <A-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent> <A-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent> <A-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent> <A-7> <Cmd>BufferGoto 7<CR>
nnoremap <silent> <A-8> <Cmd>BufferGoto 8<CR>
nnoremap <silent> <A-9> <Cmd>BufferGoto 9<CR>
nnoremap <silent> <A-0> <Cmd>BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent> <A-p> <Cmd>BufferPin<CR>
" Close buffer
nnoremap <silent> <A-w> <Cmd>BufferClose<CR>
" Sort automatically by...
nnoremap <silent> <leader>bb <Cmd>BufferOrderByBufferNumber<CR>
nnoremap <silent> <leader>bd <Cmd>BufferOrderByDirectory<CR>
nnoremap <silent> <leader>bl <Cmd>BufferOrderByLanguage<CR>
nnoremap <silent> <leader>bw <Cmd>BufferOrderByWindowNumber<CR>

" Objectively correct clipboard mappings (thx: https://ezhik.me/blog/vim-clipboard/)
set clipboard=
nnoremap <C-v> "+p
vnoremap <C-v> "+p
inoremap <C-v> <C-r>+
noremap ""y ""y
noremap ""yy ""yy
noremap ""p ""p
noremap ""P ""P
noremap <expr> y (v:register ==# '"' ? '"+' : '') . 'y'
noremap <expr> yy (v:register ==# '"' ? '"+' : '') . 'yy'

" Tony's special highlighting based on kanagawa
colors kanagawa
hi Normal ctermbg=none guibg=none
hi LineNr ctermbg=none
hi LineNr ctermfg=darkgrey
hi clear CursorLine
hi clear CursorLineNR
hi CursorLineNR ctermfg=yellow
hi EndOfBuffer ctermfg=black
hi Comment guifg=#666677
hi Whitespace guifg=#4a4a58
hi VertSplit ctermbg=none guibg=none guifg=#4a4a58
" hi StatusLine cterm=none ctermbg=none guibg=none guifg=#4e5579
" hi StatusLineNC cterm=none ctermbg=none guibg=none guifg=#4e5579
hi Folded ctermbg=none ctermfg=yellow guibg=none
hi SignColumn ctermbg=none guibg=none
hi Search guibg=#3c66f2 guifg=#ffffff
hi IncSearch guibg=#40b266 guifg=#ffffff
hi BufferCurrentMod guifg=#cfcfd0
hi BufferInactiveMod guifg=#888888
hi BufferVisibleMod guifg=#888888
hi DiagnosticWarn guifg=#ffcb6b
hi TelescopeBorder guibg=none
hi TelescopeSelection guibg=none guifg=#ffffff
hi MoreMsg guibg=none guifg=#ffd282
hi illuminatedWord guibg=#33333a
hi Statement cterm=nocombine gui=nocombine
hi VueComponentName guifg=#ffcb6b

" Neovide settings
if exists("g:neovide")
    let g:neovide_refresh_rate=60
    let g:neovide_refresh_rate_idle=30
    let g:neovide_remember_window_size=v:true
    hi Normal guibg=#1f1f28
    " hi Normal guibg=#2a2a37
    let g:neovide_confirm_quit=v:false
    set guifont=FiraCode\ Nerd\ Font\ Mono:h11.5
endif
]])

