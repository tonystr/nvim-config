local maps = { i = {}, n = {}, v = {}, t = {}, [""] = {} }

-- Key mappings
maps['']['<space>'] = '<nop>'
maps.n['gof'] = ':call File_manager()<CR>'
maps.n['<C-t>'] = ':tabnew<CR>'
maps.n['gt'] = ':tabn<CR>'
maps.n['gT'] = ':tabp<CR>'
maps.n['<C-l>'] = ':nohlsearch<CR>'
maps.n['<C-z>'] = '<Nop>'
maps.n['<C-s>'] = '<Esc>:w<CR>'
maps.n['<C-c>'] = '<Esc>'
maps.n['ga'] = '<Plug>(EasyAlign)'
maps.n['ga'] = '<Plug>(EasyAlign)'

-- Telescope mappings
-- Find files using Telescope command-line sugar.
maps.n['<leader>ff'] = '<cmd>Telescope find_files<cr>'
maps.n['<C-p>'] = '<cmd>Telescope find_files<cr>'
maps.n['<leader>fo'] = '<cmd>Telescope oldfiles<cr>'
maps.n['<leader>fg'] = '<cmd>Telescope live_grep<cr>'
maps.n['<leader>fb'] = '<cmd>Telescope buffers<cr>'
maps.n['<leader>fh'] = '<cmd>Telescope help_tags<cr>'
maps.n['<leader>fr'] = '<cmd>Telescope registers<cr>'
maps.n['<leader>fs'] = '<cmd>Telescope spell_suggest<cr>'
maps.n['<leader>fd'] = '<cmd>Telescope diagnostics<cr>'
-- TODO: do it the lua way
maps.n['<leader>so'] = function() require("telescope.builtin").lsp_document_symbols() end
maps.n['gr'] = '<cmd>Telescope lsp_references<cr>'
maps.n['gR'] = function() vim.lsp.buf.references() end
-- Git commands
maps.n['<leader>gs'] = '<cmd>Telescope git_status<cr>'
maps.n['<leader>gc'] = '<cmd>Telescope git_commits<cr>'
maps.n['<leader>gbc'] = '<cmd>Telescope git_bcommits<cr>'
maps.n['<leader>gbr'] = '<cmd>Telescope git_branches<cr>'
maps.n['<leader>gbl'] = ':GitBlameToggle<cr>'

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
maps.n['<leader>rn'] = function() vim.lsp.buf.rename() end

-- NeoTree
maps.n['<leader>e'] = '<cmd>Neotree toggle<cr>'
maps.n['<leader>o'] = '<cmd>Neotree focus<cr>'

-- Emmet bindings
maps.n['<C-h>'] = '<Plug>(emmet-expand-abbr)'
maps.i['<C-h>'] = '<Plug>(emmet-expand-abbr)'

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
maps.n['<A-p>'] = '<Cmd>BufferPin<CR>'
-- Close buffer
maps.n['<A-w>'] = '<Cmd>BufferClose<CR>'
-- Sort automatically by...
maps.n['<leader>bb'] = '<Cmd>BufferOrderByBufferNumber<CR>'
maps.n['<leader>bd'] = '<Cmd>BufferOrderByDirectory<CR>'
maps.n['<leader>bl'] = '<Cmd>BufferOrderByLanguage<CR>'
maps.n['<leader>bw'] = '<Cmd>BufferOrderByWindowNumber<CR>'

-- Objectively correct clipboard mappings (thx: https://ezhik.me/blog/vim-clipboard/)
maps.n['<C-v>'] = '"+p'
maps.v['<C-v>'] = '"+p'
maps.i['<C-v>'] = '<C-r>+'
maps['']['""y'] = '""y'
maps['']['""yy'] = '""yy'
maps['']['""p'] = '""p'
maps['']['""P'] = '""P'

-- Yank to system clipboard
vim.keymap.set('n', 'y', '', {
	callback = function()
		return vim.v.register == '"' and '"+y' or 'y'
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
