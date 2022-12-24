require'packer'.startup(function(use)

	-- Core
	use { 'wbthomason/packer.nvim' }
	use { 'lewis6991/impatient.nvim', config = function()
		require'impatient'
	end }

	-- Misc
	-- use { 'sheerun/vim-polyglot', event = 'BufRead' }
	use { 'tpope/vim-surround', keys = {{'n', 'ys'}} }
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use { 'nvim-treesitter/nvim-treesitter-context' }
	use { 'tpope/vim-commentary', event = 'BufRead' }
	-- use { 'vim-scripts/FastFold' } -- NOTE: Not using folds at this time
	use { 'tpope/vim-repeat', event = 'BufRead', keys = {{'n', 'gc'}, {'v', 'gc'}} }
	use { 'github/copilot.vim', event = 'BufWinEnter' }
	use { 'kana/vim-textobj-user', event = 'BufRead' } -- NOTE: Learn some text objects or uninstall
	use { 'junegunn/vim-easy-align', keys = {{'n', 'ga'}}, config = function()
		vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', {});
		vim.keymap.set('v', 'ga', '<Plug>(EasyAlign)', {});
	end}
	-- use 'lukas-reineke/indent-blankline.nvim'
	-- use 'ThePrimeagen/refactoring.nvim'
	use { 'leafOfTree/vim-vue-plugin', event = 'BufRead' }
	use { 'AndrewRadev/splitjoin.vim', keys = {{'n', 'gS'}, {'n', 'gJ'}} }
	use { 'prettier/vim-prettier', cmd = 'Prettier' }
	use { 'mattn/emmet-vim', keys = { { 'n', '<C-h>' }, { 'n', '<C-y>' }, { 'i', '<C-h>' }, { 'i', '<C-y>' } }, config = function()
		vim.keymap.set('n', '<C-h>', '<Plug>(emmet-expand-abbr)', {});
		vim.keymap.set('n', '<C-y>', '<Plug>(emmet-expand-yank)', {});
		vim.keymap.set('i', '<C-h>', '<Plug>(emmet-expand-abbr)', {});
		vim.keymap.set('i', '<C-y>', '<Plug>(emmet-expand-yank)', {});
	end }
	use { 'folke/persistence.nvim', config = function()
		require'persistence'.setup()
	end }

	-- Lsp
	use 'neovim/nvim-lspconfig'
	use 'williamboman/nvim-lsp-installer'
	use { 'hrsh7th/nvim-cmp', requires = {
		{ 'hrsh7th/cmp-nvim-lsp', before = 'nvim-cmp' },
		{ 'hrsh7th/cmp-buffer',   before = 'nvim-cmp' },
		{ 'hrsh7th/cmp-path',     before = 'nvim-cmp' },
		{ 'hrsh7th/cmp-cmdline',  before = 'nvim-cmp' },
	}}
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use { 'onsails/lspkind.nvim', requires = 'nvim-cmp' }
	use 'ray-x/lsp_signature.nvim'

	-- Git
	use { 'tpope/vim-fugitive' }
	use { 'lewis6991/gitsigns.nvim', event = 'BufRead', config = function()
		require'gitsigns'.setup()
	end}
	use { 'f-person/git-blame.nvim', keys = { 'n', '<leader>gbl' }, config = function()
		vim.keymap.set('n', '<leader>gbl', ':GitBlameToggle<CR>', {});
	end }
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

	-- Terminal & lazygit
	use { 'akinsho/toggleterm.nvim',
		tag = '*',
		config = function()
			require('toggleterm').setup({
				float_opts = {
					border = 'curved',
				},
			})

			-- Toggleterm lazygit

			local Terminal  = require('toggleterm.terminal').Terminal
			local lazygit = Terminal:new({
				cmd = 'lazygit',
				direction = 'float',
				hiddden = true,
				float_opts = {
					border = 'curved',
					highlights = {
						border = "Comment",
						background = "Normal",
					}
				}
			})

			vim.keymap.set('n', '<leader>gg', function() lazygit:toggle() end, {});
			vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', {});
		end,
		keys = { '<leader>gg', '<leader>tt' },
	}

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
	use { 'startup-nvim/startup.nvim',
		cmd = { 'Startup' },
		setup = function()
			vim.api.nvim_create_autocmd('VimEnter', { callback = function()
				if vim.fn.argc() == 0 and vim.fn.line2byte('$') == -1 then
					vim.cmd('Startup display')
					vim.cmd('bd 1')
				end
			end })
		end,
		config = function()
			require'startup'.setup({ theme = 'my_theme' })
		end
	}
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
		keys = { { 'n', '<leader>e' }, { 'n', '<leader>o' } },
		config = function()
			vim.keymap.set('n', '<leader>e', ':NeoTreeShowToggle<CR>')
			vim.keymap.set('n', '<leader>o', ':NeoTreeFocus<CR>')
		end,
	}
	use { 'nvim-lualine/lualine.nvim', event = 'BufWinEnter', config = function()
		require'lualine'.setup {
			sections = { lualine_x = {'filetype'} }
		}
	end}
	use 'folke/which-key.nvim'

	-- Themes
	use 'rebelot/kanagawa.nvim'
end)

luasnip = require 'luasnip'

-- Below you'll find the land of the lost

-- require'indent_blankline'.setup { show_current_context = true }
-- neogen: keybinding to create documentation comments
-- hlargs.nvim: highlight arguments differently from variables
-- use 'nvim-neorg/neorg' -- Learn this if you want to use it
-- use 'tpope/vim-speeddating' -- NOTE: Why have this if you dont know how to use it
-- use 'christoomey/vim-titlecase' -- NOTE: Why have this if you dont know how to use it
-- use 'windwp/nvim-ts-autotag' -- WARN: think this works i just never enabled it
-- use 'kevinhwang91/nvim-ufo' -- BUG: doesn't work
-- use { 'tpope/vim-unimpaired', event = 'BufRead' } -- NOTE: Never used any of the bindings
