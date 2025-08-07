-- local env = require('env')

-- -- Next step: segment motions. Find a way to check if buffer changed?
-- local motion = ''
-- local prev_mode = vim.api.nvim_get_mode().mode
-- vim.on_key(function(key)
-- 	vim.defer_fn(function()
-- 		local mode = vim.api.nvim_get_mode().mode
--
-- 		motion = motion .. key
--
-- 		if mode == 'n' and prev_mode ~= 'n' then
-- 			vim.cmd('echo "motion: ' .. motion .. '"')
-- 			motion = ''
-- 		end
--
-- 		if mode ~= prev_mode then
-- 			prev_mode = mode
-- 		end
-- 	end, 0)
-- 	return key
-- end, 0)

---------------- LSP Configuration ----------------

vim.lsp.config('*', {
	root_markers = { '.git' },
})

-- https://github.com/vuejs/language-tools/wiki/Neovim
-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/vue_ls.lua
-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/vtsls.lua

local vue_language_server_path = '/usr/lib/node_modules/@vue/language-server'
local vue_plugin = {
	name = '@vue/typescript-plugin',
	location = vue_language_server_path,
	languages = { 'vue' },
	configNamespace = 'typescript',
}

vim.lsp.config['vtsls'] = {
	cmd = { 'vtsls', '--stdio' },
	filetypes = {
		'javascript',
		'javascriptreact',
		'javascript.jsx',
		'typescript',
		'typescriptreact',
		'typescript.tsx',
		'vue',
	},
	root_markers = { 'tsconfig.json', 'package.json', 'jsconfig.json', '.git' },
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					vue_plugin,
				},
			},
		},
	},
}

vim.lsp.config['vue_ls'] = {
	cmd = { 'vue-language-server', '--stdio' },
	filetypes = { 'vue' },
	root_markers = { 'package.json' },
	on_init = function(client)
		client.handlers['tsserver/request'] = function(_, result, context)
			local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
			if #clients == 0 then
				vim.notify('Could not find `vtsls` lsp client, required by `vue_ls`.', vim.log.levels.ERROR)
				return
			end
			local ts_client = clients[1]

			local param = unpack(result)
			local id, command, payload = unpack(param)
			ts_client:exec_cmd(
				{
					title = 'vue_request_forward', -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
					command = 'typescript.tsserverRequest',
					arguments = {
						command,
						payload,
					},
				},
				{ bufnr = context.bufnr },
				function(_, r)
					local response_data = { { id, r.body } }
					---@diagnostic disable-next-line: param-type-mismatch
					client:notify('tsserver/response', response_data)
				end
			)
		end
	end,
}

vim.lsp.enable('vtsls')
vim.lsp.enable('vue_ls')

-- Lua LS
vim.lsp.config['lua_ls'] = {
	cmd = { 'lua-language-server', '--stdio' },
	filetypes = { 'lua' },
	root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				enable = true,
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
				},
			},
			telemetry = { enable = false },
		}
	},
}

vim.lsp.enable('lua_ls')

-- TS LS
vim.lsp.config['ts_ls'] = {
	cmd = { 'typescript-language-server', '--stdio' },
	filetypes = { 'vue', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
}

vim.lsp.enable('ts_ls')

-- clang

vim.lsp.config['clang'] = {
	cmd = { 'clangd' },
	filetypes = { 'c', 'h', 'cpp', 'cc', 'cxx', 'hpp', 'hh', 'hxx' }
}

vim.lsp.enable('clang')

-- GDScript LS
local port = os.getenv 'GDScript_Port' or '6005'
local cmd = vim.lsp.rpc.connect('127.0.0.1', tonumber(port))

vim.lsp.config['gdscript_ls'] = {
	cmd = cmd,
	filetypes = { 'gd', 'gdscript', 'gdscript3' },
	root_markers = { 'project.godot', '.git' },
}
vim.lsp.enable('gdscript_ls')

-- Diagnostics
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN]  = "",
			[vim.diagnostic.severity.INFO]  = "",
			[vim.diagnostic.severity.HINT]  = "",
		},
	},
})

-- local Signse = {
-- 	Error = "",
-- 	Warn = "",
-- 	Hint = "󰌵",
-- 	Info = "󰆈",
-- }

-----------------------------------------------------



vim.o.guicursor = 'n-v-c-ci-sm:block,i-ve:ver25,r-cr-o:hor20'
-- vim.o.showbreak = '▏󱞩  ' -- 󱞩
vim.o.showbreak = '󱞩   ' -- 󱞩
-- vim.o.showbreak = '󰞘   ' -- 󱞩

-- vim.g.formatprg = 'prettier --parser typescript --stdin-path %';

vim.o.completeopt = 'menuone,noselect'

-- Emmet snippets

vim.g.user_emmet_settings = {
	html = {
		snippets = {
			['!!'] = [[<script setup lang="ts">
</script>

<template>
</template>

<style scoped lang="scss">
</style>]]
		}
	}
}

