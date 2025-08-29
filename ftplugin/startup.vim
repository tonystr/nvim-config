setlocal laststatus=0
setlocal noruler
setlocal noshowcmd
setlocal linebreak

setlocal statuscolumn=""

" Errors for some reason when trying to cd
" if getcwd() == 'C:\Program Files\Neovide'
" 	" execute 'cd ' . expand('~/Documents/git')
" 	" cd ~/Documents/git
" endif

nmap <buffer> v <NOP>
nmap <buffer> V <NOP>
nmap <buffer> j <NOP>
nmap <buffer> k <NOP>
nmap <buffer> w <NOP>
nmap <buffer> W <NOP>
nmap <buffer> e <NOP>
nmap <buffer> E <NOP>
nmap <buffer> b <NOP>
nmap <buffer> B <NOP>
nmap <buffer> X <cmd>q!<CR>
nmap <buffer> x <NOP>
nmap <buffer> r <NOP>
nmap <buffer> s <NOP>
nmap <buffer> c <NOP>

nmap <buffer> <C-Space> <cmd>BufferClose<CR><cmd>ChatGPT<CR>
nmap <buffer> <S-Space> <cmd>BufferClose<CR><cmd>ChatGPT<CR>
nmap <buffer> <leader><leader> <cmd>BufferClose<CR><cmd>ChatGPT<CR>
nmap <buffer> p <cmd>Telescope find_files<CR>
nmap <buffer> o <cmd>Oil<CR>
nmap <buffer> i <cmd>Oil<CR>

nmap <buffer> 0 `0
nmap <buffer> 1 `1
nmap <buffer> 2 `2
nmap <buffer> 3 `3
nmap <buffer> 4 `4
nmap <buffer> 5 `5
nmap <buffer> 6 `6
nmap <buffer> 7 `7
nmap <buffer> 8 `8
nmap <buffer> 9 `9
