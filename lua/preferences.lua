-- globals
vim.g.mapleader = ' '
vim.g.python3_host_prog = '~/AppData/Local/Programs/Python/Python37-32/python.EXE'
vim.g.lsp_diagnostics_echo_cursor = 1
-- vim.g.indent_blankline_char_blankline = ':'
-- vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.polyglot_disabled = { 'vue' }
vim.g.vimwiki_list = {{ path = '~/OneDrive/vimwiki/', syntax = 'markdown', ext = '.md' }}

vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
vim.g.delimitMate_expand_cr = 1

-- Editor preferences
vim.o.termguicolors = true
vim.wo.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.autoindent = true
vim.o.scrolloff = 5
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
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Hack for setting formatoptions
vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    command = 'setlocal formatoptions-=c formatoptions-=r formatoptions-=o',
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    command = 'ColorizerAttachToBuffer',
})

-- Neovide settings
if vim.g.neovide then
    vim.o.guifont='Cascadia Code:h11.5:#e-subpixelantialias'
    vim.api.nvim_set_hl(0, 'Normal', { bg = '#1f1f28' })
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_refresh_rate_idle = 60
    vim.g.neovide_remember_window_size = true
    vim.g.neovide_confirm_quit = false
	vim.g.neovide_floating_opacity = 1.0
    vim.g.neovide_hide_mouse_when_typing = true
    -- vim.g.neovide_cursor_animate_command_line = false
else
    vim.api.nvim_set_hl(0, 'Normal', { ctermbg='none', bg='none' })
end
