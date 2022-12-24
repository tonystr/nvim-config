local env = require('env')

-- Treesitter coniguration

local tsi = require'nvim-treesitter.install'
tsi.compilers = { "clang", "gcc" }
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

local lsp_installer = require'nvim-lsp-installer'
lsp_installer.setup{}

local capabilities = require'cmp_nvim_lsp'.default_capabilities(
	vim.lsp.protocol.make_client_capabilities()
)
local servers = require'nvim-lsp-installer'.get_installed_servers()
local illuminate = require'illuminate'
for _, server in ipairs(servers) do
	require 'lspconfig'[server.name].setup{
		capabilities = capabilities,
		on_attach = function(client)
			illuminate.on_attach(client)
		end,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" }
				}
			}
		}
	}
end

require'lspconfig'.volar.setup{
  init_options = {
    typescript = {
      tsdk = env.tsdk
    }
  }
}

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.o.completeopt = 'menuone,noselect'

-- cmp configuration


-- Emmet snippets

vim.g.polyglot_disabled = { 'vue' }
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

-- Telescope configuration

require'telescope'.setup {
	defaults = {
		layout_strategy = 'vertical',
		layout_config = {
			vertical = { width = 0.8 }
		},
	},
}

-- Gitblame configuration
vim.g.gitblame_enabled = 0
vim.g.gitblame_message_template = '		 <author> • <date> • <summary>'
vim.g.gitblame_message_when_no_blame = '		 No blame information available'
vim.g.gitblame_message_when_not_committed = '		 Not committed yet'
vim.g.gitblame_message_when_not_tracked = '		 Not tracked yet'
vim.g.gitblame_message_when_no_repo = '		 No git repository found'
vim.g.gitblame_date_format = '%r'

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
]])
