local vim = vim

local env = require('env')
require('plugins')

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
	if (server.name == "tailwindcss") then goto continue end

	require 'lspconfig'[server.name].setup{
		capabilities = capabilities,
		on_attach = function(client)
			illuminate.on_attach(client)
		end,
	}

	::continue::
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

-- Gitblame configuration
vim.g.gitblame_enabled = 0
vim.g.gitblame_message_template = '		 <author> • <date> • <summary>'
vim.g.gitblame_message_when_no_blame = '		 No blame information available'
vim.g.gitblame_message_when_not_committed = '		 Not committed yet'
vim.g.gitblame_message_when_not_tracked = '		 Not tracked yet'
vim.g.gitblame_message_when_no_repo = '		 No git repository found'
vim.g.gitblame_date_format = '%r'


-- Lualine configuration
require'lualine'.setup {
	sections = {
		-- lualine_c = {{
		-- 	git_blame.get_current_blame_text,
		-- 	cond = git_blame.is_blame_text_available
		-- }},
		lualine_x = {'filetype'}
	}
}

-- Setups
require'gitsigns'.setup()
require'startup'.setup({ theme = 'my_theme' })
require'todo-comments'.setup()
