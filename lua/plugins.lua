
-- TODO: nvim lualine

require'packer'.startup(function(use)

	-- Misc
	use { 'wbthomason/packer.nvim' }
	use { 'lewis6991/impatient.nvim', config = function()
		require'impatient'
	end }
	use { 'sheerun/vim-polyglot', event = 'BufRead' }
	use { 'tpope/vim-surround' }
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use { 'nvim-treesitter/nvim-treesitter-context' }
	use { 'tpope/vim-commentary', event = 'BufRead' }
	use { 'vim-scripts/FastFold' }
	use { 'tpope/vim-repeat', event = 'BufRead' }
	use { 'github/copilot.vim', event = 'BufRead' }
	use { 'kana/vim-textobj-user', event = 'BufRead' } -- NOTE: Learn some text objects or uninstall
	-- use { 'RishabhRD/nvim-cheat.sh', requires = 'RishabhRD/popfix' }
	use { 'junegunn/vim-easy-align', event = 'BufRead' }
	-- use 'lukas-reineke/indent-blankline.nvim'
	-- use 'ThePrimeagen/refactoring.nvim'
	use { 'leafOfTree/vim-vue-plugin', event = 'BufRead' }
	use { 'tpope/vim-unimpaired', event = 'BufRead' }
	use { 'AndrewRadev/splitjoin.vim', event = 'BufRead' }
	use { 'prettier/vim-prettier', event = 'BufRead' }
	use { 'mattn/emmet-vim', keys = { { 'n', '<C-h>' }, { 'n', '<C-y>' }, { 'i', '<C-h>' }, { 'i', '<C-y>' } } }

	-- Lsp
	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'
	use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline' }}
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use { 'onsails/lspkind.nvim', requires = 'nvim-cmp' }
	use 'ray-x/lsp_signature.nvim'

	-- Git
	use { 'tpope/vim-fugitive' }
	use { 'lewis6991/gitsigns.nvim', event = 'BufRead', config = function()
		require'gitsigns'.setup()
	end}
	use { 'f-person/git-blame.nvim', keys = { 'n', '<leader>gbl' } }
	use { 'sindrets/diffview.nvim', event = 'BufRead', config = function()
		require('diffview').setup({
			enhanced_diff_hl = true,
			view = {
				merge_tool = {
					layout = 'diff3_mixed',
				},
			},
		})
	end}

	use { 'akinsho/toggleterm.nvim', tag = '*', config = function()
		require('toggleterm').setup({
			float_opts = {
				border = 'curved',
			},
		})
	end}

	-- UI
	use 'kyazdani42/nvim-web-devicons'
	use { 'romgrk/barbar.nvim', requires = 'nvim-web-devicons', config = function()
		require'bufferline'.setup{
			auto_hide = true,
			icon_cusom_colors = true,
			icon_separator_active = '',
			icon_separator_inactive = '',
			-- icon_close_tab = '',
		}
	end}
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = 'nvim-lua/plenary.nvim' }
	use { 'stevearc/dressing.nvim', after = 'telescope.nvim' }
	use { 'startup-nvim/startup.nvim', config = function()
		require'startup'.setup({ theme = 'my_theme' })
	end}
	use { 'folke/todo-comments.nvim', event = 'BufRead', config = function()
		require'todo-comments'.setup()
	end}
	use 'kevinhwang91/promise-async'
	use { 'norcalli/nvim-colorizer.lua', config = function()
		require'colorizer'.setup{}
	end}
	use { 'RRethy/vim-illuminate' } -- Required because its used in $LUACONF
	use {
		'nvim-neo-tree/neo-tree.nvim',
		requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim", },
		branch = "v2.x",
		keys = { { 'n', '<leader>e' }, { 'n', '<leader>e' } }
	}
	use { 'nvim-lualine/lualine.nvim', event = 'BufRead', config = function()
		require'lualine'.setup {
			sections = { lualine_x = {'filetype'} }
		}
	end}
	use 'folke/which-key.nvim'

	-- Themes
	use 'rebelot/kanagawa.nvim'
end)

luasnip = require 'luasnip'

-- require'neoscroll'.setup{}
-- require'neoscroll.config'.set_mappings({
-- 	['<C-u>'] = { 'scroll', { '-vim.wo.scroll', 'true', '100' }},
-- 	['<C-d>'] = { 'scroll', { 'vim.wo.scroll', 'true', '100' }},
-- })
-- require'indent_blankline'.setup { show_current_context = true }

-- NOTE: Plugins to check out in the future
-- neogen: keybinding to create documentation comments
-- hlargs.nvim: highlight arguments differently from variables
-- use 'norcalli/nvim-colorizer.lua' -- BUG: doesn't work
-- use 'nvim-neorg/neorg' -- Learn this if you want to use it
-- use 'tpope/vim-speeddating' -- NOTE: Why have this if you dont know how to use it
-- use 'christoomey/vim-titlecase' -- NOTE: Why have this if you dont know how to use it
-- use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons', config = function()
-- end}
-- use { 'tiagovla/scope.nvim', config = function()
-- 	require'scope'.setup{}
-- end}
-- use 'windwp/nvim-ts-autotag' -- WARN: think this works i just never enabled it
-- use 'kevinhwang91/nvim-ufo' -- BUG: doesn't work
-- use 'yuttie/comfortable-motion.vim' -- cool inertia scroll but wonk??
