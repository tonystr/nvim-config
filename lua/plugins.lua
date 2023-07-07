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
	-- { 'tpope/vim-surround', keys = { 'ys', 'ds', 'cs', { 'S', mode = 'v' } } },
	{
		'kylechui/nvim-surround',
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function() require("nvim-surround").setup() end
	},
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	{ 'nvim-treesitter/playground', config = function ()
		require "nvim-treesitter.configs".setup{}
	end },

	-- { 'tpope/vim-commentary', keys = { { 'gc', mode = { 'n', 'v' } }, 'gcc' } },
	{ 'numToStr/Comment.nvim', config = function ()
		require'Comment'.setup()
	end },
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
	-- { 'leafOfTree/vim-vue-plugin', ft = 'vue' },
	-- { 'AndrewRadev/splitjoin.vim', event = 'BufWinEnter' }, -- keys = { { 'gS', mode = { 'n', 'v' } }, { 'gJ', mode = { 'n', 'v' } } } },
	{
		'Wansmer/treesj',
		-- keys = { '<Enter>', 'gS', 'gJ' },
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		config = function () require'treesj'.setup() end,
	},
	{ 'mattn/emmet-vim', keys = {
		{ '<Plug>(emmet-expand-abbr)' },
		{ '<Plug>(emmet-expand-abbr)', mode = 'i' },
		{ '<Plug>(emmet-expand-yank)' },
		{ '<Plug>(emmet-expand-yank)', mode = 'i' },
	}},
	'vimwiki/vimwiki',
	'tommcdo/vim-exchange',

	-- Lsp
	{ 'williamboman/mason.nvim', config = function()
		require'mason'.setup()
	end },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'neovim/nvim-lspconfig' },
	{ 'folke/trouble.nvim' },

	{ 'jose-elias-alvarez/null-ls.nvim', config = function()
		local null = require'null-ls'
		null.setup{
			sources = {
				null.builtins.formatting.prettier,
			},
		}
	end },

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
	-- { 'akinsho/git-conflict.nvim', version = "*", config = true },
	{ 'lewis6991/gitsigns.nvim', event = 'BufRead', config = function()
		local gitsigns = require'gitsigns'
		gitsigns.setup{
			diff_opts = {
				vertical = false
			},
			signs = {
				untracked = { text = '│' }
			}
		}
		vim.keymap.set('n', '<leader>bl', function() gitsigns.blame_line{ full = true } end)
		vim.keymap.set('n', ']c', gitsigns.next_hunk)
		vim.keymap.set('n', '[c', gitsigns.prev_hunk)
		vim.keymap.set('n', '<leader>bh', gitsigns.preview_hunk)
		vim.keymap.set('n', '<leader>bd', gitsigns.diffthis)
		vim.keymap.set('n', '<leader>bD', function() gitsigns.diffthis('~') end)
		vim.keymap.set('n', '<leader>td', gitsigns.toggle_deleted)
	end},
	{ 'f-person/git-blame.nvim' },
	{
		'sindrets/diffview.nvim',
		config = function()
			require('diffview').setup({
				enhanced_diff_hl = true,
				view = {
					merge_tool = {
						layout = 'diff3_mixed',
					},
				},
			})
		end,
		cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFileHistory', 'DiffviewFocusFiles', 'DiffviewLog', 'DiffviewRefresh', },
	},

	-- UI
	{ 'nvim-tree/nvim-web-devicons' },
	{ 'folke/zen-mode.nvim', cmd = { 'ZenMode' }, config = function()
		require'zen-mode'.setup();
	end },

	{ 'stevearc/oil.nvim', config = function ()
		require'oil'.setup()
	end },

	{ 'romgrk/barbar.nvim', dependencies = 'nvim-web-devicons', event='BufWinEnter', config = function()
		require'bufferline'.setup{
			-- auto_hide = true,
			animation = false,
			icons = {
				button = ' ',
				icon_cusom_colors = true,
				separator = { left = '', right = '' },
				inactive = {
					separator = { left = '', right = '' },
					button = ' ',
				},
				sidebar_filetypes = {
					NvimTree = true,
					['neo-tree'] = { event = 'BufWipeout' }
				}
			}
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
		vim.cmd[[
			autocmd User TelescopePreviewerLoaded setlocal number
		]]
	end },
	{ 'stevearc/dressing.nvim', event = 'VeryLazy' },

	{ 'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async' },

	-- TODO: Lazyload this
	{ 'startup-nvim/startup.nvim',
		config = function()
			require'startup'.setup({ theme = 'my_theme' })
		end
	},
	{ 'folke/todo-comments.nvim', event = 'BufRead', config = function()
		require'todo-comments'.setup()
	end},

	{ 'NvChad/nvim-colorizer.lua', config = function()
		require'colorizer'.setup {
			user_default_options = {
				tailwind = 'both',
			},
		}
	end},
	{
		'nvim-neo-tree/neo-tree.nvim',
		dependencies = { "nvim-lua/plenary.nvim", "nvim-web-devicons", "MunifTanjim/nui.nvim", },
		branch = "v2.x",
		keys = {
			{ '<leader>e', '<cmd>NeoTreeFocusToggle<cr>' },
			{ '<leader>E', '<cmd>NeoTreeFocus<cr>' }
		},
		config = function()
			require'neo-tree'.setup{
				disable_netrw = true,
			}
		end,
	},
	{ 'nvim-lualine/lualine.nvim', event = 'BufWinEnter', config = function()
		-- vim.o.shortmess = vim.o.shortmess .. 'S';
		local git_blame = require('gitblame')

		require'lualine'.setup {
			sections = {
				lualine_b = {
					'filename',
					'diagnostics',
				},
				lualine_c = {},
				lualine_x = {
					{ git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
				},
				lualine_y = {
					'branch',
					{ 'diff', symbols = { added = ' ', modified = '柳', removed = ' ' } }
				},
				lualine_z = {},
			},
			options = {
				section_separators = { left = '', right = '' },
				component_separators = { left = '', right = '' },
			},
		}

		vim.api.nvim_set_hl(0, 'lualine_c_normal', { fg='#666677' })
		vim.api.nvim_set_hl(0, 'lualine_c_inactive', { fg='#666677' })
	end},
	{ 'folke/which-key.nvim', cmd = 'WhichKey' },

	-- better text-objects
	-- {
	-- 	"echasnovski/mini.ai",
	-- 	-- keys = {
	-- 	--   { "a", mode = { "x", "o" } },
	-- 	--   { "i", mode = { "x", "o" } },
	-- 	-- },
	-- 	event = "VeryLazy",
	-- 	dependencies = {
	-- 		{
	-- 			"nvim-treesitter/nvim-treesitter-textobjects",
	-- 			init = function()
	-- 				-- no need to load the plugin, since we only need its queries
	-- 				require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
	-- 			end,
	-- 		},
	-- 	},
	-- 	opts = function()
	-- 		local ai = require("mini.ai")
	-- 		return {
	-- 			n_lines = 500,
	-- 			custom_textobjects = {
	-- 				o = ai.gen_spec.treesitter({
	-- 					a = { "@block.outer", "@conditional.outer", "@loop.outer" },
	-- 					i = { "@block.inner", "@conditional.inner", "@loop.inner" },
	-- 				}, {}),
	-- 				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
	-- 				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
	-- 			},
	-- 		}
	-- 	end,
	-- 	config = function(_, opts)
	-- 		local ai = require("mini.ai")
	-- 		ai.setup(opts)
	-- 	end,
	-- },

	-- Theme
	{ 'rebelot/kanagawa.nvim', config = function ()
		require'kanagawa'.setup{
			colors = {
				theme = {
					all = {
						ui = {
							bg_gutter = 'none'
						}
					}
				}
			}
		}
	end }
})

luasnip = require 'luasnip'

-- Below you'll find the land of the lost

-- require'indent_blankline'.setup { show_current_context = true },
-- neogen: keybinding to create documentation comments
-- hlargs.nvim: highlight arguments differently from variables
-- 'nvim-neorg/neorg' -- Learn this if you want to use it
-- 'tpope/vim-speeddating' -- NOTE: Why have this if you dont know how to use it
-- 'windwp/nvim-ts-autotag' -- WARN: think this works i just never enabled it
-- { 'tpope/vim-unimpaired', event = 'BufRead' } -- NOTE: Never used any of the bindings
-- { 'nvim-treesitter/nvim-treesitter-context' } -- never used this
