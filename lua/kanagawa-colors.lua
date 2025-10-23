-- Tony's special highlighting based on kanagawa
return function(colors)
	local theme = colors.theme

	return {
		Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
		PmenuSel = { fg = 'none', bg = theme.ui.bg_p2 },
		PmenuSbar = { bg = theme.ui.bg_p1  },
		PmenuThumb = { bg = theme.ui.bg_p2 },
		CursorLine = { bg = 'none' },
		CursorLineNr = { fg = theme.ui.fg_dim },
		['@string.regex'] = { fg = theme.syn.special1 },
		['@property.class.scss'] = { fg = theme.syn.type },
		['@property.class.css'] = { fg = theme.syn.type },
		['@type.scss'] = { fg = theme.syn.special1 },
		['@type.css'] = { fg = theme.syn.special1 },
		['@string.unit.scss'] = { fg = theme.syn.type },
		['@string.unit.css'] = { fg = theme.syn.type },
		['@type.tag.scss'] = { fg = theme.syn.special1 },
		['@type.tag.css'] = { fg = theme.syn.special1 },

		-- Special elements [vue]
		['@template.tag.vue'] = { fg = theme.syn.identifier },
		['@style.tag.vue'] = { fg = theme.syn.identifier },
		['@script.tag.vue'] = { fg = theme.syn.identifier },

		['@type.definition.scss'] = { fg = theme.ui.fg },
		['@type.definition.css'] = { fg = theme.ui.fg },
		['@constructor.javascript'] = { fg = theme.syn.fun },
		['@conceal.json'] = { fg = theme.syn.type },
		['@variable.member.typescript'] = { fg = theme.syn.identifier },
		['@lsp.typemod.variable.local.vue'] = { fg = theme.ui.fg },
		['@lsp.typemod.property.defaultLibrary.vue'] = { fg = theme.syn.special1 },

		['@lsp.type.namespace.rust'] = { link = 'Special' },

		IndentBlanklineContextChar = { fg='#4a4a58' },
		IndentBlanklineChar = { fg='#2f2f3f' },
		Folded = { bg='none' },
		['VimwikiHeader1'] = { fg='#ffd282' },

		Comment = { fg='#666677', italic=true },
		NonText = { fg='#2f2f3f' },

		-- LineNr = { bg='none', fg='#54546D' },
		-- CursorLine = {},
		EndOfBuffer = { ctermfg='black', fg='#1f1f28' },
		Whitespace = { fg='#4a4a58' },
		VertSplit = { ctermbg='none', bg='none', fg='#4a4a58' },
		TelescopeSelection = { bg='none', fg='#ffffff' },
		TelescopeBorder = { bg='none'--[[ , fg='#ffffff' ]] },
		MoreMsg = { bg='none', fg='#ffd282' },
		-- Pmenu = { bg='#2a2a37' },
		-- PmenuSel = { bg='#c0a36e', fg='#000000' },
		-- PmenuThumb = { bg='#3c3c4a' },
		lualine_c_normal = { fg='#666677' },
		lualine_c_inactive = { fg='#666677' },
		GitSignsUntracked = { fg='#8899ff' },
		StatusLine = { fg='#666677' },

		NormalFloat = { bg='none' },
		FloatBorder = { bg='none', fg='#666677' },
		FloatTitle = { bg='none', fg='#868697' },

		-- Visual & search
		Visual = { bg = '#363646' },
		Search = { bg = '#363646' },
		IncSearch = { bg='#54546d', fg='#C8C093', underline=false },
		CurSearch = { bg='#54546d', fg='#C8C093', underline=false },

		UfoCursorFoldedline = { bg='#363646' },

		-- Illuminated word highlight
		LspReferenceRead =     { bg='#363646', underline=false },
		LspReferenceWrite =    { bg='#363646', underline=false },
		LspReferenceText =     { bg='#363646', underline=false },
		illuminatedWord =      { bg='#363646', underline=false },
		IlluminatedWordText =  { bg='#363646', underline=false },
		IlluminatedWordRead =  { bg='#363646', underline=false },
		IlluminatedWordWrite = { bg='#363646', underline=false },

		-- Diagnostics
		DiagnosticUnderlineError = { sp='#e82424', underline=true, undercurl=false },
		DiagnosticUnderlineWarn =  { sp='#ff9e3b', underline=true, undercurl=false },
		DiagnosticUnderlineInfo =  { sp='#658594', underline=true, undercurl=false },
		DiagnosticUnderlineHint =  { sp='#659589', underline=true, undercurl=false },

		DiagnosticError = { bg='#382b3e', fg='#e82424' },
		DiagnosticWarn =  { bg='#373641', fg='#ffcb6b' },
		DiagnosticInfo =  { bg='#2c2c3e', fg='#658594' },
		DiagnosticHint =  { bg='#2a323a', fg='#6a9589' },

		-- Flog
		FlogBranch0 =  { fg='#e82424' },
		FlogBranch1 =  { fg='#658594' },
		FlogBranch2 =  { fg='#ffcb6b' },
		FlogBranch3 =  { fg='#8899ff' },
		FlogBranch4 =  { fg='#957fb8' },
		FlogBranch5 =  { fg='#c8c093' },

		-- diffAdd =  { bg='#103420' },
		-- diffText = { bg='#363646' },
		diffAdded = { bg='#003232', fg='#80cf9f' },
		diffRemoved = { bg='#321210', fg='#f27687' },
		fugitiveHunk = { fg='#aab0c0' },
		diffSubname = { bg='#322a6a', fg='#e77f58' },
		diffLine = { bg='#322a6a', fg='#977ff8' },

		-- Barbar
		BufferCurrentMod = { fg='#cfcfd0', bg='#2a2a37'  },
		BufferInactiveMod = { fg='#888888', bg='#16161d' },
		BufferVisibleMod = { fg='#888888', bg='#2a2a37' },
		BufferTabpageFill = { bg='#16161d' },
	}
end
