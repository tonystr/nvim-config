return {
	{
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate'
	},
	{ 'kylechui/nvim-surround' },
	{
		'Wansmer/treesj',
		keys = {
			{ '<Enter>', function() require"treesj".toggle() end },
			{ 'gS', function() require"treesj".split() end },
			{ 'gJ', function() require"treesj".join() end },
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
		'stevearc/oil.nvim',
		keys = { { '<leader>oi', function() require'oil'.open_float() end } },
		dependencies = { 'nvim-telescope/telescope.nvim' },
		config = {
			skip_confirm_for_simple_edits = true,
			default_file_explorer = true,
			float = { padding = 4, max_height = 24 },
			keymaps = {
				['<leader>fg'] = {
					function()
						require'telescope.builtin'.live_grep{
							cwd = require'oil'.get_current_dir()
						}
					end,
					mode = 'n',
					nowait = true,
					desc = "Find files in the current directory"
				},
				['<C-p>'] = {
					function()
						require'telescope.builtin'.find_files{
							cwd = require'oil'.get_current_dir()
						}
					end,
					mode = 'n',
					nowait = true,
					desc = "Find files in the current directory"
				}
			},
		},
	},
}
