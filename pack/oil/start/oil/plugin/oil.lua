vim.pack.add({ 'https://github.com/stevearc/oil.nvim' })

require('oil').setup()

vim.keymap.set('n', '-', '<CMD>Oil<CR>')
vim.keymap.set('n', '<leader>-', require('oil').toggle_float)
