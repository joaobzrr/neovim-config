vim.opt.rtp:prepend(vim.fn.expand('~/dev/nvim/emerald'))

require('emerald').setup({ colorset = 'artichoke' })
vim.cmd.colorscheme('emerald')
