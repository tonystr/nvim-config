local maps = { i = {}, n = {}, v = {}, t = {}, x = {}, c = {}, o = {}, [''] = {} }

-- Key mappings
maps['']['<space>'] = '<nop>'
maps.n['<leader>of'] = '<cmd>call File_manager()<CR>'
maps.n['<leader>ot'] = '<cmd>silent !wt -w 0 nt -d %:h<CR>'
maps.n['<leader>oT'] = '<cmd>silent !wt -w 0 nt -d .<CR>'
maps.n['<leader>oi'] = '<cmd>Oil --float<CR>'
maps.n['<C-t>'] = '<cmd>tabnew<CR>'
maps.n['gt'] = '<cmd>tabn<CR>'
maps.n['gT'] = '<cmd>tabp<CR>'
maps.n['<C-l>'] = '<cmd>nohlsearch<CR>'
-- maps.n['<C-z>'] = { '<Nop>', noremap = true }

maps.t['<S-Esc>'] = '<C-\\><C-n>'
maps.t['<C-Backspace>'] = '<C-w>'
maps.t['<C-S-v>'] = '<C-\\><C-n>"+pi'
maps.t['<C-v>'] = '<C-\\><C-n>"+pi'
maps.t['<Up>'] = 'i<Up>'

maps.n['<C-Up>']     = '<C-y>'
maps.n['<C-Down>']   = '<C-e>'
maps.n['<S-Up>']     = '3<C-y>'
maps.n['<S-Down>']   = '3<C-e>'
maps.n['<C-S-Up>']   = '3<C-y>'
maps.n['<C-S-Down>'] = '3<C-e>'
maps.n['<C-S-y>']    = '3<C-y>'
maps.n['<C-S-e>']    = '3<C-e>'
maps.i['<S-Down>']   = '<C-o>3<C-e>'
maps.i['<S-Up>']     = '<C-o>3<C-y>'

maps.v['<RightMouse>'] = '"+y'

maps.n['<A-Up>'] = '<cmd>resize +1<CR>'
maps.n['<A-Down>'] = '<cmd>resize -1<CR>'
maps.n['<S-A-Up>'] = '<cmd>resize +3<CR>'
maps.n['<S-A-Down>'] = '<cmd>resize -3<CR>'

maps.n['<leader>ns'] = '<cmd>Neogit<CR>'
maps.n['<leader>ng'] = '<cmd>Neogit<CR>'
maps.n['<leader>nc'] = '<cmd>Neogit commit<CR>'
maps.n['<leader>np'] = '<cmd>Neogit pull<CR>'
maps.n['<leader>nP'] = '<cmd>Neogit push<CR>'
maps.n['<leader>nl'] = '<cmd>NeogitLogCurrent<CR>'

maps.n['digv'] = 'gvd'
maps.n['yigv'] = 'gvy'
maps.n['cigv'] = 'gvc'

maps.c['<C-.>'] = '\\.';
maps.c['<C-/>'] = '\\/';

local diagnostics_hidden = false
function toggle_diagnostics_hidden()
	if diagnostics_hidden then
		vim.diagnostic.show()
		diagnostics_hidden = false
	else
		vim.diagnostic.hide()
		diagnostics_hidden = true
	end
end
maps.n['<C-0>'] = function() vim.cmd'nohlsearch'; vim.diagnostic.hide() end
maps.i['<C-0>'] = function() vim.cmd'nohlsearch'; vim.diagnostic.hide() end
maps.n['<Esc>'] = function() vim.cmd'nohlsearch'; vim.diagnostic.hide() end
maps.n['<C-9>'] = function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end
maps.i['<C-9>'] = function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end

maps.n['glc'] = function() require('timber.actions').toggle_comment_log_statements({ global = false }) end
maps.n['gld'] = function() require('timber.actions').clear_log_statements({ global = false }) end

vim.keymap.set("n", "gll", function()
	return require("timber.actions").insert_log({ position = "below", operator = true }) .. "_"
end, {
	desc = "[G]o [L]og: Insert below log statements the current line",
	expr = true,
})

-- ↓ does not work due to relative file paths and rooting
-- maps.n['gf'] = '<cmd>e <cfile><CR>'

