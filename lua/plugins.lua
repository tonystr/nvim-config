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
	end, priority = 1000 },

	-- Misc
	-- { 'sheerun/vim-polyglot' },
	-- { 'tpope/vim-surround', keys = { 'ys', 'ds', 'cs', { 'S', mode = 'v' } } },
	{
		'kylechui/nvim-surround',
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function() require("nvim-surround").setup() end
	},
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
	{ 'nvim-treesitter/playground', event = 'VeryLazy', config = function ()
		require "nvim-treesitter.configs".setup{}
	end },

	{ 'numToStr/Comment.nvim', event = 'VeryLazy', config = function ()
		require'Comment'.setup()
	end },
	{ 'tpope/vim-repeat', event = 'BufRead' },
	{ 'github/copilot.vim', event = 'BufWinEnter' },
	{ 'junegunn/vim-easy-align', keys = {
		{ 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'v' } },
	}},
	{ 'lukas-reineke/indent-blankline.nvim', ft = 'BufWinEnter', config = function ()
		require'indent_blankline'.setup {
			show_current_context = true,
		}
	end
	},
	{
		'Wansmer/treesj',
		event = 'VeryLazy',
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
	{ 'vimwiki/vimwiki', event = 'VeryLazy' },

	-- Lsp
	{ 'williamboman/mason.nvim', config = function()
		require'mason'.setup()
	end },
	{ 'williamboman/mason-lspconfig.nvim' },
	{ 'neovim/nvim-lspconfig' },
	{ 'folke/trouble.nvim', event = 'VeryLazy' },

	{ 'jose-elias-alvarez/null-ls.nvim', event = 'VeryLazy', config = function()
		local null = require'null-ls'
		null.setup{
			sources = {
				null.builtins.formatting.prettierd,
			},
		}
	end },

	{
		'L3MON4D3/LuaSnip',
		lazy = true,
		config = function () require'luasnip' end
	},
	{ 'saadparwaiz1/cmp_luasnip', lazy = true },
	{ 'onsails/lspkind.nvim', lazy = true },
	{ 'RRethy/vim-illuminate', event = 'VeryLazy' },
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
	{ 'rbong/vim-flog', event = 'VeryLazy' },

	-- UI
	{ 'nvim-tree/nvim-web-devicons' },
	{ 'folke/zen-mode.nvim', cmd = { 'ZenMode' }, config = function()
		require'zen-mode'.setup();
	end },

	{ 'stevearc/oil.nvim', config = function ()
		require'oil'.setup()
	end, event = 'VeryLazy' },

	{ 'romgrk/barbar.nvim', dependencies = 'nvim-web-devicons', event='BufWinEnter', config = function()
		require'bufferline'.setup{
			auto_hide = true,
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

	{ 'kevinhwang91/nvim-ufo', event = 'VeryLazy', dependencies = 'kevinhwang91/promise-async' },

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
		vim.api.nvim_create_autocmd('FileType', {
			pattern = '*',
			command = 'ColorizerAttachToBuffer',
		})
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
	{
		'nvim-lualine/lualine.nvim',
		event = 'BufWinEnter',
		dependencies = { 'f-person/git-blame.nvim' },
		config = function()
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
		end
	},
	{ 'folke/which-key.nvim', cmd = 'WhichKey' },
})

-- Below you'll find the land of the lost

-- require'indent_blankline'.setup { show_current_context = true },
-- neogen: keybinding to create documentation comments
-- hlargs.nvim: highlight arguments differently from variables
-- 'nvim-neorg/neorg' -- Learn this if you want to use it
-- 'tpope/vim-speeddating' -- NOTE: Why have this if you dont know how to use it
-- 'windwp/nvim-ts-autotag' -- WARN: think this works i just never enabled it
-- { 'tpope/vim-unimpaired', event = 'BufRead' } -- NOTE: Never used any of the bindings
-- { 'nvim-treesitter/nvim-treesitter-context' } -- never used this
