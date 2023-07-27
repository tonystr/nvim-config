setlocal wrap
setlocal linebreak
let b:copilot_enabled = v:false
nnoremap <buffer> j gj
nnoremap <buffer> k gk
nnoremap <buffer> gk k
nnoremap <buffer> gj j

" Undo breakpoints
inoremap <buffer> , ,<c-g>u
inoremap <buffer> . .<c-g>u
inoremap <buffer> ! !<c-g>u
inoremap <buffer> ? ?<c-g>u
inoremap <buffer> ; ;<c-g>u