maps.n['<C-s>'] = '<cmd>sil w<CR>'
maps.i['<C-s>'] = '<Esc><cmd>sil w<CR>'

vim.keymap.set({ 'i', 'c' }, '<C-Backspace>', '<C-w>')
-- maps.i['<C-Backspace>'] = '<C-w>'
-- maps.c['<C-Backspace>'] = '<C-w>'
maps.i['<S-Enter>'] = '<Enter><Up>'
maps.n['<C-c>'] = '<Esc>'
-- maps.n['/'] = '<Esc>/\\v'
maps.n['<C-/>'] = '<Esc>/'
maps.n['<leader>fm'] = function() vim.lsp.buf.format() end
maps.n['<leader>YY'] = function() vim.lsp.buf.format() end
maps.n['<leader>S'] = ':%so<CR>'
maps.n['{'] = { '<cmd>keepjump normal! {<CR>', noremap = true }
maps.n['}'] = { '<cmd>keepjump normal! }<CR>', noremap = true }
maps.n['<leader>br'] = '<cmd>echo "test"<CR>'
maps.o['{'] = 'V{'
maps.o['}'] = 'V}'
maps.n['<leader>G'] = '<cmd>Git<CR>';
maps.n['<leader>gg'] = '<cmd>Git<CR>';
maps.n['<M-g>'] = '<cmd>Git<CR>';

maps.n['<leader>cc'] = function () require'tinygit'.smartCommit() end
-- maps.n['<leader>gp'] = function () require'tinygit'.push() end
maps.n['<leader>gp'] = '<cmd>Dispatch! git push<CR>';

maps.n['<leader>wp'] = '<cmd>e ~/OneDrive/projects/<CR>';

maps.n['<leader>ai'] = function()
	vim.lsp.buf.code_action({
		filter = function(action)
			return action.title:lower():find("import")
				-- action.command.title:find("Import")
		end,
		apply = true,
	})
end

-- I think this is fixed now?
-- -- Fixes a bug where neovide hangs when deleting many lines in visual mode.
-- vim.keymap.set('v', 'd', '', {
-- 	callback = function()
-- 		vim.cmd'IndentBlanklineDisable'
-- 		return 'd<cmd>IndentBlanklineEnable<CR>'
-- 	end,
-- 	expr = true,
-- })

vim.keymap.set('v', 'I', '', {
	callback = function ()
		if vim.fn.mode() ~= '' then
			return 'I'
		end
		return 'I'
	end,
	expr = true,
})
vim.keymap.set('v', 'A', '', {
	callback = function ()
		if vim.fn.mode() ~= '' then
			return 'A'
		end
		return 'A'
	end,
	expr = true,
})

maps.n['gA'] = 'g$bEa';
maps.n['gI'] = 'g^i';

maps.n['g?'] = '<cmd>let @/ = "\\\\<" . @? . "\\\\>"<CR>N';
maps.n['g/'] = '<cmd>let @/ = "\\\\<" . @/ . "\\\\>"<CR>n';

-- Quickfix list
maps.n[']q'] = '<cmd>cnext<CR>';
maps.n['[q'] = '<cmd>cprev<CR>';
maps.n[']Q'] = '<cmd>cfirst<CR>';
maps.n['[Q'] = '<cmd>clast<CR>';

maps.n[']l'] = '<cmd>lnext<CR>';
maps.n['[l'] = '<cmd>lprev<CR>';
maps.n[']L'] = '<cmd>lfirst<CR>';
maps.n['[L'] = '<cmd>llast<CR>';

-- maps.n['n'] = 'nzzzv'
-- maps.n['N'] = 'Nzzzv'
-- Repeat over multiple lines
maps.v['.'] = { ':norm .<CR>', noremap = true }

-- maps.n['zR'] = function() require'ufo'.openAllFolds() end
-- maps.n['zM'] = function() require'ufo'.closeAllFolds() end

-- Vue navigation

maps.n['<leader>H'] = '<cmd>silent! g/^<script/<CR>jzt<cmd>nohlsearch<CR>';
maps.n['<leader>M'] = '<cmd>silent! g/^<template/<CR>jzt<cmd>nohlsearch<CR>';
maps.n['<leader>L'] = '<cmd>silent! g/^<style/<CR>jzt<cmd>nohlsearch<CR>';

