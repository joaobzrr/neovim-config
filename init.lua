vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('core.options')
require('core.keymaps')
require('core.autocomplete')

require('plugins.treesitter')
require('plugins.oil')
require('plugins.tokyonight')
require('plugins.picker')
require('plugins.diff')
require('plugins.jai')
require('plugins.todo-comments')
require('plugins.notes')
require('plugins.emerald')

vim.lsp.enable({ 'lua_ls' })
