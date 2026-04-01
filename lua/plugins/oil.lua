vim.pack.add({
    'https://github.com/nvim-mini/mini.icons',
    'https://github.com/stevearc/oil.nvim',
})

require('mini.icons').setup()
require('oil').setup({
    view_options = {
        show_hidden = true,
        natural_order = "fast",
    },
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>")
vim.keymap.set("n", "<leader>-", require("oil").toggle_float)
