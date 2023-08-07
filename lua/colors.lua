local hi = vim.api.nvim_set_hl

-- Tony's special highlighting based on kanagawa
vim.cmd.colorscheme('kanagawa')
-- hi(0, 'LineNr', { bg='none', fg='#54546D' })
-- hi(0, 'CursorLine', {})
hi(0, 'CursorLineNR', { ctermfg='yellow', fg='#C8C093' })
hi(0, 'EndOfBuffer', { ctermfg='black', fg='#1f1f28' })
hi(0, 'Comment', { fg='#666677', italic=true })
hi(0, 'Whitespace', { fg='#4a4a58' })
hi(0, 'VertSplit', { ctermbg='none', bg='none', fg='#4a4a58' })
hi(0, 'Folded', { bg='none' })
hi(0, 'DiagnosticWarn', { fg='#ffcb6b' })
hi(0, 'TelescopeSelection', { bg='none', fg='#ffffff' })
hi(0, 'MoreMsg', { bg='none', fg='#ffd282' })
hi(0, 'IndentBlanklineContextChar', { fg='#4a4a58' })
hi(0, 'IndentBlanklineChar', { fg='#2f2f3f' })
-- hi(0, 'Pmenu', { bg='#2a2a37' })
-- hi(0, 'PmenuSel', { bg='#c0a36e', fg='#000000' })
-- hi(0, 'PmenuThumb', { bg='#3c3c4a' })
hi(0, 'lualine_c_normal', { fg='#666677' })
hi(0, 'lualine_c_inactive', { fg='#666677' })
hi(0, 'GitSignsUntracked', { fg='#8899ff' })
hi(0, 'StatusLine', { fg='#666677' })

hi(0, 'NormalFloat', { bg='none' })
hi(0, 'FloatBorder', { bg='none', fg='#666677' })
hi(0, 'FloatTitle', { bg='none', fg='#868697' })

-- Visual & search
hi(0, 'Visual', { bg = '#363646' })
hi(0, 'Search', { bg = '#363646' })
hi(0, 'IncSearch', { bg='#54546d', fg='#C8C093', underline=false })
hi(0, 'CurSearch', { bg='#54546d', fg='#C8C093', underline=false })

hi(0, 'UfoCursorFoldedline', { bg='#363646' })

-- Illuminated word highlight
hi(0, 'LspReferenceRead',     { bg='#363646', underline=false })
hi(0, 'LspReferenceWrite',    { bg='#363646', underline=false })
hi(0, 'LspReferenceText',     { bg='#363646', underline=false })
hi(0, 'illuminatedWord',      { bg='#363646', underline=false })
hi(0, 'IlluminatedWordText',  { bg='#363646', underline=false })
hi(0, 'IlluminatedWordRead',  { bg='#363646', underline=false })
hi(0, 'IlluminatedWordWrite', { bg='#363646', underline=false })

-- Diagnostics
hi(0, 'DiagnosticUnderlineError', { sp='#e82424', underline=true })
hi(0, 'DiagnosticUnderlineWarn',  { sp='#ff9e3b', underline=true })
hi(0, 'DiagnosticUnderlineInfo',  { sp='#658594', underline=true })
hi(0, 'DiagnosticUnderlineHint',  { sp='#659589', underline=true })

hi(0, 'DiagnosticError', { bg='#382b3e', fg='#e82424' })
hi(0, 'DiagnosticWarn',  { bg='#373641', fg='#ffcb6b' })
hi(0, 'DiagnosticInfo',  { bg='#2c2c3e', fg='#658594' })
hi(0, 'DiagnosticHint',  { bg='#2a323a', fg='#6a9589' })

-- Flog
hi(0, 'FlogBranch0',  { fg='#e82424' })
hi(0, 'FlogBranch1',  { fg='#658594' })
hi(0, 'FlogBranch2',  { fg='#ffcb6b' })
hi(0, 'FlogBranch3',  { fg='#8899ff' })
hi(0, 'FlogBranch4',  { fg='#957fb8' })
hi(0, 'FlogBranch5',  { fg='#c8c093' })

hi(0, 'DiffAdd',  { bg='#103420' })
hi(0, 'DiffText', { bg='#363646' })

-- Barbar
hi(0, 'BufferCurrentMod', { fg='#cfcfd0', bg='#2a2a37'  })
hi(0, 'BufferInactiveMod', { fg='#888888', bg='#16161d' })
hi(0, 'BufferVisibleMod', { fg='#888888', bg='#2a2a37' })
hi(0, 'BufferTabpageFill', { bg='#16161d' })
