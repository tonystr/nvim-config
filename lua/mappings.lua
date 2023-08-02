local maps = { i = {}, n = {}, v = {}, t = {}, x = {}, c = {}, o = {}, [''] = {} }

-- Key mappings
maps['']['<space>'] = '<nop>'
maps.n['<leader>of'] = '<cmd>call File_manager()<CR>'
maps.n['<leader>ot'] = '<cmd>silent !wt -d .<CR>'
maps.n['<C-t>'] = '<cmd>tabnew<CR>'
maps.n['gt'] = '<cmd>tabn<CR>'
maps.n['gT'] = '<cmd>tabp<CR>'
maps.n['<C-l>'] = '<cmd>nohlsearch<CR>'
maps.n['<Esc>'] = '<cmd>nohlsearch<CR>'
maps.n['<C-z>'] = '<Nop>'
maps.n['<C-s>'] = '<cmd>w<CR>'
maps.i['<C-s>'] = '<Esc><cmd>w<CR>'
maps.i['<C-Backspace>'] = '<C-w>'
maps.c['<C-Backspace>'] = '<C-w>'
maps.i['<S-Enter>'] = '<Enter><Up>'
maps.n['<C-c>'] = '<Esc>'
-- maps.n['/'] = '<Esc>/\\v'
maps.n['<C-/>'] = '<Esc>/'
maps.n['<leader>fm'] = vim.lsp.buf.format
maps.t['<Esc>'] = '<cmd>ToggleTerm<CR>'
maps.n['{'] = { '<cmd>keepjump normal! {<CR>', noremap = true }
maps.n['}'] = { '<cmd>keepjump normal! }<CR>', noremap = true }
maps.n['<leader>br'] = '<cmd>echo "test"<CR>'
maps.o['{'] = 'V{'
maps.o['}'] = 'V}'
maps.n['<leader>G'] = '<cmd>Git<CR>';
-- maps.n['n'] = 'nzzzv'
-- maps.n['N'] = 'Nzzzv'
-- Repeat over multiple lines
maps.v['.'] = { ':norm .<CR>', noremap = true }

maps.n['zR'] = function() require'ufo'.openAllFolds() end
maps.n['zM'] = function() require'ufo'.closeAllFolds() end

-- Vue navigation

maps.n['<leader>H'] = '<cmd>silent! g/^<script/<CR>jzt<cmd>nohlsearch<CR>';
maps.n['<leader>M'] = '<cmd>silent! g/^<template/<CR>jzt<cmd>nohlsearch<CR>';
maps.n['<leader>L'] = '<cmd>silent! g/^<style/<CR>jzt<cmd>nohlsearch<CR>';

-- treesj splitjoin
maps.n['<Enter>'] = function() require'treesj'.toggle() end
maps.n['gS'] = function() require'treesj'.split() end
maps.n['gJ'] = function() require'treesj'.join() end

-- Execute macro over visual range  TODO: lua implementation
vim.cmd[[
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction
]]

local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end

vim.keymap.set('n', '+', function() change_scale_factor(1.10) end)
vim.keymap.set('n', '-', function() change_scale_factor(1 / 1.10) end)

-- Telescope mappings
-- Find files using Telescope command-line sugar.
maps.n['<leader>ff'] = '<cmd>Telescope resume<cr>'
maps.n['<leader>fj'] = '<cmd>Telescope jumplist<cr>'
maps.n['<C-p>'] = '<cmd>Telescope find_files<cr>'
maps.n['<leader>fo'] = '<cmd>Telescope oldfiles<cr>'
maps.n['<leader>fg'] = '<cmd>Telescope live_grep<cr>'
maps.n['<leader>fb'] = '<cmd>Telescope buffers<cr>'
maps.n['<leader>fh'] = '<cmd>Telescope help_tags<cr>'
maps.n['<leader>fr'] = '<cmd>Telescope registers<cr>'
maps.n['<leader>fs'] = '<cmd>Telescope spell_suggest<cr>'
maps.n['<leader>fd'] = '<cmd>Telescope diagnostics<cr>'
maps.n['<leader>fu'] = '<cmd>Telescope undo<cr>'
maps.n['<leader>gr'] = '<cmd>Telescope repo list<cr>'
maps.n['<leader>ft'] = '<cmd>TodoTelescope<cr>'
maps.n['<leader>so'] = function() require("telescope.builtin").lsp_document_symbols() end
maps.n['gr'] = '<cmd>Telescope lsp_references<cr>'
maps.n['gR'] = function() vim.lsp.buf.references() end
-- Git commands
maps.n['<leader>gs'] = '<cmd>Telescope git_status<cr>'
maps.n['<leader>gc'] = '<cmd>Telescope git_commits<cr>'
maps.n['<leader>gC'] = '<cmd>Telescope git_bcommits<cr>' -- current buffer commits
maps.n['<leader>gb'] = '<cmd>Telescope git_branches<cr>'
maps.n['<leader>gB'] = '<cmd>GitBlameToggle<cr>'