-- Enter expansion

function Enter()
	-- if vim.fn.pumvisible() then
	--	return '<CR>???';
	-- end

	local col = vim.fn.col('.')
	local line = vim.fn.getline('.')
	local char = line:sub(col - 1, col - 1)
	if char == '{' then
		local nextchar = line:sub(col, col)
		local afternextchar = line:sub(col + 1, col + 1)

		-- Abort if mid-line
		if afternextchar ~= '' then
			return '<CR>'
		end
		if nextchar == '}' then
			return '<CR><C-o>O'
		end
		return '<CR>}<C-o>O'
	end

	if char == '>' then
		local nextchars = line:sub(col, col + 1)

		if nextchars == '</' then
			return '<CR><C-o>O'
		end
	end

	return '<CR>'
end

vim.keymap.set('i', '<CR>', '', {
    callback = Enter,
    expr = true,
})

local function get_visual_selection()
	local s_start = { '', vim.fn.line('.'), vim.fn.col('.') }
	local s_end = { '', vim.fn.line('v'), vim.fn.col('v') }

	if s_start[2] > s_end[2] or (s_start[2] == s_end[2] and s_start[3] > s_end[3]) then
		s_start, s_end = s_end, s_start
	end

	local n_lines = math.abs(s_end[2] - s_start[2]) + 1
	local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
	lines[1] = lines[1]:sub(s_start[3], -1)
	if n_lines == 1 then
		lines[n_lines] = lines[n_lines]:sub(1, s_end[3] - s_start[3] + 1)
	else
		lines[n_lines] = lines[n_lines]:sub(1, s_end[3])
	end
	return table.concat(lines, '\n')
end

vim.keymap.set('v', '=', '', {
	callback = function()
		local selected_text = get_visual_selection()
		return 'c<C-r>=' .. selected_text
	end,
	expr = true,
})

vim.keymap.set('n', '<M-=>', '', {
	callback = function()
		local col = vim.fn.col('.')
		local linenr = vim.fn.line('.')
		local line_text = vim.api.nvim_buf_get_lines(0, linenr - 1, linenr, false)[1]

		local on_number = line_text:sub(col, col):match("[%d%.]") ~= nil
		local start_col = col
		local end_col = col

		if on_number then
			while start_col > 0 and line_text:sub(start_col, start_col):match("[%d%.]") do
				start_col = start_col - 1
			end
			-- Find the end of the number
			while end_col <= #line_text and line_text:sub(end_col, end_col):match("[%d%.]") do
				end_col = end_col + 1
			end
		else
			start_col, end_col = line_text:sub(col):find('%d*%.?%d+')

			if not start_col or not end_col then
				return
			end

			start_col = col + start_col - 2
			end_col = col + end_col
		end

		local number = line_text:sub(start_col + 1, end_col - 1)

		if number:match("^[%d%.]+$") then
			local movement = '0' .. start_col + 0 .. 'l'

			local col_range = end_col - start_col - 1
			return movement .. 'c' .. col_range .. 'l<C-r>=' .. number
		end
		return
	end,
	expr = true,
})

-- Comment uncomment
local function commented_lines_textobject()
	local U = require("Comment.utils")
	local cl = vim.api.nvim_win_get_cursor(0)[1] -- current line
	local range = { srow = cl, scol = 0, erow = cl, ecol = 0 }
	local ctx = {
		ctype = U.ctype.linewise,
		range = range,
	}
	local cstr = require("Comment.ft").calculate(ctx) or vim.bo.commentstring
	local ll, rr = U.unwrap_cstr(cstr)
	local padding = true
	local is_commented = U.is_commented(ll, rr, padding)

	local line = vim.api.nvim_buf_get_lines(0, cl - 1, cl, false)
	if next(line) == nil or not is_commented(line[1]) then
		return
		end

	local rs, re = cl, cl -- range start and end
	repeat
		rs = rs - 1
		line = vim.api.nvim_buf_get_lines(0, rs - 1, rs, false)
	until next(line) == nil or not is_commented(line[1])
	rs = rs + 1
	repeat
		re = re + 1
		line = vim.api.nvim_buf_get_lines(0, re - 1, re, false)
	until next(line) == nil or not is_commented(line[1])
	re = re - 1

	vim.fn.execute("normal! " .. rs .. "GV" .. re .. "G")
end

vim.keymap.set("o", "gc", commented_lines_textobject,
		{ silent = true, desc = "Textobject for adjacent commented lines" })
vim.keymap.set("o", "u", commented_lines_textobject,
		{ silent = true, desc = "Textobject for adjacent commented lines" })

-- Gitblame configuration
vim.g.gitblame_ignored_filetypes = { 'startup', 'markdown' }
vim.g.gitblame_display_virtual_text = 0
vim.g.gitblame_message_template = '<author>  <summary>'
vim.g.gitblame_message_when_no_blame = ' No blame information available'
vim.g.gitblame_message_when_not_committed = ' Not committed yet'
vim.g.gitblame_message_when_not_tracked = ' Not tracked yet'
vim.g.gitblame_message_when_no_repo = ' No git repository found'
vim.g.gitblame_date_format = '%r'

