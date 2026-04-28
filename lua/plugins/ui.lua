return {
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
		'nvim-telescope/telescope.nvim',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		},
		config = function()
			local builtin = require'telescope.builtin'
			vim.keymap.set('n', '<C-p>', builtin.find_files)
			vim.keymap.set('n', '<leader>fg', builtin.live_grep)
			vim.keymap.set('n', '<leader>fh', builtin.help_tags)
			vim.keymap.set('n', '<leader>fo', builtin.oldfiles)
		end
	},
	{
		'tpope/vim-fugitive',
		cmd = { 'G', 'Gwrite', 'Git', 'Gdiffsplit', 'Gvdiffsplit' },
		dependencies = { 'tpope/vim-rhubarb' }
	},
	{
		'rebelot/kanagawa.nvim',
		lazy = false,
		opts = {
			colors = { theme = { all = { ui = { bg_gutter = 'none' }}}},
			overrides = require'kanagawa-colors'
		},
		config = function(_, opts)
			require'kanagawa'.setup(opts)
			vim.cmd'colorscheme kanagawa'

			-- if not vim.g.neovide then
			-- 	vim.api.nvim_set_hl(0, 'Normal', { fg='#dcd7ba', ctermbg='none', bg='none' })
			-- else
			-- 	vim.api.nvim_set_hl(0, 'Normal', { fg='#dcd7ba', ctermbg='none', bg='#131315' })
			--
			-- 	vim.g.neovide_title_background_color = string.format(
			-- 		"%x",
			-- 		vim.api.nvim_get_hl(0, {id=vim.api.nvim_get_hl_id_by_name("Normal")}).bg
			-- 	)
			-- end
		end,
		priority = 1000,
	},
}
