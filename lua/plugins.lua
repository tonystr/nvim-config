
-- TODO: nvim lualine

require'packer'.startup(function(use)

	-- Misc
	use 'wbthomason/packer.nvim'
	use 'lewis6991/impatient.nvim'
	use 'sheerun/vim-polyglot'
	use 'tpope/vim-surround'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'nvim-treesitter/nvim-treesitter-context'
	use 'tpope/vim-commentary'
	use 'vim-scripts/FastFold'
	use 'tpope/vim-repeat'
	use 'github/copilot.vim'
	use 'kana/vim-textobj-user' -- NOTE: Learn some text objects or uninstall
	-- use { 'RishabhRD/nvim-cheat.sh', requires = 'RishabhRD/popfix' }
	use 'junegunn/vim-easy-align'
	-- use 'lukas-reineke/indent-blankline.nvim'
	-- use 'ThePrimeagen/refactoring.nvim'
	use 'leafOfTree/vim-vue-plugin'
	use 'AndrewRadev/inline_edit.vim'
	use 'tpope/vim-unimpaired'
	use 'AndrewRadev/splitjoin.vim'
	use 'prettier/vim-prettier'

	-- Lsp
	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'
	use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline' }}
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use { 'onsails/lspkind.nvim', requires = 'nvim-cmp' }
	use 'ray-x/lsp_signature.nvim'

	-- Git
	use 'tpope/vim-fugitive'
	use 'lewis6991/gitsigns.nvim'
	use 'f-person/git-blame.nvim'

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
	-- use 'karb94/neoscroll.nvim'
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = 'nvim-lua/plenary.nvim' }
	use 'nvim-telescope/telescope-file-browser.nvim'
	use { 'stevearc/dressing.nvim', after = 'telescope.nvim' }
	use 'startup-nvim/startup.nvim'
	use 'folke/todo-comments.nvim'
	use 'kevinhwang91/promise-async'
	use 'norcalli/nvim-colorizer.lua'
	use 'RRethy/vim-illuminate'
	use { 'nvim-neo-tree/neo-tree.nvim', requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim", }, branch = "v2.x" }
	use 'nvim-lualine/lualine.nvim'
	use 'folke/which-key.nvim'
	use 'sudormrfbin/cheatsheet.nvim'
	use { 'pwntester/octo.nvim', requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim', 'kyazdani42/nvim-web-devicons', }, config = function()
		require'octo'.setup()
	end }

	-- Themes
	use 'rebelot/kanagawa.nvim'

	use 'mattn/emmet-vim'
end)

luasnip = require 'luasnip'

require'colorizer'.setup{}
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
