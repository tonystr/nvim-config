local settings = {
	-- every line should be same width without escaped \
	header = {
		type = "text",
		oldfiles_directory = false,
		align = "center",
		fold_section = false,
		title = "Header",
		margin = 5,
		content = {
			[[   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ]],
			[[    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ]],
			[[          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ]],
			[[           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ]],
			[[          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ]],
			[[   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ]],
			[[  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ]],
			[[ ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ]],
			[[ ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ]],
			[[      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ]],
			[[       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ]],
			[[         ⠻⣿⣿⣿⣿ NEOVIM ⣿⣿⣿⡿⠋⠉       ]]
		},
		highlight = "Statement",
		default_color = "",
		oldfiles_amount = 0,
	},
	header_2 = {
		type = "text",
		oldfiles_directory = false,
		align = "center",
		fold_section = false,
		title = "Quote",
		margin = 8,
		content = require'startup.themes.quotes'(),
		highlight = "Constant",
		default_color = "",
		oldfiles_amount = 0,
	},
	body = {
		type = "mapping",
		oldfiles_directory = false,
		align = "center",
		fold_section = false,
		title = "Basic Commands",
		margin = 0,
		content = {
			{ "Note", "1VimwikiMakeDiaryNote", "1" },
			{ "Work note", "2VimwikiMakeDiaryNote", "2" },
			{ "Startup note", "3VimwikiMakeDiaryNote", "3" },
			{ "SoundShop frontend", "norm `S", "s" },
			{ "SoundShop api", "norm `E", "e" },
		},
		highlight = "Comment",
		default_color = "#1f1f28",
		oldfiles_amount = 0,
	},
	-- name which will be displayed and command
	-- footer = {
	-- 	type = "text",
	-- 	oldfiles_directory = false,
	-- 	align = "center",
	-- 	fold_section = false,
	-- 	title = "Footer",
	-- 	margin = 15,
	-- 	content = { "" },
	-- 	-- content = function()
 --  --           local date = " " .. os.date("%d/%m/%y")
 --  --           return { date }
 --  --       end,
	-- 	highlight = "Number",
	-- 	default_color = "",
	-- 	oldfiles_amount = 0,
	-- },

	options = {
		mapping_keys = true,
		cursor_column = 0.5,
		empty_lines_between_mappings = true,
		disable_statuslines = true,
		paddings = { 1, 3, 3, 0 },
	},
	mappings = {
		execute_command = "<CR>",
		open_file = "o",
		open_file_split = "<c-o>",
		open_section = "<TAB>",
		open_help = "?",
	},
	colors = {
		background = "#1f2227",
		folded_section = "#56b6c2",
	},
	parts = {
		"header",
		"header_2",
		"body",
		-- "footer",
	},
}
return settings
