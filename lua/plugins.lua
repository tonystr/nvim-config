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
	{ 'sheerun/vim-polyglot' },
	{ 'tpope/vim-surround', keys = { 'ys', 'ds', 'cs', { 'S', mode = 'v' } } },
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	{ 'nvim-treesitter/nvim-treesitter-context' },
	{ 'tpope/vim-commentary', keys = { { 'gc', mode = { 'n', 'v' } }, 'gcc' } },
	-- { 'vim-scripts/FastFold' } -- NOTE: Not using folds at this time
	{ 'tpope/vim-repeat', event = 'BufRead' },
	{ 'github/copilot.vim', event = 'BufWinEnter' },
	{ 'junegunn/vim-easy-align', keys = {
		{ 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'v' } },
	}},
	{ 'lukas-reineke/indent-blankline.nvim', config = function ()
		require'indent_blankline'.setup {
			show_current_context = true,
		}
	end
	},
	-- 'ThePrimeagen/refactoring.nvim'
	{ 'leafOfTree/vim-vue-plugin', ft = 'vue' },
	{ 'AndrewRadev/splitjoin.vim' }, -- keys = { { 'gS', mode = { 'n', 'v' } }, { 'gJ', mode = { 'n', 'v' } } } },
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
	{ 'vim-test/vim-test' },
	{ 'aurum77/live-server.nvim', config = function()
		require'live_server.util'.install()
	end, cmd = { "LiveServer", "LiveServerStart", "LiveServerStop", } },

	-- Lsp
	{ 'williamboman/mason.nvim', config = function()
		require'mason'.setup()
	end },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'neovim/nvim-lspconfig' },

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
			{ 'roobert/tailwindcss-colorizer-cmp.nvim' },
		},
		config = function()
			local lspkind = require'lspkind'
			local cmp = require'cmp'
			require'tailwindcss-colorizer-cmp'.setup{
				color_square_width = 1,
			}
			cmp.setup{
				formatting = {
					format = function (entry, item)
						lspkind.cmp_format({
							mode = 'symbol', -- show only symbol annotations
							maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						})(entry, item)
						return require'tailwindcss-colorizer-cmp'.formatter(entry, item)
					end
				},
				window = {
					scrollbar = false,
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
	{ 'sindrets/diffview.nvim', config = function()
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
	{ 'barrett-ruth/import-cost.nvim', build = 'sh install.sh npm', config = true },

	{ 'kyazdani42/nvim-web-devicons', lazy = true },

	{ 'folke/zen-mode.nvim', config = function ()
		require'zen-mode'.setup();
	end },

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

	{ 'NvChad/nvim-colorizer.lua', config = function()
		require'colorizer'.setup {
			user_default_options = {
				tailwind = 'both',
			},
		}
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

	-- better text-objects
	{
		"echasnovski/mini.ai",
		-- keys = {
		--   { "a", mode = { "x", "o" } },
		--   { "i", mode = { "x", "o" } },
		-- },
		event = "VeryLazy",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				init = function()
					-- no need to load the plugin, since we only need its queries
					require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
				end,
			},
		},
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				},
			}
		end,
		config = function(_, opts)
			local ai = require("mini.ai")
			ai.setup(opts)
		end,
	},

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
