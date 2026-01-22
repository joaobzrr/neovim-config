return {
    'stevearc/oil.nvim',
    dependencies = {
        'nvim-mini/mini.icons',
    },
    config = function()
        require('mini.icons').setup()
        require('oil').setup({
            view_options = {
                show_hidden = true,
                natural_order = 'fast',
            },
        })
    end,
}
