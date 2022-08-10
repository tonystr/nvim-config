
require'packer'.startup(function(use)

	-- Misc
	use 'wbthomason/packer.nvim'
	use 'sheerun/vim-polyglot'
	use 'tpope/vim-surround'
	use 'karb94/neoscroll.nvim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'kyazdani42/nvim-web-devicons'
	use 'tpope/vim-commentary'
	use 'vim-scripts/FastFold'
	use 'tpope/vim-repeat'
	use 'github/copilot.vim'
	use 'kana/vim-textobj-user' -- NOTE: Learn some text objects or uninstall
	use { 'RishabhRD/nvim-cheat.sh', requires = 'RishabhRD/popfix' }

	-- Lsp
	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'
	use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline' }}
	use { 'onsails/lspkind.nvim', requires = 'nvim-cmp' }
	use 'ray-x/lsp_signature.nvim'

	-- Git
	use 'tpope/vim-fugitive'
	use 'lewis6991/gitsigns.nvim'

	-- UI
	use { 'romgrk/barbar.nvim', requires = 'nvim-web-devicons', config = function()
		require'bufferline'.setup{
			auto_hide = true,
			icon_cusom_colors = true,
			icon_separator_active = '',
			icon_separator_inactive = '',
			icon_close_tab = '',
		}
	end}
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = 'nvim-lua/plenary.nvim' }
	use { 'stevearc/dressing.nvim', after = 'telescope.nvim' } -- NOTE: Still not sure what this does, rename popup menu?
	use { 'folke/trouble.nvim', requires = 'nvim-web-devicons', config = function()
		require'trouble'.setup{}
	end}
	use 'startup-nvim/startup.nvim'
	use 'folke/todo-comments.nvim'
	use 'kevinhwang91/promise-async'
	use 'norcalli/nvim-colorizer.lua'
	use 'RRethy/vim-illuminate'

	-- Themes
	use 'JoosepAlviste/palenightfall.nvim'
	use 'rebelot/kanagawa.nvim'
	use 'mattn/emmet-vim'
end)

require'colorizer'.setup{}
require'neoscroll'.setup()

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
