
" Key mappings
nmap <Space> <nop>
nmap <leader>of <cmd>call File_manager()<CR>
nmap <leader>ot <cmd>silent !wt -d %:h<CR>
nmap <leader>oT <cmd>silent !wt -d .<CR>
nmap <C-t> <cmd>tabnew<CR>
nmap gt <cmd>tabn<CR>
nmap gT <cmd>tabp<CR>
nmap <C-l> <cmd>nohlsearch<CR>
nmap <Esc> <cmd>nohlsearch<CR>
nmap <C-z> <Nop>

nmap <C-s> <cmd>w<CR>
imap <C-s> <Esc><cmd>w<CR>

imap <C-Backspace> <C-w>
cmap <C-Backspace> <C-w>

imap <S-Enter> <Enter><Up>
nmap <C-c> <Esc>
" nmap / <Esc>/\\v
nmap <C-/> <Esc>/
nmap <leader>fm '<cmd>%!prettierd %<CR>' -- vim.lsp.buf.format
nmap <leader>S ':%so<CR>' -- vim.lsp.buf.format
tmap <Esc> <C-\\><C-n>
nmap { { '<cmd>keepjump normal! {<CR>', noremap = true }
nmap } { '<cmd>keepjump normal! }<CR>', noremap = true }
nmap <leader>br <cmd>echo "test"<CR>
omap { V{
omap } V}
nmap <leader>G <cmd>Git<CR>

vmap I <C-q>I
vmap A <C-q>A

nmap gA g$bEa
nmap gI g^i

nmap g? <cmd>let @/ = "\\\\<n\\\\>"<CR>N
nmap g/ <cmd>let @/ = "\\\\<n\\\\>"<CR>n

