setlocal laststatus=0
setlocal noruler
setlocal noshowcmd

nmap <buffer> i 1<leader>w<leader>w
nmap <buffer> a 2<leader>w<leader>w
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
nmap <buffer> c <NOP>

nmap <buffer> <C-Space> <cmd>BufferClose<CR><cmd>ChatGPT<CR>
nmap <buffer> <S-Space> <cmd>BufferClose<CR><cmd>ChatGPT<CR>
nmap <buffer> <leader><leader> <cmd>BufferClose<CR><cmd>ChatGPT<CR>