-- treesj splitjoin
maps.n['<Enter>'] = function() require'treesj'.toggle() end
-- maps.n['gS'] = function() require'treesj'.split() end
-- maps.n['gJ'] = function() require'treesj'.join() end

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

vim.keymap.set('n', '<C-=>', function() change_scale_factor(1.10) end)
vim.keymap.set('n', '<C-ScrollWheelUp>', function() change_scale_factor(1.10) end)
vim.keymap.set('n', '<C-->', function() change_scale_factor(1 / 1.10) end)
vim.keymap.set('n', '<C-ScrollWheelDown>', function() change_scale_factor(1 / 1.10) end)

vim.keymap.set('n', '<A-Enter>', function()
	vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
end)

-- Telescope mappings
maps.n['<leader>ff'] = '<cmd>Telescope resume<cr>'
maps.n['<leader>fj'] = '<cmd>Telescope jumplist<cr>'
maps.n['<C-p>'] = '<cmd>Telescope find_files<cr>'
maps.n['<leader>fp'] = function ()
	require'telescope.builtin'.find_files({
		cwd = require'telescope.utils'.buffer_dir()
	})
end
maps.n['<leader>fo'] = '<cmd>Telescope oldfiles<cr>'
maps.n['<leader>fg'] = '<cmd>Telescope live_grep<cr>'
maps.n['<leader>fb'] = '<cmd>Telescope buffers<cr>'
maps.n['<leader>fh'] = '<cmd>Telescope help_tags<cr>'
maps.n['<leader>fr'] = '<cmd>Telescope registers<cr>'
maps.n['<leader>fs'] = '<cmd>Telescope spell_suggest<cr>'
maps.n['z='] = '<cmd>Telescope spell_suggest<cr>'
maps.n['<leader>fd'] = '<cmd>Telescope diagnostics<cr>'
maps.n['<leader>fu'] = '<cmd>Telescope undo<cr>'
maps.n['<leader>gr'] = '<cmd>Telescope repo list<cr>'
maps.n['<leader>ft'] = '<cmd>TodoTelescope<cr>'
maps.n['<leader>so'] = function() require("telescope.builtin").lsp_document_symbols() end
maps.n['<leader>lim'] = '<cmd>Telescope lsp_implementations<cr>'
maps.n['<leader>lic'] = '<cmd>Telescope lsp_incoming_calls<cr>'
maps.n['<leader>loc'] = '<cmd>Telescope lsp_outgoing_calls<cr>'
maps.n['<leader>ltd'] = '<cmd>Telescope lsp_type_definitions<cr>'
maps.n['<leader><leader>K'] = '<cmd>Telescope lsp_type_definitions<cr>'
maps.n['gr'] = '<cmd>Telescope lsp_references<cr>'
maps.n['gR'] = function() vim.lsp.buf.references() end
maps.n['gF'] = function ()
	require'telescope.builtin'.live_grep({
		default_text = vim.fn.expand('%:t')
	})
end
-- Git commands
maps.n['<leader>gs'] = '<cmd>Telescope git_status<cr>'
maps.n['<leader>gc'] = '<cmd>Telescope git_commits<cr>'
maps.n['<leader>gC'] = '<cmd>Telescope git_bcommits<cr>' -- current buffer commits
maps.n['<leader>gb'] = '<cmd>Telescope git_branches<cr>'
maps.n['<leader>gB'] = '<cmd>GitBlameToggle<cr>'

maps.n['<leader>co'] = '<cmd>GitConflictChooseOurs<cr>'
maps.n['<leader>ct'] = '<cmd>GitConflictChooseTheirs<cr>'
maps.n['<leader>cb'] = '<cmd>GitConflictChooseBoth<cr>'
maps.n['<leader>cB'] = '<cmd>GitConflictChooseBase<cr>'
maps.n['<leader>cN'] = '<cmd>GitConflictChooseNone<cr>'
maps.n['<leader>c]'] = '<cmd>GitConflictNextConflict<cr>'
maps.n['<leader>c['] = '<cmd>GitConflictPrevConflict<cr>'
maps.n['<leader>cq'] = '<cmd>GitConflictListQf<cr>'

