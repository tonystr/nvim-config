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

require'lazy'.setup({
	-- Theme
	{
		'rebelot/kanagawa.nvim',
		lazy = false,
		opts = {
			colors = { theme = { all = { ui = { bg_gutter = 'none' } } } },
			overrides = require'kanagawa-colors'
		},
		config = function (_, opts)
			require'kanagawa'.setup(opts)
			vim.cmd'colors kanagawa'
		end,
		priority = 1000,
	},
	-- { 'catppuccin/nvim', name = 'catppuccin', lazy = false },
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = true,
	-- 	opts = {},
	-- },

	-- Misc
	{ 'LunarVim/bigfile.nvim', opts = {
		filesize = 2, -- MiB
		features = { -- features to disable
			"indent_blankline",
			"illuminate",
			"lsp",
			"treesitter",
			"syntax",
			"vimopts",
			"filetype",
		},
	} },
	{ 'tpope/vim-dispatch'--[[ , cmd = 'Dispatch'  ]]},
	{
		'Wansmer/sibling-swap.nvim',
		requires = { 'nvim-treesitter' },
		keys = { '<C-,>', '<C-.>', '<leader>,', '<leader>.' },
		config = true,
	},
	{
		'monaqa/dial.nvim',
		keys = { '<C-a>', 'g<C-a>', '<C-x>', 'g<C-x>', },
		config = function ()
			local config = require'dial.config'
			local augend = require'dial.augend'

			config.augends:register_group {
				default = {
					augend.integer.alias.decimal,
					augend.integer.alias.hex,
					augend.integer.alias.octal,
					augend.integer.alias.binary,
					augend.date.alias['%Y/%m/%d'],
					augend.date.alias['%Y-%m-%d'],
					augend.date.alias['%H:%M'],
					augend.constant.alias.bool,
					augend.semver.alias.semver,
				}
			}

			local dmap = require'dial.map'

			local function dialMap(action, mode)
				return function()
					dmap.manipulate(action, mode)
					vim.cmd'write'
				end
			end

			vim.keymap.set("n", "<C-a>",  dialMap("increment", "normal"))
			vim.keymap.set("n", "<C-x>",  dialMap("decrement", "normal"))
			vim.keymap.set("n", "g<C-a>", dialMap("increment", "gnormal"))
			vim.keymap.set("n", "g<C-x>", dialMap("decrement", "gnormal"))
			vim.keymap.set("v", "<C-a>",  dialMap("increment", "visual"))
			vim.keymap.set("v", "<C-x>",  dialMap("decrement", "visual"))
			vim.keymap.set("v", "g<C-a>", dialMap("increment", "gvisual"))
			vim.keymap.set("v", "g<C-x>", dialMap("decrement", "gvisual"))
		end
	},
	{ 'christoomey/vim-sort-motion', keys = { 'gs' } },
	{
		dir = 'C:/Users/tonys/Documents/git/tw-values.nvim',
		keys = {
			{ '<leader>sv', "<cmd>TWValues<cr>", desc = "Show tailwind CSS values" },
			{ '<leader>sc', "<cmd>TWCopy<cr>", desc = "Copy tailwind CSS values" },
		},
		opts = {
			border = 'rounded',
			show_unknown_classes = true
		}
	},
	{
		'kylechui/nvim-surround',
		keys = {
			'ys',
			'ds',
			'cs',
			{ '<C-g>s', mode = 'x' },
			{ 's', mode = 'x' },
			{ 'S', mode = 'x' },
		},
		version = '*',
		config = {
			surrounds = {
				["<"] = {
					-- Only add treats < as html tag. Other methods treat it as < > pair
					add = function()
						local user_input = vim.fn.input'<'
						if user_input then
							local element = user_input:match("^<?([^%s%.>]+)")
							local afterel = user_input:sub(element and (#element + 1) or 1, #user_input)
							local attributes = afterel:match("^[%s]*(.-)>?$")

							element = element or "div"

							attributes = attributes:gsub("%.([^%s]+)", "class=\"%1\"")
							attributes = attributes:gsub("%.", " ")

							local open = (#attributes > 0) and element .. " " .. attributes or element
							local close = element

							return { { "<" .. open .. ">" }, { "</" .. close .. ">" } }
						end
					end,
				},
				["t"] = {
					add = function()
						local user_input = vim.fn.input'<'
						if user_input then
							local element = user_input:match("^<?([^%s%.>]*)")
							local afterel = user_input:sub(#element + 1, #user_input)
							local attributes = afterel:match("^[%s]*(.-)>?$")

							attributes = attributes:gsub("%.([^%s]+)", "class=\"%1\"")
							attributes = attributes:gsub("%.", " ")

							local open = (#attributes > 0) and element .. " " .. attributes or element
							local close = element

							return { { "<" .. open .. ">" }, { "</" .. close .. ">" } }
						end
					end,
					delete = "^(%b<>)().-(%b<>)()$",
					change = {
						target = "^<([^%s<>]*)().-([^/]*)()>$",
						replacement = function()
							local user_input = vim.fn.input'<'
							if user_input then
								local element = user_input:match("^<?([^%s%.>]*)")
								local afterel = user_input:sub(#element + 1, #user_input)
								local attributes = afterel:match("^[%s]*(.-)>?$")

								attributes = attributes:gsub("%.([^%s]+)", "class=\"%1\"")
								attributes = attributes:gsub("%.", " ")

								local open = (#attributes > 0) and element .. " " .. attributes or element
								local close = element

								return { { open }, { close } }
							end
						end,
					},
				},
				["T"] = {
					add = function()
						local user_input = vim.fn.input'<'
						if user_input then
							local element = user_input:match("^<?([^%s%.>]*)")
							local afterel = user_input:sub(#element + 1, #user_input)
							local attributes = afterel:match("^[%s]*(.-)>?$")

							attributes = attributes:gsub("%.([^%s]+)", "class=\"%1\"")
							attributes = attributes:gsub("%.", " ")

							local open = (#attributes > 0) and element .. " " .. attributes or element
							local close = element

							return { { "<" .. open .. ">" }, { "</" .. close .. ">" } }
						end
					end,
					delete = "^(%b<>)().-(%b<>)()$",
					change = {
						target = "^<([^>]*)().-([^/]*)()>$",
						replacement = function()
							local user_input = vim.fn.input'<'
							if user_input then
								local element = user_input:match("^<?([^%s%.>]*)")
								local afterel = user_input:sub(#element + 1, #user_input)
								local attributes = afterel:match("^[%s]*(.-)>?$")

								attributes = attributes:gsub("%.([^%s]+)", "class=\"%1\"")
								attributes = attributes:gsub("%.", " ")

								local open = (#attributes > 0) and element .. " " .. attributes or element
								local close = element

								return { { open }, { close } }
							end
						end,
					},
				},
			},
			keymaps = {
				visual = 's',
				visual_line = 'S',
			},
		},
	},
	{
		'nvim-treesitter/nvim-treesitter',
		event = { 'BufReadPost', 'BufNewFile' },
		build = ':TSUpdate',
		config = function ()
			local tsi = require'nvim-treesitter.install'
			tsi.compilers = { "zig", "clang", "gcc" }
			tsi.prefer_git = false

			require'nvim-treesitter.configs'.setup {
				ensure_installed = {},
				sync_install = false,
				auto_install = true,
				ignore_install = { "markdown" }, -- F U Markdown developer!! it doesn't work
				highlight = {
					enable = true,
					disable = function(lang, buf)
						local max_filesize = 1000 * 1024 -- 1000 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = '<C-n>',
						node_incremental = '<C-n>',
						scope_incremental = '<C-m>',
						node_decremental = '<C-r>',
					},
				},
			}

			vim.api.nvim_set_hl(0, '@text.uri.vue', { underline = false })
		end
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		cmd = { 'TSContextEnable', 'TSContextToggle', 'TSContextDisable' },
		config = true,
	},
	{ 'nvim-treesitter/playground', cmd = { 'TSNodeUnderCursor', 'TSHighlightCapturesUnderCursor', 'TSPlaygroundToggle' }, config = function()
		require'nvim-treesitter.configs'.setup {
			playground = { enable = true },
		}
	end },
	{
		'numToStr/Comment.nvim',
		keys = { 'gc', 'gb', { 'gc', mode = 'x' }, { 'gb', mode = 'x' } },
		dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
		config = function()
			require'Comment'.setup {
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			}
		end,
	},
	{
		desc = "fixes Comment.nvim for vue files and more",
		'JoosepAlviste/nvim-ts-context-commentstring',
		lazy = true,
		opts = {
			enable_autocmd = false,
		}
	},
	{ 'tpope/vim-repeat', keys = { '.' } },
	{
		'zbirenbaum/copilot.lua',
		event = 'InsertEnter',
		opts = {
			suggestion = {
				auto_trigger = true,
			},
		}
	},
	{ 'junegunn/vim-easy-align', keys = {
		{ 'ga', '<Plug>(EasyAlign)', mode = { 'n', 'v' } },
	}},
	{
		'lukas-reineke/indent-blankline.nvim',
		version = '2.20.7',
		event = { 'BufReadPost', 'BufNewFile' },
		opts = { show_current_context = true },
	},
	{
		'Wansmer/treesj',
		keys = {
			{ '<Enter>', '<cmd>lua require"treesj".toggle()<CR>' },
			{ 'gS', '<cmd>lua require"treesj".split()<CR>' },
			{ 'gJ', '<cmd>lua require"treesj".join()<CR>' },
		},
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		opts = {
			max_join_length = 666,
			langs = {
				vue = {
					['quoted_attribute_value'] = {
						both = {
							enable = function(tsn)
								return tsn:parent():type() == 'attribute'
							end,
						},
						split = {
							format_tree = function(tsj)
								local str = tsj:child('attribute_value')
								local words = vim.split(str:text(), ' ')
								tsj:remove_child('attribute_value')
								for i, word in ipairs(words) do
									tsj:create_child({ text = word }, i + 1)
								end
							end,
						},
						join = {
							format_tree = function(tsj)
								local str = tsj:child('attribute_value')
								local node_text = str:text()
								tsj:remove_child('attribute_value')
								tsj:create_child({ text = node_text }, 2)
							end,
						},
					},
				}
			}
		},
	},
	{ 'mattn/emmet-vim', keys = {
		{ '<Plug>(emmet-expand-abbr)', mode = { 'i', 'n' } },
		{ '<Plug>(emmet-expand-yank)', mode = { 'i', 'n' } },
		{ '<C-y>', mode = { 'i', 'n' } },
	}},
	{ 'vimwiki/vimwiki', keys = { '<leader>w' } },

	-- Lsp
	{
		'williamboman/mason.nvim',
		config = true,
		cmd = { 'Mason', 'LspInfo', 'MasonLog' },
	},
	-- {
	-- 	'VidocqH/lsp-lens.nvim',
	-- 	lazy = true,
	-- 	opts = {
	-- 		sections = {
	-- 			definition = false,
	-- 			implements = false,
	-- 			git_authors = true,
	-- 		},
	-- 	},
	-- },
	{ 'williamboman/mason-lspconfig.nvim', lazy = true },
	{
		'neovim/nvim-lspconfig',
		event = { "BufReadPost", "BufNewFile" },
		-- dependencies = { 'VidocqH/lsp-lens.nvim' },
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = 'Replace'
							},
							runtime = {
								version = 'LuaJIT',
							},
							diagnostics = {
								globals = {
									'vim',
									'describe',
									'it',
								}
							},
							telemetry = {
								enable = false,
							}
						}
					}
				},
				tsserver = {
					init_options = {
						hostInfo = 'neovim',
						typescript = {
							tsdk = require'env'.tsdk
						},
						plugins = {
							{
								name = '@vue/typescript-plugin',
								location = require'env'.vue_plugin,
								-- location = 'C:\\Program Files\\nodejs\\node_modules\\@vue\\typescript-plugin',
								languages = { 'javascript', 'typescript', 'vue' },
							},
						},
					},
					filetypes = {
						'vue',
						'javascript',
						'typescript',
						'javascriptreact',
						'javascript.jsx',
						'typescriptreact',
						'typescript.tsx',
					},
				},
			},
			setup = {},
		},
		config = function (_, opts)
			local mlsp = require'mason-lspconfig'

			local servers = opts.servers
			local capabilities = vim.tbl_deep_extend(
				'force',
				{
					textDocument = {
						foldingRange = {
							dynamicRegistration = false,
							lineFoldingOnly = true,
						}
					}
				},
				vim.lsp.protocol.make_client_capabilities(),
				require'cmp_nvim_lsp'.default_capabilities(),
				-- has_cmp and cmp_nvim_lsp.default_capabilities() or {},
				opts.capabilities or {}
			)

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
					-- on_attach = function (client, bufnr)
					-- 	require'workspace-diagnostics'.populate_workspace_diagnostics(client, bufnr)
					-- end
				}, servers[server] or {})

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			mlsp.setup({
				ensure_installed = { 'tsserver', 'volar' },
				handlers = { setup },
			})
		end
	},
	-- { 'folke/neodev.nvim', config = true },
	-- { 'artemave/workspace-diagnostics.nvim' },
	{
		'ray-x/lsp_signature.nvim',
		event = 'VeryLazy',
		opts = {},
		config = true
	},
	{ -- NOTE: I don't really use this? I just use Telescope diagnostics
		'folke/trouble.nvim',
		cmd = { 'Trouble', 'TroubleToggle' },
		opts = { use_diagnostic_signs = true }
	},
	{ 'jose-elias-alvarez/null-ls.nvim', keys = { '<leader>fm' }, config = function()
		local null = require'null-ls'
		null.setup {
			sources = { null.builtins.formatting.prettierd },
		}
	end },
	{ 'onsails/lspkind.nvim', lazy = true },
	{ 'RRethy/vim-illuminate', event = { 'BufReadPost', 'BufNewFile' }, config = function ()
		require'illuminate'.configure {
			modes_allowlist = { 'n' },
			filetypes_denylist = { 'help', 'qf', 'fugitive', 'vimwiki', 'md', 'markdown', 'txt' },
			min_count_to_highlight = 2,
		}
	end },
	{ 'rafamadriz/friendly-snippets', lazy = true },
	{
		-- https://tonystr.net
		'L3MON4D3/LuaSnip',
		version = '2.*',
		build = 'make install_jsregexp',
		dependencies = { 'saadparwaiz1/cmp_luasnip' },
		lazy = true,
	},
	{ 'hrsh7th/nvim-cmp',
		event = 'VeryLazy',
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'hrsh7th/cmp-buffer'   },
			-- { 'hrsh7th/cmp-path'     },
			-- { 'hrsh7th/cmp-cmdline'  },
			{ 'L3MON4D3/LuaSnip'     },
			-- { 'roobert/tailwindcss-colorizer-cmp.nvim' },
		},
		config = function()
			local cmp = require'cmp'
			-- require'tailwindcss-colorizer-cmp'.setup { color_square_width = 1 }

			cmp.setup {
				formatting = {
					format = function (entry, item)
						require'luasnip.loaders.from_vscode'.lazy_load();
						return require'lspkind'.cmp_format({
							mode = 'symbol', -- show only symbol annotations
							maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						})(entry, item)
						-- return require'tailwindcss-colorizer-cmp'.formatter(entry, item)
					end
				},
				window = {
					scrollbar = false,
					documentation = cmp.config.window.bordered {
						winhighlight = 'Normal:Normal,FloatBorder:TelescopeBorder,CursorLine:Visual,Search:None'
					}
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
					{
						{ name = 'nvim_lsp' },
						{ name = 'luasnip' },
					},
					{ { name = 'buffer' } }
				)
			}
		end
	},
	-- { 'jose-elias-alvarez/typescript.nvim', lazy = true },

	-- Git
	{ 'tpope/vim-fugitive', cmd = { 'G', 'Gwrite', 'Git', 'Gdiffsplit', 'Gvdiffsplit' } },
	-- { 'akinsho/git-conflict.nvim', version = "v1.1.2", opts = { disable_diagnostics = true } },
	{ 'lewis6991/gitsigns.nvim', event = { 'BufReadPost', 'BufNewFile' }, config = function()
		local gitsigns = require'gitsigns'
		gitsigns.setup{
			diff_opts = { vertical = false },
			signs = { untracked = { text = '│' } }
		}
		vim.keymap.set('n', '<leader>bl', function() gitsigns.blame_line{ full = true } end)
		vim.keymap.set('n', ']c', gitsigns.next_hunk)
		vim.keymap.set('n', '[c', gitsigns.prev_hunk)
		vim.keymap.set('n', '<leader>bh', gitsigns.preview_hunk)
		vim.keymap.set('n', '<leader>bd', gitsigns.diffthis)
		vim.keymap.set('n', '<leader>bD', function() gitsigns.diffthis('~') end)
		vim.keymap.set('n', '<leader>td', gitsigns.toggle_deleted)
		vim.keymap.set('n', '<leader>th', gitsigns.preview_hunk_inline)
		vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk)
		vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
		vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer)
		vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk)
		vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
		vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer)
		vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk)
	end },
	{
		'f-person/git-blame.nvim',
		event = { 'BufReadPost', 'BufNewFile' },
	},
	{
		'sindrets/diffview.nvim',
		opts = {
			enhanced_diff_hl = true,
			view = {
				merge_tool = {
					layout = 'diff3_mixed',
				},
			},
		},
		cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFileHistory', 'DiffviewFocusFiles', 'DiffviewLog', 'DiffviewRefresh', },
	},
	{ 'rbong/vim-flog', dependencies = { 'vim-fugitive' }, cmd = { 'Flog', 'Flogsplit', 'Floggit' } },

	-- UI
	-- -- Marks.nvim causes clipping in hover docs (https://github.com/chentoast/marks.nvim/issues/79)
	-- {
	-- 	'chentoast/marks.nvim',
	-- 	event = { 'BufReadPost', 'BufNewFile' },
	-- 	opts = {
	-- 		builtin_marks = { '.', '<', '>', '^' },
	-- 	},
	-- 	config = function(_, opts)
	-- 		require'marks'.setup(opts)
	-- 		vim.api.nvim_set_hl(0, 'MarkSignNumHL', { guifg = nil })
	-- 	end
	-- },
	{ 'nvim-tree/nvim-web-devicons', lazy = true },
	{ 'stevearc/oil.nvim', config = true, cmd = 'Oil' },
	{
		'romgrk/barbar.nvim',
		dependencies = { 'nvim-web-devicons' },
		-- event = { 'BufWinEnter', 'BufNewFile' },
		opts = {
			exclude_ft = { 'fugitive', 'neo-tree', 'startup', '' },
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
		},
	},

	{
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		version = '0.1.4',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {
			defaults = {
				preview = {
					timeout = 300,
				},
				layout_strategy = 'vertical',
				layout_config = {
					vertical = { width = 0.8 }
				},
				file_ignore_patterns = {
					'^node.modules[/\\]',
					'^collab.embed[/\\]',
					'%.lnk$'
				},
				mappings = {
					i = {
						["<Esc>"] = 'close',
						["<C-v>"] = false,
						["<C-Enter>"] = 'select_default',
						["<C-Down>"] = 'cycle_history_next',
						["<C-Up>"] = 'cycle_history_prev',
					},
				},
			},
			extensions = {
				undo = {
					use_delta = false,
				}
			},
		},
	},
	{ 'debugloop/telescope-undo.nvim', keys = { { '<leader>fu', '<cmd>Telescope undo<CR>' } }, config = function ()
		require'telescope'.load_extension'undo'
	end },
	{ 'nvim-telescope/telescope-symbols.nvim', event = 'VeryLazy' },
	{ 'stevearc/dressing.nvim', event = 'VeryLazy' },
	{
		'kevinhwang91/nvim-ufo',
		keys = { 'zR', 'zM', 'zr', 'zm', 'zK' },
		ft = { 'vue', 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'svelte' },
		dependencies = 'kevinhwang91/promise-async',
		config = function ()
			local ufo = require'ufo'
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = ('  %d '):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, {chunkText, hlGroup})
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, {suffix, 'MoreMsg'})
				return newVirtText
			end
			ufo.setup{
				fold_virt_text_handler = handler,
				close_fold_kinds_for_ft = {
					vue = {'imports', 'comment'},
					typescript = {'imports', 'comment'},
					javascript = {'imports', 'comment'},
				},

			}
			vim.keymap.set('n', 'zR', ufo.openAllFolds)
			vim.keymap.set('n', 'zM', ufo.closeAllFolds)
			vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds)
			vim.keymap.set('n', 'zm', ufo.closeFoldsWith)
			vim.keymap.set('n', 'zK', function()
				local winid = require'ufo'.peekFoldedLinesUnderCursor()
				if not winid then
					vim.lsp.buf.hover()
				end
			end)
		end
	},
	{ 'startup-nvim/startup.nvim', cmd = 'Startup', opts = { theme = 'dragon' } },
	{ 'folke/todo-comments.nvim', event = { 'BufReadPost', 'BufNewFile' }, config = true },
	{
		'norcalli/nvim-colorizer.lua',
		event = 'VeryLazy',
		opts = {
			['*'] = { names = false },
			css = { css = true, css_fn = true },
			scss = { css = true, css_fn = true },
		}
	},
	{
		'nvim-neo-tree/neo-tree.nvim',
		dependencies = { "nvim-lua/plenary.nvim", "nvim-web-devicons", "MunifTanjim/nui.nvim", },
		branch = "v3.x",
		keys = {
			{ '<leader>e', '<cmd>Neotree toggle<cr>' },
			{ '<leader>E', '<cmd>Neotree focus<cr>' }
		},
		opts = { disable_netrw = false }
	},
	{
		'nvim-lualine/lualine.nvim',
		event = 'VeryLazy',
		dependencies = { 'f-person/git-blame.nvim' },
		config = function()
			-- vim.o.shortmess = vim.o.shortmess .. 'S';
			local git_blame = require'gitblame'

			local wcFiles = { 'markdown', 'vimwiki', 'txt' }

			function Contains(table, number)
				for _, value in pairs(table) do if value == number then return true end end
				return false
			end

			vim.g.showwords = 1

			local function getWords()
				if (vim.g.showwords == 1 and Contains(wcFiles, vim.bo.filetype)) then
					return tostring(vim.fn.wordcount().words)
				end
				return ''
			end

			require'lualine'.setup {
				ignore_focus = { 'NvimTree', 'startup', 'neo-tree' },
				sections = {
					lualine_b = {
						{
							'filename',
							file_status = false,
							newfile_status = true,
						}
					},
					lualine_c = {
						{ getWords },
						{
							git_blame.get_current_blame_text,
							cond = git_blame.is_blame_text_available,
						}
					},
					lualine_x = {
						'diagnostics',
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

			vim.api.nvim_set_hl(0, 'lualine_c_normal', { fg='#666677', bg='#1d1d26' })
			vim.api.nvim_set_hl(0, 'lualine_c_inactive', { fg='#666677', bg='#1d1d26' })
		end
	},
	-- NOTE: use :Telescope keymaps instead
	-- { 'folke/which-key.nvim', cmd = 'WhichKey' },
}, {
	install = {
		colorscheme = { 'kanagawa' }
	}
})

-- Below you'll find the land of the lost

-- neogen: keybinding to create documentation comments
-- hlargs.nvim: highlight arguments differently from variables
-- 'nvim-neorg/neorg' -- Learn this if you want to use it
-- 'tpope/vim-speeddating' -- NOTE: Why have this if you dont know how to use it
-- 'windwp/nvim-ts-autotag' -- WARN: think this works i just never enabled it
-- { 'tpope/vim-unimpaired', event = 'BufRead' } -- NOTE: Never used any of the bindings
-- { 'nvim-treesitter/nvim-treesitter-context' } -- never used this
