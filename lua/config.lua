local env = require('env')

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
	}
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
local illuminate = require'illuminate'
m.setup_handlers {
	function (server)
		require'lspconfig'[server].setup{
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				illuminate.on_attach(client)
				-- require 'lsp-format-modifications'.attach(client, bufnr)
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


vim.g.vim_vue_plugin_config = {
	syntax = {
		template = { 'html' },
		script = { 'javascript', 'typescript' },
		style = { 'scss' },
	},
	full_syntax = {},
	initial_indent = {},
	attribute = 0,
	keyword = 0,
	foldexpr = 0,
	debug = 0,
}

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

function! SynStack()
  if !exists("*synstack")
    return
	  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

]])