vim.cmd'command Push Dispatch! git push'
vim.cmd'command Pull Dispatch! git pull'
vim.cmd'command -nargs=1 Cam Dispatch! git cam <f-args>'
vim.cmd'command -nargs=1 Commit Dispatch! git commit -m <f-args>'
-- vim.cmd'command -nargs=1 Com Dispatch git commit -m <f-args>'
vim.cmd'command -nargs=* K Dispatch git <args>'

-- LSP key mappings
maps.n['<leader>lr'] = '<cmd>LspRestart<cr>'
maps.n['gd'] = function() vim.lsp.buf.definition() end
maps.n['gD'] = function() vim.lsp.buf.declaration() end
-- maps.n['gi'] = function() vim.lsp.buf.implementation() end
-- maps.n['<leader>w'] = function() vim.lsp.buf.document_symbol() end
-- maps.n['<leader>w'] = function() vim.lsp.buf.workspace_symbol() end
-- maps.n['[d'] = function() vim.diagnostic.goto_prev() end
-- maps.n[']d'] = function() vim.diagnostic.goto_next() end
maps.n['[d'] = function() vim.diagnostic.jump{ count = -1, float = true } end
maps.n[']d'] = function() vim.diagnostic.jump{ count = 1, float = true } end
maps.n['<leader>d'] = function() vim.diagnostic.open_float() end
maps.n['gt'] = function() vim.lsp.buf.type_definition() end
maps.n['K'] = function() vim.lsp.buf.hover() end
maps.n['<C-k>'] = function() vim.lsp.buf.signature_help() end
maps.n['<leader>af'] = function() vim.lsp.buf.code_action() end
maps.v['<leader>af'] = function() vim.lsp.buf.code_action() end
maps.n['<leader>rn'] = function() vim.lsp.buf.rename() end

-- Emmet bindings
maps.n['<C-h>'] = '<Plug>(emmet-expand-abbr)'
maps.i['<C-h>'] = '<Plug>(emmet-expand-abbr)'

-- Visual mode
maps.v['<'] = '<gv'
maps.v['>'] = '>gv'

-- Move between windows
maps.n['<A-h>'] = '<Cmd>wincmd h<CR>'
maps.n['<A-j>'] = '<Cmd>wincmd j<CR>'
maps.n['<A-k>'] = '<Cmd>wincmd k<CR>'
maps.n['<A-l>'] = '<Cmd>wincmd l<CR>'

-- maps.n['<A-,>'] = '<Cmd>bn<CR>'
-- maps.n['<A-.>'] = '<Cmd>bp<CR>'
-- maps.n['<A-Left>'] = '<Cmd>bp<CR>'
-- maps.n['<A-Right>'] = '<Cmd>bn<CR>'
--
-- maps.n['<A-w>'] = '<Cmd>bd<CR>'
-- maps.n['<A-W>'] = '<Cmd>BufferWipeout<CR>'
-- maps.n['<A-o>'] = '<C-w>o<CR>'
-- maps.n['<A-S-o>'] = '<C-w>o<Cmd>BufferCloseAllButCurrent<CR>'
-- maps.n['<A-e>'] = '<Cmd>BufferDelete #<CR>'
-- maps.n['<A-r>'] = '<Cmd>BufferRestore<CR>'
-- maps.n['<A-s>'] = '<C-w>s'

-- Barbar keybindings
-- Move to previous/next
-- maps.n['<A-,>'] = '<Cmd>BufferPrevious<CR>'
-- maps.n['<A-.>'] = '<Cmd>BufferNext<CR>'
maps.n['<A-Left>'] = '<Cmd>BufferPrevious<CR>'
maps.n['<A-Right>'] = '<Cmd>BufferNext<CR>'
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
maps.n['<A-w>'] = '<Cmd>BufferDelete<CR>'
maps.n['<A-W>'] = '<Cmd>BufferWipeout<CR>'
maps.n['<A-o>'] = '<C-w>o<CR>'
maps.n['<A-S-o>'] = '<C-w>o<Cmd>BufferCloseAllButCurrent<CR>'
maps.n['<A-e>'] = '<Cmd>BufferDelete #<CR>'
maps.n['<A-r>'] = '<Cmd>BufferRestore<CR>'
maps.n['<A-s>'] = '<C-w>s'

maps.n['<F11>'] = function()
	if vim.g.neovide_fullscreen then
		vim.g.neovide_fullscreen = false
	else
		vim.g.neovide_fullscreen = true
	end
