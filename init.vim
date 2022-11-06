" Global variables
let $MYVIMRC='~\AppData\Local\nvim\init.vim'
let $LUACONF='~\AppData\Local\nvim\lua\config.lua'
let $PLUGINS='~\AppData\Local\nvim\lua\plugins.lua'
let $STARTUPTHEME='~\AppData\Local\nvim\lua\startup\themes\my_theme.lua'
let g:python3_host_prog = '~\AppData\Local\Programs\Python\Python310\python.EXE'
set termguicolors

" Setting language to NPPONGO
set langmenu=ja_JP
let $LANG = 'ja_JP'
let mapleader = " "
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" PLUGINS and lua configs
lua require("config")

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

" Visual mode
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" Telescope mappings
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" NeoTree
nnoremap <leader>e <cmd>Neotree toggle<cr>
nnoremap <leader>o <cmd>Neotree focus<cr>

" LSP key mappings
let g:lsp_diagnostics_echo_cursor = 1
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD :lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gw :lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gw :lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>so :lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent> [d :lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]d :lua vim.diagnostic.goto_next()<CR>
nnoremap <silent> <leader>d :lua vim.diagnostic.open_float()<CR>
"nnoremap <silent> gt :lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> :lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <leader>af :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>rn :lua vim.lsp.buf.rename()<CR>

" Trouble keybindings
nnoremap <leader>xx <cmd>TroubleToggle<cr>
nnoremap <leader>xw <cmd>TroubleToggle workspace_diagnostics<cr>
nnoremap <leader>xd <cmd>TroubleToggle document_diagnostics<cr>
nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
nnoremap gR <cmd>TroubleToggle lsp_references<cr>

" Barbar keybindings
" Move to previous/next
nnoremap <silent> <A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent> <A-.> <Cmd>BufferNext<CR>
nnoremap <silent> <A-Left> <Cmd>BufferPrevious<CR>
nnoremap <silent> <A-Right> <Cmd>BufferNext<CR>
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
nnoremap <silent> <Space>bb <Cmd>BufferOrderByBufferNumber<CR>
nnoremap <silent> <Space>bd <Cmd>BufferOrderByDirectory<CR>
nnoremap <silent> <Space>bl <Cmd>BufferOrderByLanguage<CR>
nnoremap <silent> <Space>bw <Cmd>BufferOrderByWindowNumber<CR>

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

" Editor preferences
set number relativenumber
set cursorline
set tabstop=4 shiftwidth=4 softtabstop=4 autoindent
set scrolloff=5 sidescrolloff=10
set mouse=a
set nowrap
set list
set listchars+=tab:\|\ 
set encoding=UTF-8
set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType * ColorizerAttachToBuffer
set path+=**
set wildmenu
set wildignore+=**/node_modules/**
set hidden
au BufRead * normal zR
let mapleader = " "
set noshowmode
set signcolumn=yes
" autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll

" Neovide settings
if exists("g:neovide")
    let g:neovide_refresh_rate=165
    let g:neovide_refresh_rate_idle=30
    let g:neovide_remember_window_size=v:true
    hi Normal guibg=#1f1f28
    " hi Normal guibg=#2a2a37
    let g:neovide_confirm_quit=v:false
    set guifont=Fira\ Code:h13
endif

