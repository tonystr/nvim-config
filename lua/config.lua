local vim = vim

require('plugins')

-- Treesitter coniguration

require'nvim-treesitter.install'.compilers = { "clang", "gcc" }
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

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- LSP configuration

local lsp_installer = require'nvim-lsp-installer'
lsp_installer.setup{}

local capabilities = require'cmp_nvim_lsp'.default_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = require'nvim-lsp-installer'.get_installed_servers()
local illuminate = require'illuminate'
for _, server in ipairs(servers) do
	require 'lspconfig'[server.name].setup{
		capabilities = capabilities,
		on_attach = function(client)
			illuminate.on_attach(client)
		end,
	}
end

require'lspconfig'.volar.setup{
  init_options = {
    typescript = {
      tsdk = 'C:\\Users\\Tony\\AppData\\Local\\Yarn\\Data\\global\\node_modules\\typescript\\lib'
      -- Alternative location if installed as root:
      -- tsdk = '/usr/local/lib/node_modules/typescript/lib'
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

local lspkind = require('lspkind')
local cmp = require'cmp'
cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			mode = 'symbol', -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		})
	},
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
	})
})


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
	extensions = {
		file_browser = {
			hijack_netrw = true,
		},
	},
}
-- To get telescope-file-browser loaded and working with telescope,
-- you need to call load_extension, somewhere after setup function:
require'telescope'.load_extension'file_browser'

-- Setups
require'gitsigns'.setup()
require'startup'.setup({ theme = 'my_theme' })
require'todo-comments'.setup()
require'lualine'.setup {
	sections = {
		lualine_x = {'filetype'}
	}
}
