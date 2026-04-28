vim.g.mapleader = ' '

vim.o.path = vim.o.path .. '**'
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.number = true
vim.o.relativenumber = true
vim.o.grepprg = 'rg --vimgrep --no-heading --smart-case'

require 'config.lazy'
