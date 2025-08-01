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
			
			if not vim.g.neovide then
				vim.api.nvim_set_hl(0, 'Normal', { ctermbg='none', bg='none' })
			end
		end,
		priority = 1000,
	},
	-- { 'catppuccin/nvim', name = 'catppuccin', lazy = false },
	{
		'folke/tokyonight.nvim',
		lazy = true,
		opts = {},
	},

	-- Misc
	{
		'Goose97/timber.nvim',
		keys = { 'gl' },
		opts = {
			watcher = {
				sources = {
					enabled = true,
					javascript_log = {
						type = 'filesystem',
						name = 'Log file',
						path = '/tmp/debug.log',
						buffer = {
							syntax = 'javascript',
						}
					}
				}
			},
			log_templates = {
				default = {
					lua = [[print("%log_marker %log_target: " .. %log_target)]],
					rust = [[println!("%log_marker %log_target: {:#?}", %log_target);]],
				},
			},
		}
	},
	{ 'LunarVim/bigfile.nvim', opts = {
		filesize = 2, -- MiB
		features = { -- features to disable
			'indent_blankline',
			'illuminate',
			'lsp',
			'treesitter',
			'syntax',
			'vimopts',
			'filetype',
		},
	} },
	{
		'tpope/vim-dispatch',
		event = 'VeryLazy',
		-- cmd = {
		-- 	'Dispatch',
		-- 	'Push',
		-- 	'Pull',
		-- 	'Cam',
		-- 	'Commit',
		-- 	'K',
		-- },
	},
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
	-- {
	-- 	dir = 'C:/Users/tonys/Documents/git/tw-values.nvim',
	-- 	keys = {
	-- 		{ '<leader>sv', "<cmd>TWValues<cr>", desc = "Show tailwind CSS values" },
	-- 		{ '<leader>sc', "<cmd>TWCopy<cr>", desc = "Copy tailwind CSS values" },
	-- 	},
	-- 	opts = {
	-- 		border = 'rounded',
	-- 		show_unknown_classes = true
	-- 	}
	-- },
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
		event = 'VeryLazy',
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
		event = 'VeryLazy',
		-- cmd = { 'TSContextEnable', 'TSContextToggle', 'TSContextDisable' },
		-- keys = { { '<leader>tc', function() require'nvim-treesitter-context'.toggle() end } },
		config = function()
			vim.keymap.set('n', '[C', function()
				require'treesitter-context'.go_to_context(vim.v.count1)
			end, { silent = true })
			vim.keymap.set('n', '<leader>tc', function() require'treesitter-context'.toggle() end);
			require'treesitter-context'.setup {
				enable = false,
			}
		end
	},
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
	-- {
	-- 	'lukas-reineke/indent-blankline.nvim',
	-- 	-- main = 'ibl',
	-- 	version = '2.20.7',
	-- 	event = { 'BufReadPost', 'BufNewFile' },
	-- 	opts = { show_current_context = true },
	-- },
	-- Fascinating...
	{
		'lukas-reineke/indent-blankline.nvim',
		main = 'ibl',
		event = 'VeryLazy',
		opts = {
			indent = {
				highlight = {
					'IndentBlanklineChar',
				},
				char = '▏',
			},
			scope = {
				show_start = false,
				show_end = false,
				highlight = {
					'IndentBlanklineContextChar',
				},
			}
		},
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
	{
		'mattn/emmet-vim',
		keys = {
			{ '<Plug>(emmet-expand-abbr)', mode = { 'i', 'n' } },
			{ '<Plug>(emmet-expand-yank)', mode = { 'i', 'n' } },
			-- { '<C-z>', mode = { 'i', 'n' } },
		},
		config = function()
			-- vim.g.user_emmet_leader_key = '<C-z>'
		end,
	},
	{ 'vimwiki/vimwiki', keys = { '<leader>w' }, cmd = { 'VimwikiMakeDiaryNote' } },

	-- Lsp
	-- {
	-- 	'mrcjkb/rustaceanvim',
	-- 	version = '^5', -- Recommended
	-- 	lazy = false, -- This plugin is already lazy
	-- },
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

	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		setup = function()
			require'mason-lspconfig'.setup {
				ensure_installed = {
					'lua_ls',
					'ts_ls',
					'vtsls',
					'vue_ls',
					'rust_analyzer',
					'html',
				},
			}

			local vue_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
			local vue_plugin = {
				name = '@vue/typescript-plugin',
				location = vue_language_server_path,
				languages = { 'vue' },
				configNamespace = 'typescript',
			}
			local vtsls_config = {
				init_options = {
					plugins = {
						vue_plugin,
					},
				},
				filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
			}
			local vue_ls_config = {
				on_init = function(client)
					client.handlers['tsserver/request'] = function(_, result, context)
						local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
						if #clients == 0 then
							vim.notify('Could not found `vtsls` lsp client, vue_lsp would not work without it.', vim.log.levels.ERROR)
							return
						end
						local ts_client = clients[1]

						local param = unpack(result)
						local id, command, payload = unpack(param)
						ts_client:exec_cmd({
							command = 'typescript.tsserverRequest',
							arguments = {
								command,
								payload,
							},
						}, { bufnr = context.bufnr }, function(_, r)
								local response_data = { { id, r.body } }
								---@diagnostic disable-next-line: param-type-mismatch
								client:notify('tsserver/response', response_data)
							end)
					end
				end,
			}
			-- nvim 0.11 or above
			vim.lsp.config('vtsls', vtsls_config)
			vim.lsp.config('vue_ls', vue_ls_config)
			vim.lsp.enable({'vtsls', 'vue_ls'})
		end
	},

	-- { 'mason-org/mason-lspconfig.nvim', lazy = true },
	-- {
	-- 	'neovim/nvim-lspconfig',
	-- 	event = 'VeryLazy',
	-- 	dependencies = { 'mason-org/mason-lspconfig.nvim' },
	-- 	opts = {
	-- 		servers = {
	-- 			lua_ls = {
	-- 				settings = {
	-- 					Lua = {
	-- 						completion = {
	-- 							callSnippet = 'Replace'
	-- 						},
	-- 						runtime = {
	-- 							version = 'LuaJIT',
	-- 						},
	-- 						diagnostics = {
	-- 							globals = {
	-- 								'vim',
	-- 								'describe',
	-- 								'it',
	-- 							}
	-- 						},
	-- 						telemetry = {
	-- 							enable = false,
	-- 						}
	-- 					}
	-- 				}
	-- 			},
	-- 			ts_ls = {
	-- 				init_options = {
	-- 					hostinfo = 'neovim',
	-- 					typescript = {
	-- 						tsdk = require'env'.tsdk
	-- 					},
	-- 					plugins = {
	-- 						{
	-- 							name = '@vue/typescript-plugin',
	-- 							location = require'env'.vue_plugin,
	-- 							-- location = 'c:\\program files\\nodejs\\node_modules\\@vue\\typescript-plugin',
	-- 							languages = { 'javascript', 'typescript', 'vue' },
	-- 						},
	-- 					},
	-- 				},
	-- 				filetypes = {
	-- 					'vue',
	-- 					'javascript',
	-- 					'typescript',
	-- 					'javascriptreact',
	-- 					'javascript.jsx',
	-- 					'typescriptreact',
	-- 					'typescript.tsx',
	-- 				},
	-- 			},
	-- 			vue_ls = {
	-- 				on_init = function(client)
	-- 					client.handlers['tsserver/request'] = function(_, result, context)
	-- 						local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
	-- 						if #clients == 0 then
	-- 							vim.notify('could not found `vtsls` lsp client, vue_lsp would not work without it.', vim.log.levels.error)
	-- 							return
	-- 						end
	-- 						local ts_client = clients[1]
	--
	-- 						local param = unpack(result)
	-- 						local id, command, payload = unpack(param)
	-- 						ts_client:exec_cmd({
	-- 							command = 'typescript.tsserverrequest',
	-- 							arguments = {
	-- 								command,
	-- 								payload,
	-- 							},
	-- 						}, { bufnr = context.bufnr }, function(_, r)
	-- 								local response_data = { { id, r.body } }
	-- 								---@diagnostic disable-next-line: param-type-mismatch
	-- 								client:notify('tsserver/response', response_data)
	-- 							end)
	-- 					end
	-- 				end,
	-- 			},
	-- 			vtsls_config = {
	-- 				init_options = {
	-- 					plugins = {
	-- 						name = '@vue/typescript-plugin',
	-- 						location = vim.fn.expand '$mason/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server',
	-- 						languages = { 'vue' },
	-- 						confignamespace = 'typescript',
	-- 					},
	-- 				},
	-- 				filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
	-- 			}
	-- 		},
	-- 		setup = {},
	-- 	},
	-- 	config = function (_, opts)
	-- 		local mlsp = require'mason-lspconfig'
	--
	-- 		local servers = opts.servers
	-- 		local capabilities = vim.tbl_deep_extend(
	-- 			'force',
	-- 			{
	-- 				textdocument = {
	-- 					foldingrange = {
	-- 						dynamicregistration = false,
	-- 						linefoldingonly = true,
	-- 					}
	-- 				}
	-- 			},
	-- 			vim.lsp.protocol.make_client_capabilities(),
	-- 			require'cmp_nvim_lsp'.default_capabilities(),
	-- 			-- has_cmp and cmp_nvim_lsp.default_capabilities() or {},
	-- 			opts.capabilities or {}
	-- 		)
	--
	-- 		local function setup(server)
	-- 			local server_opts = vim.tbl_deep_extend("force", {
	-- 				capabilities = vim.deepcopy(capabilities),
	-- 				-- on_attach = function (client, bufnr)
	-- 				-- 	require'workspace-diagnostics'.populate_workspace_diagnostics(client, bufnr)
	-- 				-- end
	-- 			}, servers[server] or {})
	--
	-- 			if opts.setup[server] then
	-- 				if opts.setup[server](server, server_opts) then
	-- 					return
	-- 				end
	-- 			elseif opts.setup["*"] then
	-- 				if opts.setup["*"](server, server_opts) then
	-- 					return
	-- 				end
	-- 			end
	-- 			require("lspconfig")[server].setup(server_opts)
	-- 		end
	--
	-- 		mlsp.setup({
	-- 			ensure_installed = { 'ts_ls', 'vue_ls' },
	-- 			handlers = {
	-- 				setup,
	-- 			},
	-- 		})
	-- 	end
	-- },

	-- { 'folke/neodev.nvim', config = true },
	-- {
	-- 	'ray-x/lsp_signature.nvim',
	-- 	event = 'VeryLazy',
	-- 	opts = {},
	-- 	config = true
	-- },
	{ -- NOTE: I don't really use this? I just use Telescope diagnostics
		'folke/trouble.nvim',
		cmd = { 'Trouble', 'TroubleToggle' },
		opts = { use_diagnostic_signs = true }
	},
	-- { 'jose-elias-alvarez/null-ls.nvim', keys = { '<leader>fm' }, config = function()
	-- 	local null = require'null-ls'
	-- 	null.setup {
	-- 		sources = { null.builtins.formatting.prettierd },
	-- 	}
	-- end },
	{ 'onsails/lspkind.nvim', lazy = true },
	{ 'RRethy/vim-illuminate', event = 'VeryLazy', config = function ()
		require'illuminate'.configure {
			modes_allowlist = { 'n' },
			filetypes_denylist = { 'help', 'qf', 'fugitive', 'vimwiki', 'md', 'markdown', 'txt' },
			min_count_to_highlight = 2,
		}
	end },
	{ 'rafamadriz/friendly-snippets', lazy = true },
	{
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
				performance = {
					max_view_entries = 20,
				},
				formatting = {
					fields = { "kind", "abbr", },
					format = function (entry, item)
						-- require'luasnip.loaders.from_vscode'.lazy_load();
						return require'lspkind'.cmp_format({
							mode = 'symbol', -- show only symbol annotations
							-- preset = 'codicons',
							maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
							show_labelDetails = true, 
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
	-- {
	--
	-- 	'SuperBo/fugit2.nvim',
	-- 	opts = {
	-- 		width = 100,
	-- 		libgit2_path = 'C:/ProgramData/chocolatey/lib/libgit2/tools/libgit2.dll',
	-- 	},
	-- 	dependencies = {
	-- 		'MunifTanjim/nui.nvim',
	-- 		'nvim-tree/nvim-web-devicons',
	-- 		'nvim-lua/plenary.nvim',
	-- 		{
	-- 			'chrisgrieser/nvim-tinygit', -- optional: for Github PR view
	-- 			dependencies = { 'stevearc/dressing.nvim' }
	-- 		},
	-- 	},
	-- 	cmd = { 'Fugit2', 'Fugit2Diff', 'Fugit2Graph' },
	-- 	keys = {
	-- 		{ '<leader>F', mode = 'n', '<cmd>Fugit2<cr>' }
	-- 	}
	-- },
	{
		'tpope/vim-fugitive',
		cmd = { 'G', 'Gwrite', 'Git', 'Gdiffsplit', 'Gvdiffsplit' },
		dependencies = { 'tpope/vim-rhubarb' }
	},
	{
		'NeogitOrg/neogit',
		cmd = { 'Neogit', 'NeogitCommit', 'NeogitResetState', 'NeogitLogCurrent' },
		dependencies = {
			'nvim-lua/plenary.nvim',
			'sindrets/diffview.nvim',
			'nvim-telescope/telescope.nvim', 
		},
		config = true
	},
	-- { 'tpope/vim-rhubarb', lazy = true },
	-- { 'SuperBo/fugit2.nvim' }, -- Could not build libgit2
	-- {
	-- 	'chrisgrieser/nvim-tinygit',
	-- 	ft = { 'gitrebase', 'gitcommit' }, -- so ftplugins are loaded
	-- 	dependencies = {
	-- 		'stevearc/dressing.nvim',
	-- 		'nvim-telescope/telescope.nvim',
	-- 		'rcarriga/nvim-notify',
	-- 	},
	-- },
	-- { 'akinsho/git-conflict.nvim', version = "v1.1.2", opts = { disable_diagnostics = true } },
	{ 'lewis6991/gitsigns.nvim', event = 'VeryLazy', config = function()
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
		event = 'VeryLazy',
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

	-- GUI
	-- {
	-- 	'lewis6991/satellite.nvim',
	-- 	event = 'VeryLazy',
	-- 	opts = {
	-- 		width = 2,
	-- 	},
	-- 	config = function(_, opts)
	-- 		require'satellite'.setup(opts)
	-- 	end
	-- },
	{
		'folke/twilight.nvim',
		cmd = { 'Twilight', 'TwilightEnable', 'TwilightDisable' }
	},
	{
		'Fildo7525/pretty_hover',
		-- event = "LspAttach",
		keys = { { 'K', function() require'pretty_hover'.hover() end } },
		opts = {}
	},
	-- {
	-- 	'chentoast/marks.nvim',
	-- 	-- Marks.nvim causes clipping in hover docs (https://github.com/chentoast/marks.nvim/issues/79)
	-- 	-- Fixed with this PR:
	-- 	commit = 'e0909e4868671d158a7dce1bc7872fd7a1f7d656',
	-- 	event = { 'BufReadPost', 'BufNewFile' },
	-- 	opts = {
	-- 		builtin_marks = { '.', '<', '>', '^' },
	-- 	},
	-- 	config = function(_, opts)
	-- 		require'marks'.setup(opts)
	-- 		vim.api.nvim_set_hl(0, 'MarkSignNumHL', { link = 'LineNr' })
	-- 	end
	-- },
	{ 'nvim-tree/nvim-web-devicons', lazy = true },
	{ 'stevearc/oil.nvim', config = {
		skip_confirm_for_simple_edits = true,
		float = {
			padding = 4,
			max_height = 24,
		}
	}, cmd = 'Oil' },
	{
		'romgrk/barbar.nvim',
		dependencies = { 'nvim-web-devicons' },
		-- event = 'VeryLazy',
		init = function() vim.g.barbar_auto_setup = false end,
		opts = {
			exclude_ft = { '', 'nvim-terminal', 'fugitive', 'neo-tree', 'startup' },
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
				},
				gitsigns = {
					added = { enabled = true, icon = ' ' },
					changed = { enabled = true, icon = '柳' },
					deleted = { enabled = true, icon = ' ' },
				}
			},
		},
	},

	{
		'nvim-telescope/telescope.nvim',
		-- cmd = 'Telescope',
		event = 'VeryLazy', -- We want this one opening smoothly the first time!
		cmd = { 'Telescope' },
		version = '0.1.4',
		dependencies = {
			'nvim-lua/plenary.nvim',
			-- 'nvim-telescope/telescope-fzf-native.nvim',
			-- 'nvim-telescope/telescope-file-browser.nvim',
		},
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
						-- ["<C-Enter>"] = 'select_default',
						["<C-Enter>"] = function(prompt_bufnr)
							local actions = require'telescope.actions'
							-- Open the selected result in a new buffer
							actions.file_edit(prompt_bufnr)
							vim.cmd'sil! bd#';
						end,
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
	-- {
	-- 	'nvim-telescope/telescope-file-browser.nvim',
	-- 	-- cmd = 'Telescope file_browser',
	-- 	lazy = true,
	-- 	config = function()
	-- 		require'telescope'.load_extension'file_browser'
	-- 	end
	-- },
	{
		'LinArcX/telescope-changes.nvim',
		lazy = true,
		keys = { { '<leader>fc', '<cmd>Telescope changes<CR>' } },
		config = function()
			require'telescope'.load_extension'changes'
		end
	},
	-- {
	-- 	'nvim-telescope/telescope-fzf-native.nvim',
	-- 	lazy = true,
	-- 	setup = function()
	-- 		require'telescope'.load_extension'fzf'
	-- 	end
	-- },
	-- {
	-- 	'otavioschwanck/telescope-cmdline-word.nvim',
	-- 	keys = { {
	-- 		'<tab>',
	-- 		function() require'telescope-cmdline-word.picker'.find_word() end,
	-- 		mode = 'c',
	-- 	} },
	-- 	opts = {
	-- 		add_mappings = true, -- add <tab> mapping automatically
	-- 	}
	-- },
	{
		'luckasRanarison/nvim-devdocs',
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope.nvim',
			'nvim-treesitter/nvim-treesitter',
		},
		keys = { {
			'<leader>od',
			'<cmd>DevdocsOpen<CR>'
		} },
		opts = {}
	},
	{
		'debugloop/telescope-undo.nvim',
		keys = { { '<leader>fu', '<cmd>Telescope undo<CR>' } },
		cmd = { 'Telescope undo', 'Tel undo' },
		config = function() require'telescope'.load_extension'undo' end,
	},
	-- { 'nvim-telescope/telescope-symbols.nvim', event = 'VeryLazy' },
	{ 'stevearc/dressing.nvim', event = 'VeryLazy' },
	{
		'kevinhwang91/nvim-ufo',
		keys = { 'zR', 'zM', 'zr', 'zm', 'zK', 'zf' },
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
	{
		'startup-nvim/startup.nvim',
		cmd = 'Startup',
		opts = { theme = 'dragon' },
	},
	{ 'folke/todo-comments.nvim', event = 'VeryLazy', config = true },
	{
		'brenoprata10/nvim-highlight-colors',
		event = 'VeryLazy',
		opts = {},
	},
	-- {
	-- 	'norcalli/nvim-colorizer.lua',
	-- 	event = 'VeryLazy',
	-- 	opts = {
	-- 		['*'] = { names = false },
	-- 		css = { css = true, css_fn = true },
	-- 		scss = { css = true, css_fn = true },
	-- 	}
	-- },
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
		-- run nvim <file> in terminal to open in this instance
		'willothy/flatten.nvim',
		config = true,
		event = 'TermEnter',
		-- -- Ensure that it runs first to minimize delay when opening file from terminal
		-- lazy = false,
		-- priority = 1001,
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
				return ' ' .. tostring(vim.fn.wordcount().words)
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
						{
							getWords,
							cond = function()
								return vim.g.showwords == 1 and Contains(wcFiles, vim.bo.filetype)
							end,
						},
						{
							git_blame.get_current_blame_text,
							cond = function ()
								return git_blame.is_blame_text_available() and git_blame.get_current_blame_text() ~= nil
							end
						}
					},
					lualine_x = {
						{
							'diagnostics',
							symbols = {
								error = " ",
								warn = " ",
								hint = "󰌵 ",
								info = "󰆈 ",
							}
						}
					},
					lualine_y = {
						'branch',
						{ 'diff', symbols = { added = ' ', modified = '柳', removed = ' ' } }
					},
					lualine_z = {},
				},
				options = {
					disabled_filetypes = { '', 'nvim-terminal' },
					section_separators = { left = '', right = '' },
					component_separators = { left = '', right = '' },
				},
			}

			if not vim.g.neovide then
				vim.api.nvim_set_hl(0, 'lualine_c_normal', { fg='#666677', bg='#1d1d26' })
				vim.api.nvim_set_hl(0, 'lualine_c_inactive', { fg='#666677', bg='#1d1d26' })
			else
				vim.api.nvim_set_hl(0, 'lualine_c_normal', { fg='#666677', bg='none' })
				vim.api.nvim_set_hl(0, 'lualine_c_inactive', { fg='#666677', bg='none' })
			end
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