" Quickfix list
nmap ]q <cmd>cnext<CR>
nmap [q <cmd>cprev<CR>
nmap ]Q <cmd>cfirst<CR>
nmap [Q <cmd>clast<CR>

nmap ]l <cmd>lnext<CR>
nmap [l <cmd>lprev<CR>
nmap ]L <cmd>lfirst<CR>
nmap [L <cmd>llast<CR>

" nmap n nzzzv
" nmap N Nzzzv
" Repeat over multiple lines
vmap . { ':norm .<CR>', noremap = true }

" nmap zR function() require'ufo'.openAllFolds() end
" nmap zM function() require'ufo'.closeAllFolds() end

" Vue navigation

nmap <leader>H <cmd>silent! g/^<script/<CR>jzt<cmd>nohlsearch<CR>
nmap <leader>M <cmd>silent! g/^<template/<CR>jzt<cmd>nohlsearch<CR>
nmap <leader>L <cmd>silent! g/^<style/<CR>jzt<cmd>nohlsearch<CR>

" treesj splitjoin
" nmap <Enter> function() require'treesj'.toggle() end
" " nmap gS function() require'treesj'.split() end
" " nmap gJ function() require'treesj'.join() end

" Execute macro over visual range  TODO: lua implementation
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
	echo "@".getcmdline()
	execute ":'<,'>normal @".nr2char(getchar())
endfunction

" local change_scale_factor = function(delta)
" 	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
" end
"
" vim.keymap.set('n', '<C-=>', function() change_scale_factor(1.10) end)
" vim.keymap.set('n', '<C-->', function() change_scale_factor(1 / 1.10) end)

" Telescope mappings
nmap <leader>ff <cmd>Telescope resume<cr>
nmap <leader>fj <cmd>Telescope jumplist<cr>
nmap <C-p> <cmd>Telescope find_files<cr>
nmap <leader>fo <cmd>Telescope oldfiles<cr>
nmap <leader>fg <cmd>Telescope live_grep<cr>
nmap <leader>fb <cmd>Telescope buffers<cr>
nmap <leader>fh <cmd>Telescope help_tags<cr>
nmap <leader>fr <cmd>Telescope registers<cr>
nmap <leader>fs <cmd>Telescope spell_suggest<cr>
nmap <leader>fd <cmd>Telescope diagnostics<cr>
nmap <leader>fu <cmd>Telescope undo<cr>
nmap <leader>gr <cmd>Telescope repo list<cr>
nmap <leader>ft <cmd>TodoTelescope<cr>
" nmap <leader>so function() require("telescope.builtin").lsp_document_symbols() end
nmap gr <cmd>Telescope lsp_references<cr>
" nmap gR function() vim.lsp.buf.references() end
" Git commands
nmap <leader>gs <cmd>Telescope git_status<cr>
nmap <leader>gc <cmd>Telescope git_commits<cr>
nmap <leader>gC <cmd>Telescope git_bcommits<cr>
nmap <leader>gb <cmd>Telescope git_branches<cr>
nmap <leader>gB <cmd>GitBlameToggle<cr>

" LSP key mappings
nmap <leader>lr <cmd>LspRestart<cr>
" nmap gd function() vim.lsp.buf.definition() end
" nmap gD function() vim.lsp.buf.declaration() end
" nmap gi function() vim.lsp.buf.implementation() end
" " nmap <leader>w function() vim.lsp.buf.document_symbol() end
" " nmap <leader>w function() vim.lsp.buf.workspace_symbol() end
" nmap [d function() vim.diagnostic.goto_prev() end
" nmap ]d function() vim.diagnostic.goto_next() end
" nmap <leader>d function() vim.diagnostic.open_float() end
" nmap gt function() vim.lsp.buf.type_definition() end
" nmap K function() vim.lsp.buf.hover() end
" nmap gl function() print('hello world') end
" nmap <C-k> function() vim.lsp.buf.signature_help() end
" nmap <leader>af function() vim.lsp.buf.code_action() end
" vmap <leader>af function() vim.lsp.buf.code_action() end
" nmap <leader>rn function() vim.lsp.buf.rename() end

" Emmet bindings
nmap <C-h> <Plug>(emmet-expand-abbr)
imap <C-h> <Plug>(emmet-expand-abbr)
nmap <C-y> <Plug>(emmet-expand-yank)
imap <C-y> <Plug>(emmet-expand-yank)

" Visual mode
vmap < <gv
vmap > >gv

" Barbar keybindings
" Move to previous/next
nmap <A-,> <Cmd>BufferPrevious<CR>
nmap <A-.> <Cmd>BufferNext<CR>
nmap <A-Left> <Cmd>BufferPrevious<CR>
nmap <A-Right> <Cmd>BufferNext<CR>
" Move between windows
nmap <A-h> <Cmd>wincmd h<CR>
nmap <A-j> <Cmd>wincmd j<CR>
nmap <A-k> <Cmd>wincmd k<CR>
nmap <A-l> <Cmd>wincmd l<CR>
" Re-order to previous/next
nmap <A-<> <Cmd>BufferMovePrevious<CR>
nmap <A->> <Cmd>BufferMoveNext<CR>
" Goto buffer in position...
nmap <A-1> <Cmd>BufferGoto 1<CR>
nmap <A-2> <Cmd>BufferGoto 2<CR>
nmap <A-3> <Cmd>BufferGoto 3<CR>
nmap <A-4> <Cmd>BufferGoto 4<CR>
nmap <A-5> <Cmd>BufferGoto 5<CR>
nmap <A-6> <Cmd>BufferGoto 6<CR>
nmap <A-7> <Cmd>BufferGoto 7<CR>
nmap <A-8> <Cmd>BufferGoto 8<CR>
nmap <A-9> <Cmd>BufferGoto 9<CR>
nmap <A-0> <Cmd>BufferLast<CR>
" Pin/unpin buffer
" nmap <A-p> <Cmd>BufferPin<CR>
" Close buffer
nmap <A-w> <Cmd>BufferDelete<CR>
nmap <A-W> <Cmd>BufferWipeout<CR>
nmap <A-o> <C-w>o<Cmd>BufferCloseAllButCurrent<CR>
nmap <A-e> <Cmd>BufferDelete #<CR>
nmap <A-r> <Cmd>BufferRestore<CR>
nmap <A-s> <C-w>s
" Sort automatically by...
" nmap <leader>bb <Cmd>BufferOrderByBufferNumber<CR>
" nmap <leader>bd <Cmd>BufferOrderByDirectory<CR>
" nmap <leader>bl <Cmd>BufferOrderByLanguage<CR>
" nmap <leader>bw <Cmd>BufferOrderByWindowNumber<CR>

" Git hunks
" vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
" vim.keymap.set({'o', 'x'}, 'ah', ':<C-U>Gitsigns select_hunk<CR>')

nmap <C-v> <cmd>pu +<CR>=\'[\']^
nmap <leader><C-v> <cmd>-1pu +<CR>=\'[\']^
vmap <C-v> "+p=\'[\']^
imap <C-v> <C-r>+
cmap <C-v> <C-r>+

nmap <leader>p <cmd>pu<CR>=\'[\']^
nmap <leader>P <cmd>-1pu<CR>=\'[^
