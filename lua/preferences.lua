
local term_buf = nil
local term_buf_was_insert = true

-- Neovide settings ===> !== ====== ---------
if vim.g.neovide then
	vim.o.guifont='CaskaydiaCove Nerd Font:h11.8:#e-subpixelantialias'
	-- vim.o.guifont='RecMonoLinear Nerd Font:h11.6:#e-subpixelantialias'
	vim.api.nvim_set_hl(0, 'Normal', { bg = '#1f1f28' })
	vim.g.neovide_refresh_rate = 90
	vim.g.neovide_refresh_rate_idle = 90
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_confirm_quit = false
	vim.g.neovide_floating_opacity = 1.0
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_floating_shadow = false
	vim.g.neovide_cursor_animate_command_line = false

	vim.g.neovide_scroll_animation_length = 0.14
	vim.g.neovide_scroll_animation_far_lines = 50
	vim.g.neovide_position_animation_length = 0

	vim.g.neovide_cursor_trail_size = 0.5
	vim.g.neovide_window_blurred = false
	vim.g.neovide_floating_blur_amount_x = 0.0
	vim.g.neovide_floating_blur_amount_y = 0.0
	vim.g.neovide_underline_stroke_scale = 2.0

	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_title_background_color = string.format(
		"%x",
		vim.api.nvim_get_hl(0, {id=vim.api.nvim_get_hl_id_by_name("Normal")}).bg
	)

	-- Show file path in window decoration title
	vim.o.titlestring = "%f"
	vim.o.title = true

	vim.keymap.set('t', '<C-z>', function()
		vim.cmd'b#'
		term_buf_was_insert = true
	end, { noremap = true });

	vim.keymap.set('t', '<M-w>', function()
		vim.cmd'bd!'
	end, { noremap = true });

	vim.keymap.set('n', '<C-z>', function()
		if
			term_buf ~= nil and
			vim.api.nvim_buf_is_valid(term_buf) and
			vim.api.nvim_get_current_buf() == term_buf
		then
			term_buf_was_insert = false
			vim.cmd'b#'
		else
			if term_buf == nil or not vim.api.nvim_buf_is_valid(term_buf) then
				term_buf = vim.api.nvim_create_buf(false, true) -- no file, scratch buffer

				vim.api.nvim_set_current_buf(term_buf)
				vim.cmd.terminal'nu'

				-- Focus input
				vim.cmd'norm i'
			else
				vim.api.nvim_set_current_buf(term_buf)

				if term_buf_was_insert then
					-- Focus input
					vim.cmd'norm i'
				end
			end
		end
	end, { noremap = true });

	vim.api.nvim_create_autocmd('TermOpen', {
		pattern = "*",
		callback = function()
			vim.opt_local.winhighlight = 'Normal:TerminalBackground'
			vim.opt_local.filetype = 'nvim-terminal'

			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
		end
	})

	vim.api.nvim_set_hl(0, 'TerminalBackground', { bg = '#16161d' })

	local is_linux = vim.uv.os_uname().sysname == 'Linux'
else
	vim.api.nvim_set_hl(0, 'Normal', { ctermbg='none', bg='none' })
end

vim.g.flog_permanent_default_opts = {
    date = 'relative',
}
-- vim.opt.statuscolumn = "%s%{foldlevel(v:lnum) <= foldlevel(v:lnum-1) ? ' ' : (foldclosed(v:lnum) == -1 ? '' : '')} %{v:relnum ? v:relnum : v:lnum} "

local _border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover, {
		border = _border
	}
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
	vim.lsp.handlers.signature_help, {
		border = _border
	}
)

vim.diagnostic.config{
	float = { border = _border }
}

-- globals
vim.g.mapleader = ' '
vim.g.python3_host_prog = '~/AppData/Local/Programs/Python/Python37-32/python.EXE'
vim.g.lsp_diagnostics_echo_cursor = 1
-- vim.g.indent_blankline_char_blankline = ':'
-- vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.polyglot_disabled = { 'vue' }
vim.g.vimwiki_list = {
	{ path = '~/OneDrive/vimwiki/',          syntax = 'markdown', ext = '.md' },
	{ path = '~/OneDrive/work/',             syntax = 'markdown', ext = '.md' },
	{ path = '~/OneDrive/projects/',         syntax = 'markdown', ext = '.md' },
}

vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
vim.g.delimitMate_expand_cr = 1
vim.g.shada = 'NONE'
vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'
-- vim.o.grepformat = vim.o.grepformat .. '%f:%l:%c:%m'

-- Editor preferences
vim.o.termguicolors = true
vim.wo.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.autoindent = true
vim.o.scrolloff = 1
vim.o.sidescrolloff = 10
vim.o.mouse = 'a'
vim.o.wrap = false -- Instead of nowrap
vim.o.encoding = 'UTF-8'
vim.o.formatoptions = 'qlj'
vim.o.path = vim.o.path .. '**'
vim.o.wildmenu = true
vim.o.wildignore = '**/node_modules/**'
vim.o.hidden = true
vim.o.showmode = false
vim.o.signcolumn = 'yes' -- Always show gutter
vim.o.ignorecase = true -- Ignore case when searching
vim.o.smartcase = true -- Case sensitive if caps or "\C"
vim.o.undofile = true -- Enable undo history
vim.o.clipboard = ''

-- Folding
vim.o.foldcolumn = '0'
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldminlines = 4
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.api.nvim_create_user_command(
	'Delete',
	function()
		vim.cmd'call delete(@%) | BufferDelete!'
	end,
	{}
)

-- Hack for setting formatoptions
vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    command = 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o',
})

vim.cmd [[
augroup RestoreCursor
autocmd!
autocmd BufRead * autocmd FileType <buffer> ++once
\ let s:line = line("'\"")
\ | if s:line >= 1 && s:line <= line("$") && &filetype !~# 'commit'
\      && index(['xxd', 'gitrebase'], &filetype) == -1
\ |   execute "normal! g`\""
\ | endif
augroup END
]]

vim.api.nvim_create_autocmd({'BufLeave'}, {
	pattern = '*',
	callback = function()
		if vim.fn.bufname('%') ~= '' and vim.fn.empty(vim.fn.expand('%:p')) == 0 then
			local success, err = pcall(function() vim.cmd('silent mkview') end)
		end
	end,
})

vim.api.nvim_create_autocmd({'BufWinLeave'}, {
	pattern = '*',
	callback = function(_)
		-- vim.g.neovide_scroll_animation_length = 0.0
		vim.g.neovide_cursor_animation_length = 0.0
		vim.g.neovide_position_animation_length = 0.0
		-- vim.g.neovide_scroll_animation_far_lines = 0
	end,
})

vim.api.nvim_create_autocmd({'BufWinEnter'}, {
	pattern = '*',
	callback = function(_)
		if
			vim.fn.bufname('%') ~= '' and
			vim.fn.filereadable(vim.fn.expand('%'))
		then
			local success, err = pcall(function() vim.cmd('silent loadview') end)
		end
		vim.defer_fn(function()
			-- vim.g.neovide_scroll_animation_length = 0.14
			vim.g.neovide_cursor_animation_length = 0.06
			vim.g.neovide_position_animation_length = 0.15
			-- vim.g.neovide_scroll_animation_far_lines = 50
		end, 200)
	end,
})

vim.api.nvim_create_autocmd({'WinLeave'}, {
	pattern = '*',
	callback = function(args)
		if 
			vim.fn.bufname('%') ~= '' and
			vim.fn.filereadable(vim.fn.expand('%'))
		then
			vim.api.nvim_set_option_value('relativenumber', false, { win = args.win })
		end
	end
})

vim.api.nvim_create_autocmd({'WinEnter'}, {
	pattern = '*',
	callback = function(args)
		if 
			vim.fn.bufname('%') ~= '' and
			vim.fn.filereadable(vim.fn.expand('%'))
		then
			vim.api.nvim_set_option_value('relativenumber', true, { win = args.win })
		end
	end
})

