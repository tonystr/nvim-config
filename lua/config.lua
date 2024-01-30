-- local env = require('env')

vim.o.guicursor = 'n-v-c-ci-sm:block,i-ve:ver25,r-cr-o:hor20'
vim.o.showbreak = '  󱞩 '

-- vim.opt.statuscolumn = "%s %{foldlevel(v:lnum) <= foldlevel(v:lnum-1) ? ' ' : (foldclosed(v:lnum) == -1 ? '' : '')} %{v:relnum ? v:relnum : v:lnum} "

-- vim.g.formatprg = 'prettier --parser typescript --stdin-path %';

local Signse = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(Signse) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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
vim.g.gitblame_enabled = 0
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

local set_root = function()
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

local root_augroup = vim.api.nvim_create_augroup('CustomAutoRoot', {})
vim.api.nvim_create_autocmd('BufEnter', { group = root_augroup, callback = set_root })
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
autocmd BufNewFile ~/OneDrive/vimwiki/diary/[0-9\-]*.md :silent 0!echo \# %:t:r
autocmd BufNewFile ~/OneDrive/vimwiki/diary/[0-9\-]*.md :silent r ~/OneDrive/vimwiki/diary/template.md
autocmd BufNewFile ~/OneDrive/vimwiki/diary/[0-9\-]*.md :norm jwv$
autocmd BufNewFile ~/OneDrive/vimwiki/startups/[a-zA-Z0-9\-_]*.md :silent 0!echo \# %:t:r
autocmd BufNewFile ~/OneDrive/vimwiki/startups/[a-zA-Z0-9\-_]*.md :silent r ~/OneDrive/vimwiki/startups/template.md

" vimwiki work template
autocmd BufNewFile ~/OneDrive/work/diary/[0-9\-]*.md :silent 0!echo \# %:t:r
autocmd BufNewFile ~/OneDrive/work/diary/[0-9\-]*.md :silent r ~/OneDrive/work/diary/template.md

" vimwiki entrepreneurship template
autocmd BufNewFile ~/OneDrive/entrepreneurship/diary/[0-9\-]*.md :silent 0!echo \# %:t:r
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