-- Rooting
local root_names = { '.git', 'package.json', 'node_modules', 'yarn.lock', '.rootfile' }
local root_cache = {}
_G.autoroot_enabled = true

local set_root = function()
	if not _G.autoroot_enabled then return end

	local path = vim.api.nvim_buf_get_name(0)
	if path == '' then return end
	path = vim.fs.dirname(path)

	local root = root_cache[path]
	if root == nil then
		local root_file = vim.fs.find(root_names, { path = path, upward = true })[1]
		if root_file == nil then return end
		root = vim.fs.dirname(root_file)
		root_cache[path] = root
	end

	vim.fn.chdir(root)
end

local toggle_rooting = function()
	_G.autoroot_enabled = not _G.autoroot_enabled
	if _G.autoroot_enabled then
		vim.api.nvim_echo({ { 'Auto-rooting enabled', 'WarningMsg' } }, false, {})
	else
		vim.api.nvim_echo({ { 'Auto-rooting disabled', 'WarningMsg' } }, false, {})
	end
end

local root_augroup = vim.api.nvim_create_augroup('CustomAutoRoot', {})
vim.api.nvim_create_autocmd('BufEnter', { group = root_augroup, callback = set_root })
vim.api.nvim_create_user_command('RootToggle', toggle_rooting, { desc = 'Toggle auto-rooting on/off' })
vim.api.nvim_create_user_command('RootDisable', function() 
	_G.autoroot_enabled = false
	vim.api.nvim_echo({ { 'Auto-rooting disabled', 'WarningMsg' } }, false, {})
end, { desc = 'Disable auto-rooting' })
vim.api.nvim_create_user_command('RootEnable', function()
	_G.autoroot_enabled = true
	vim.api.nvim_echo({ { 'Auto-rooting enabled', 'WarningMsg' } }, false, {})
end, { desc = 'Enable auto-rooting' })

-- Open explorer where current file is located
vim.cmd([[
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

" vimwiki diary template
autocmd BufNewFile ~/OneDrive/vimwiki/diary/[0-9\-]*.md :silent 0!echo "\#" %:t:r
autocmd BufNewFile ~/OneDrive/vimwiki/diary/[0-9\-]*.md :silent r ~/OneDrive/vimwiki/diary/template.md
autocmd BufNewFile ~/OneDrive/vimwiki/diary/[0-9\-]*.md :norm jwv$
autocmd BufNewFile ~/OneDrive/vimwiki/startups/[a-zA-Z0-9\-_]*.md :silent 0!echo "\#" %:t:r
autocmd BufNewFile ~/OneDrive/vimwiki/startups/[a-zA-Z0-9\-_]*.md :silent r ~/OneDrive/vimwiki/startups/template.md
autocmd BufNewFile ~/OneDrive/vimwiki/year/[a-zA-Z0-9\-_]*.md :silent 0!echo "\#" AD %:t:r

" vimwiki work template
autocmd BufNewFile ~/OneDrive/work/diary/[0-9\-]*.md :silent 0!echo "\#" %:t:r
autocmd BufNewFile ~/OneDrive/work/diary/[0-9\-]*.md :silent r ~/OneDrive/work/diary/template.md

" vimwiki entrepreneurship template
autocmd BufNewFile ~/OneDrive/entrepreneurship/diary/[0-9\-]*.md :silent 0!echo "\#" %:t:r
autocmd BufNewFile ~/OneDrive/entrepreneurship/diary/[0-9\-]*.md :silent r ~/OneDrive/entrepreneurship/diary/template.md

autocmd User TelescopePreviewerLoaded setlocal number

autocmd BufEnter * lua if vim.bo.filetype == '' then vim.cmd'Startup | norm j' end

autocmd InsertEnter * :set nohlsearch
autocmd InsertLeave * :set hlsearch

function! SynStack()
  if !exists("*synstack")
    return
	  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" fu! SetBang(v) range
" 	if a:v == 1
" 		normal gv
" 	endif
" 	let l:t = &shellredir
" 	let &shellredir = ">%s\ 2>/dev/tty"
" 	let @" = join(systemlist(input("\"!"))," ")[0:-1]
" 	let &shellredir = l:t
" endf
" nnoremap "! :cal SetBang(0)<cr>
" xnoremap "! :cal SetBang(1)<cr>

au BufRead,BufNewFile *.png set filetype=png
au BufRead,BufNewFile *.jpg set filetype=jpg
au BufRead,BufNewFile *.jpeg set filetype=jpeg
au BufRead,BufNewFile *.gif set filetype=gif
au BufRead,BufNewFile *.bmp set filetype=bmp
au BufRead,BufNewFile *.ico set filetype=ico

" function! TryEnterCode()
" endfunc
" au BufRead,BufNewFile * call TryEnterCode()
]])


