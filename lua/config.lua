local env = require('env')

vim.api.nvim_create_autocmd('FileType', {
	pattern = '*',
	command = 'ColorizerAttachToBuffer',
})

-- Treesitter coniguration

local tsi = require'nvim-treesitter.install'
tsi.compilers = { "zig", "clang", "gcc" }
tsi.prefer_git = false

require'nvim-treesitter.configs'.setup {
	ensure_installed = {},
	sync_install = false,
	auto_install = true,
	ignore_install = { "markdown" }, -- F U Markdown developer!! it doesn't work
	highlight = {
		enable = true,
		disable = { "markdown" },
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<C-n>',
			node_incremental = '<C-n>',
			scope_incremental = '<C-m>',
			node_decremental = '<C-r>',
		},
	},
}

-- LSP configuration

local m = require'mason-lspconfig'

m.setup {
	ensure_installed = { 'tsserver', 'volar' },
}

local capabilities = require'cmp_nvim_lsp'.default_capabilities(
	vim.lsp.protocol.make_client_capabilities()
)
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
local illuminate = require'illuminate'
illuminate.configure {
	modes_allowlist = { 'n' },
	filetypes_denylist = { 'help', 'qf', 'fugitive', 'vimwiki' },
	min_count_to_highlight = 2,
}
m.setup_handlers {
	function (server)
		require'lspconfig'[server].setup{
			capabilities = capabilities,
			on_attach = function(client)
				illuminate.on_attach(client)
			end,
			settings = {
				Lua = {
					runtime = {
						version = 'LuaJIT',
					},
					diagnostics = {
						globals = {
							'vim',
							'describe',
							'it',
						}
					},
					telemetry = {
						enable = false,
					}
				}
			},
			init_options = {
				typescript = {
					tsdk = env.tsdk
				}
			}
		}
	end
}
require'ufo'.setup()

-- require'lspconfig'.volar.setup{
--   init_options = {
--     typescript = {
--       tsdk = env.tsdk
--     }
--   }
-- }

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
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
	-- 	return '<CR>???';
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
local root_names = { '.git', 'package.json', 'node_modules', 'yarn.lock' }
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
autocmd BufNewFile ~/OneDrive/vimwiki/startups/[a-zA-Z0-9\-_]*.md :silent 0!echo \# %:t:r
autocmd BufNewFile ~/OneDrive/vimwiki/startups/[a-zA-Z0-9\-_]*.md :silent r ~/OneDrive/vimwiki/startups/template.md

autocmd User TelescopePreviewerLoaded setlocal number

function! SynStack()
  if !exists("*synstack")
    return
	  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

]])

