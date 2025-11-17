vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'c', 'cpp', 'go', 'lua', 'luadoc', 'bash', 'html', 'markdown', 'vim',
    'vimdoc', 'diff',
  },
  highlight = { enable = true },
})