end

-- Sort automatically by...
-- maps.n['<leader>bb'] = '<Cmd>BufferOrderByBufferNumber<CR>'
-- maps.n['<leader>bd'] = '<Cmd>BufferOrderByDirectory<CR>'
-- maps.n['<leader>bl'] = '<Cmd>BufferOrderByLanguage<CR>'
-- maps.n['<leader>bw'] = '<Cmd>BufferOrderByWindowNumber<CR>'

-- Git hunks
vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
vim.keymap.set({'o', 'x'}, 'ah', ':<C-U>Gitsigns select_hunk<CR>')

-- maps.n['<C-v>'] = '<cmd>pu +<CR>=\'[\']^'

vim.keymap.set('n', '<C-v>', '', {
	callback = function()
		local plusreg = vim.fn.getreg('+')

		if plusreg:match('#?[0-9a-fA-F]+') then
			local hex = plusreg
			if #plusreg == 6 or #plusreg == 3 or #plusreg == 8 then
				hex = '#' .. plusreg
			end

			local col = vim.fn.col('.')
			local line = vim.fn.getline('.')

			local hex_start = col
			local hex_end = col

			while hex_start > 0 and col - hex_start < 10 and line:sub(hex_start, hex_start):match('[#0-9a-fA-F]') do
				hex_start = hex_start - 1
			end

			while hex_end < #line and hex_end - hex_start < 10 and line:sub(hex_end, hex_end):match('[#0-9a-fA-F]') do
				hex_end = hex_end + 1
			end

			if not line:sub(hex_end, hex_end):match('[0-9a-fA-F]') or hex_end - hex_start >= 10 then
				hex_end = hex_end - 1
			end

			if hex_end - hex_start >= 3 then
				local before = line:sub(1, hex_start)
				local after = line:sub(hex_end + 1)

				vim.defer_fn(function()
					vim.fn.setline('.', before .. hex .. after)
				end, 0)
				
				return ''
			end
		end
		return '"+p'
	end,
	expr = true,
})

maps.n['<leader><C-v>'] = '<cmd>-1pu +<CR>=\'[\']^'
maps.v['<C-v>'] = '"+p=\'[\']^'
maps.i['<C-v>'] = '<cmd>set noai<CR><C-r>+<cmd>set ai<CR>'
maps.c['<C-v>'] = '<C-r>+'
-- maps['']['""y'] = '""y'
-- maps['']['""yy'] = '""yy'
-- maps['']['""p'] = '""p'
-- maps['']['""P'] = '""P'

-- Yank to system clipboard
vim.keymap.set('n', 'y', '', {
	callback = function()
		-- return vim.v.register == '"' and '"+y' or 'y'
		if vim.v.register == '"' then
			return '"+y'
		end
		return 'y'
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

maps.n['<leader>yf'] = function() 
	vim.cmd'let @+ = expand("%:p")'
	vim.cmd'echo "Copied to clipboard: " . @+'
end
maps.n['<leader>yF'] = function() 
	vim.cmd'let @+ = expand("%:p:h")'
	vim.cmd'echo "Copied to clipboard: " . @+'
end

vim.keymap.set('v', 'y', '', {
    callback = function()
        return vim.v.register == '"' and '"+y' or 'y'
    end,
    expr = true,
})

maps.n['<leader>p'] = '<cmd>pu<CR>=\'[\']^'
maps.n['<leader>P'] = '<cmd>-1pu<CR>=\'[^'

-- smart blackhole deletion
vim.keymap.set("n", "dd", function()
	---@diagnostic disable-next-line: param-type-mismatch
	if vim.fn.getline(".") == "" then
		return '"_dd'
	end
	return "dd"
end, { expr = true })

-- Inline shell command to register @"
function SetBang()
	local command = vim.fn.input("\"!")
	local output = vim.fn.system(command)
	output = output:gsub('%s+$', '')
	vim.fn.setreg('"', output)
end

maps.n['"!'] = SetBang
maps.x['"!'] = function ()
	SetBang()
	vim.cmd'norm p'
end
vim.keymap.set('i', '<C-r>!', '', {
	callback = function ()
		SetBang()
		return '"'
	end,
	expr = true
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
