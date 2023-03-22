local hi = vim.api.nvim_set_hl

-- Tony's special highlighting based on kanagawa
vim.cmd.colorscheme('kanagawa')
hi(0, 'LineNr', { bg='none', fg='#54546D' })
hi(0, 'CursorLine', {})
hi(0, 'CursorLineNR', { ctermfg='yellow', fg='#C8C093' })
hi(0, 'EndOfBuffer', { ctermfg='black', fg='#1f1f28' })
hi(0, 'Comment', { fg='#666677' })
hi(0, 'Whitespace', { fg='#4a4a58' })
hi(0, 'VertSplit', { ctermbg='none', bg='none', fg='#4a4a58' })
hi(0, "Search", { fg = "#ffffff", bg = "#3c66f2" })
hi(0, 'Folded', { bg='none' })
hi(0, 'SignColumn', { bg='none' })
hi(0, 'IncSearch', { bg='#40b266', fg='#ffffff' })
hi(0, 'BufferCurrentMod', { fg='#cfcfd0' })
hi(0, 'BufferInactiveMod', { fg='#888888' })
hi(0, 'BufferVisibleMod', { fg='#888888' })
hi(0, 'DiagnosticWarn', { fg='#ffcb6b' })
hi(0, 'TelescopeSelection', { bg='none', fg='#ffffff' })
hi(0, 'MoreMsg', { bg='none', fg='#ffd282' })
hi(0, 'illuminatedWord', { bg='#33333a' })
hi(0, 'illuminatedWordRead', { bg='#33333a' })
hi(0, 'illuminatedWordWrite', { bg='#33333a' })
hi(0, 'IndentBlanklineContextChar', { fg='#4a4a58' })
hi(0, 'IndentBlanklineChar', { fg='#2f2f3f' })
hi(0, 'Pmenu', { bg='#2a2a37' })
hi(0, 'PmenuSel', { bg='#c0a36e', fg='#000000' })
hi(0, 'PmenuThumb', { bg='#3c3c4a' })

-- hi(0, 'GitSignsAdd', { bg='' })
-- hi(0, 'GitSignsChange', { bg='' })
-- hi(0, 'GitSignsDelete', { bg='' })
-- hi(0, 'GitSignsUntracked', { bg='' })
-- hi(0, 'DiagnosticSignError', { bg='' })
-- hi(0, 'DiagnosticSignHint', { bg='' })
-- hi(0, 'DiagnosticSignInfo', { bg='' })
-- hi(0, 'DiagnosticSignWarn', { bg='' })
-- hi(0, 'Statement', { cterm=nocombine gui=nocombine })
-- hi(0, 'VueComponentName', { fg='#ffcb6b' })