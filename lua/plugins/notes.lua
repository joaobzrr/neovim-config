vim.opt.rtp:prepend(vim.fn.expand('~/dev/nvim/notes.nvim'))

require('notes').setup({
    server_path = "/home/bzrr/dev/bzrr/notes-ls/run/notes-ls",
    vault_root = vim.fn.expand("~/notes"),
})
