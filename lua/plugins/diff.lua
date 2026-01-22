return {
    'esmuellert/codediff.nvim',
    dependencies = {
        'MunifTanjim/nui.nvim',
    },
    config = function()
        require('codediff').setup({
            highlights = {
                line_insert = 'DiffAdd',
                line_delete = 'DiffDelete',
                char_brightness = 1.8,
            },
        })
    end,
}
