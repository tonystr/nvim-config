
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

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.setup{}

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
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

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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

-- Setups

require'bufferline'.setup{}
require'gitsigns'.setup()
require'startup'.setup({ theme = 'my_theme' })
require'todo-comments'.setup()
-- require'ufo'.setup{ fold_virt_text_handler = ufo_handler }
