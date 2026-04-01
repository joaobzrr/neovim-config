vim.pack.add({
    'https://github.com/MunifTanjim/nui.nvim',
    'https://github.com/esmuellert/codediff.nvim',
})

require('codediff').setup({
    highlights = {
        line_insert = "DiffAdd",
        line_delete = "DiffDelete",
    },
})
