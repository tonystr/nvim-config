local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

local jsfts = { 'js', 'ts', 'jsx', 'tsx', 'vue' };

require'lazy'.setup({

	-- Misc
	{ 'tpope/vim-surround', keys = { 'ys', 'ds', 'cs', { 'S', mode = 'v' }, { 'gS', mode = 'v' } } },
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	{ 'nvim-treesitter/nvim-treesitter-context' },
	{ 'tpope/vim-commentary', keys = { { 'gc', mode = { 'n', 'v' } }, 'gcc' } },
	-- { 'vim-scripts/FastFold' } -- NOTE: Not using folds at this time
	{ 'tpope/vim-repeat', event = 'BufRead' },
	{ 'github/copilot.vim', event = 'BufWinEnter' },
	{ 'kana/vim-textobj-user', event = 'BufRead' }, -- NOTE: Learn some text objects or uninstall
	{ 'junegunn/vim-easy-align', keys = {
		{ 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'v' } },
	}},
	-- 'lukas-reineke/indent-blankline.nvim'
	-- 'ThePrimeagen/refactoring.nvim'
	{ 'leafOfTree/vim-vue-plugin', ft = 'vue' },
	{ 'AndrewRadev/splitjoin.vim', keys = { { 'gS', mode = { 'n', 'v' } }, { 'gJ', mode = { 'n', 'v' } } } },
	{ 'prettier/vim-prettier', cmd = 'Prettier', ft = jsfts },
	{ 'mattn/emmet-vim', keys = {
		{ '<Plug>(emmet-expand-abbr)' },
		{ '<Plug>(emmet-expand-abbr)', mode = 'i' },
		{ '<Plug>(emmet-expand-yank)' },
		{ '<Plug>(emmet-expand-yank)', mode = 'i' },
	}},
	{ 'folke/persistence.nvim', lazy = true, config = function()
		require'persistence'.setup()
	end },

	-- Lsp
	'neovim/nvim-lspconfig',
	'williamboman/nvim-lsp-installer',
	{ 'L3MON4D3/LuaSnip', lazy = true },
	{ 'saadparwaiz1/cmp_luasnip', lazy = true },
	{ 'onsails/lspkind.nvim', lazy = true },
	{ 'RRethy/vim-illuminate', lazy = true },
	-- { 'joechrisellis/lsp-format-modifications.nvim', lazy = true },
	{ 'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp'  },
			{ 'hrsh7th/cmp-buffer'    },
			{ 'hrsh7th/cmp-path'      },
			{ 'hrsh7th/cmp-cmdline'   },
			{ 'RRethy/vim-illuminate' },
		},
		config = function()
			local lspkind = require'lspkind'
			local cmp = require'cmp'
			cmp.setup{
				formatting = {
					format = lspkind.cmp_format({
						mode = 'symbol', -- show only symbol annotations
						maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
					})
				},
				mapping = cmp.mapping.preset.insert {
					['<CR>'] = cmp.mapping.confirm { select = true },
				},
				snippet = {
					expand = function(args)
						require'luasnip'.lsp_expand(args.body)
					end,
				},
				sources = cmp.config.sources(
					{ { name = 'nvim_lsp' } },
					{ { name = 'buffer' } }
				)
			}
		end
	},

	-- Git
	{ 'tpope/vim-fugitive' },
	{ 'lewis6991/gitsigns.nvim', event = 'BufRead', config = function()
		require'gitsigns'.setup()
	end},
	{ 'f-person/git-blame.nvim', keys = { { '<leader>gbl', '<cmd>GitBlameToggle<cr>' } } },
	{ 'sindrets/diffview.nvim', lazy = true, config = function()
		require('diffview').setup({
			enhanced_diff_hl = true,
			view = {
				merge_tool = {
					layout = 'diff3_mixed',
				},
			},
		})
	end},

	-- Terminal & lazygit
	{ 'akinsho/toggleterm.nvim',
		version = '*',
		keys = {
			'<leader>gg',
			{ '<leader>tt', '<cmd>ToggleTerm<cr>' },
		},
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
					},
				},
			})

			vim.keymap.set('n', '<leader>gg', function()
				lazygit:toggle()
			end)
		end,
	},

	-- UI

	-- not work
	-- { 'barrett-ruth/import-cost.nvim', build = 'echo HELLO', config = function ()
	-- 	require'import-cost'.setup()
	-- end },

	{ 'kyazdani42/nvim-web-devicons', lazy = true },

	{ 'romgrk/barbar.nvim', dependencies = 'nvim-web-devicons', event='BufWinEnter', config = function()
		require'bufferline'.setup{
			auto_hide = true,
			icon_cusom_colors = true,
			icon_separator_active = '',
			icon_separator_inactive = '',
			-- icon_close_tab = '',
		}
	end},

	{ 'nvim-telescope/telescope.nvim', cmd = 'Telescope', version = '0.1.0', dependencies = 'nvim-lua/plenary.nvim', config = function ()
		require'telescope'.setup {
			defaults = {
				layout_strategy = 'vertical',
				layout_config = {
					vertical = { width = 0.8 }
				},
				file_ignore_patterns = { 'collab-onboard/.*' },
			},
		}
	end },

	{ 'stevearc/dressing.nvim', event = 'VeryLazy' },

	{ 'startup-nvim/startup.nvim',
		-- cmd = 'Startup', BUG: populates search (/) register with \s\+$ on startup
		-- init = function()
		-- 	vim.api.nvim_create_autocmd('VimEnter', { callback = function()
		-- 		if vim.fn.argc() == 0 and vim.fn.line2byte('$') == -1 then
					-- vim.cmd('Startup')
					-- vim.cmd('bd 1')
				-- end
			-- end })
		-- end,
		config = function()
			-- vim.g.startup_disable_on_startup = true
			require'startup'.setup({ theme = 'my_theme' })
		end
	},

	{ 'folke/todo-comments.nvim', event = 'BufRead', config = function()
		require'todo-comments'.setup()
	end},

	{ 'folke/twilight.nvim', cmd = 'Twilight' },

	{ 'kevinhwang91/promise-async', lazy = true },

	{ 'norcalli/nvim-colorizer.lua', config = function()
		require'colorizer'.setup{}
	end},

	{
		'nvim-neo-tree/neo-tree.nvim',
		dependencies = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim", },
		branch = "v2.x",
		keys = {
			{ '<leader>e', '<cmd>NeoTreeFocusToggle<cr>' },
			{ '<leader>o', '<cmd>NeoTreeFocus<cr>' }
		},
		config = function()
			require'neo-tree'.setup{
				disable_netrw = true,
			}
		end,
	},
	{ 'nvim-lualine/lualine.nvim', event = 'BufWinEnter', config = function()
		require'lualine'.setup {
			sections = { lualine_x = {'filetype'} },
		}
	end},
	{ 'folke/which-key.nvim', cmd = 'WhichKey' },

	-- Theme
	'rebelot/kanagawa.nvim'
})

luasnip = require 'luasnip'

-- Below you'll find the land of the lost

-- require'indent_blankline'.setup { show_current_context = true },
-- neogen: keybinding to create documentation comments
-- hlargs.nvim: highlight arguments differently from variables
-- 'nvim-neorg/neorg' -- Learn this if you want to use it
-- 'tpope/vim-speeddating' -- NOTE: Why have this if you dont know how to use it
-- 'christoomey/vim-titlecase' -- NOTE: Why have this if you dont know how to use it
-- 'windwp/nvim-ts-autotag' -- WARN: think this works i just never enabled it
-- 'kevinhwang91/nvim-ufo' -- BUG: doesn't work
-- { 'tpope/vim-unimpaired', event = 'BufRead' } -- NOTE: Never used any of the bindings