-- LSP key mappings
maps.n['gd'] = function() vim.lsp.buf.definition() end
maps.n['gD'] = function() vim.lsp.buf.declaration() end
maps.n['gi'] = function() vim.lsp.buf.implementation() end
-- maps.n['<leader>w'] = function() vim.lsp.buf.document_symbol() end
-- maps.n['<leader>w'] = function() vim.lsp.buf.workspace_symbol() end
maps.n['[d'] = function() vim.diagnostic.goto_prev() end
maps.n[']d'] = function() vim.diagnostic.goto_next() end
maps.n['<leader>d'] = function() vim.diagnostic.open_float() end
maps.n['gt'] = function() vim.lsp.buf.type_definition() end
maps.n['K'] = function() vim.lsp.buf.hover() end
maps.n['gl'] = function() print('hello world') end
maps.n['<C-k>'] = function() vim.lsp.buf.signature_help() end
maps.n['<leader>af'] = function() vim.lsp.buf.code_action() end
maps.v['<leader>af'] = function() vim.lsp.buf.code_action() end
maps.n['<leader>rn'] = function() vim.lsp.buf.rename() end

-- Emmet bindings
maps.n['<C-h>'] = '<Plug>(emmet-expand-abbr)'
maps.i['<C-h>'] = '<Plug>(emmet-expand-abbr)'
maps.n['<C-y>'] = '<Plug>(emmet-expand-yank)'
maps.i['<C-y>'] = '<Plug>(emmet-expand-yank)'

-- Visual mode
maps.v['<'] = '<gv'
maps.v['>'] = '>gv'

-- Barbar keybindings
-- Move to previous/next
maps.n['<A-,>'] = '<Cmd>BufferPrevious<CR>'
maps.n['<A-.>'] = '<Cmd>BufferNext<CR>'
maps.n['<A-Left>'] = '<Cmd>BufferPrevious<CR>'
maps.n['<A-Right>'] = '<Cmd>BufferNext<CR>'
-- Move between windows
maps.n['<A-h>'] = '<Cmd>wincmd h<CR>'
maps.n['<A-j>'] = '<Cmd>wincmd j<CR>'
maps.n['<A-k>'] = '<Cmd>wincmd k<CR>'
maps.n['<A-l>'] = '<Cmd>wincmd l<CR>'
-- Re-order to previous/next
maps.n['<A-<>'] = '<Cmd>BufferMovePrevious<CR>'
maps.n['<A->>'] = '<Cmd>BufferMoveNext<CR>'
-- Goto buffer in position...
maps.n['<A-1>'] = '<Cmd>BufferGoto 1<CR>'
maps.n['<A-2>'] = '<Cmd>BufferGoto 2<CR>'
maps.n['<A-3>'] = '<Cmd>BufferGoto 3<CR>'
maps.n['<A-4>'] = '<Cmd>BufferGoto 4<CR>'
maps.n['<A-5>'] = '<Cmd>BufferGoto 5<CR>'
maps.n['<A-6>'] = '<Cmd>BufferGoto 6<CR>'
maps.n['<A-7>'] = '<Cmd>BufferGoto 7<CR>'
maps.n['<A-8>'] = '<Cmd>BufferGoto 8<CR>'
maps.n['<A-9>'] = '<Cmd>BufferGoto 9<CR>'
maps.n['<A-0>'] = '<Cmd>BufferLast<CR>'
-- Pin/unpin buffer
-- maps.n['<A-p>'] = '<Cmd>BufferPin<CR>'
-- Close buffer
maps.n['<A-w>'] = '<Cmd>BufferDelete<CR>'
-- Sort automatically by...
-- maps.n['<leader>bb'] = '<Cmd>BufferOrderByBufferNumber<CR>'
-- maps.n['<leader>bd'] = '<Cmd>BufferOrderByDirectory<CR>'
-- maps.n['<leader>bl'] = '<Cmd>BufferOrderByLanguage<CR>'
-- maps.n['<leader>bw'] = '<Cmd>BufferOrderByWindowNumber<CR>'

-- Git hunks
vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
vim.keymap.set({'o', 'x'}, 'ah', ':<C-U>Gitsigns select_hunk<CR>')

-- Objectively correct clipboard mappings (thx: https://ezhik.me/blog/vim-clipboard/)
maps.n['<C-v>'] = '"+p'
maps.v['<C-v>'] = '"+p'
maps.i['<C-v>'] = '<C-r>+'
maps.c['<C-v>'] = '<C-r>+'
-- maps['']['""y'] = '""y'
-- maps['']['""yy'] = '""yy'
-- maps['']['""p'] = '""p'
-- maps['']['""P'] = '""P'

-- Yank to system clipboard
vim.keymap.set('n', 'y', '', {
	callback = function()
		return vim.v.register == '"' and '"+y' or 'y'
	end,
	expr = true,
})


-- Yank to system clipboard
vim.keymap.set('n', 'Y', '', {
	callback = function()
		return vim.v.register == '"' and '"+y$' or 'y$'
	end,
	expr = true,
})

-- Yank to system clipboard
vim.keymap.set('n', 'yy', '', {
	callback = function()
		return vim.v.register == '"' and '"+yy' or 'yy'
	end,
	expr = true,
})

vim.keymap.set('v', 'y', '', {
    callback = function()
        return vim.v.register == '"' and '"+y' or 'y'
    end,
    expr = true,
})

maps.n['<leader>p'] = '<cmd>pu<CR>==^'
maps.n['<leader>P'] = '<cmd>-1pu<CR>==^'

-- Render maps table into vim keyboard mappings
for mode, mappings in pairs(maps) do
	for keymap, options in pairs(mappings) do
		local keymap_opts = {}
		local cmd = options
		if type(options) == 'table' then
			cmd = options[1]
			keymap_opts = options[2]
		end
		vim.keymap.set(mode, keymap, cmd, keymap_opts)
	end
end
