return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        local filetypes = {
            'c',
            'cpp',
            'go',
            'lua',
            'luadoc',
            'bash',
            'html',
            'markdown',
            'vim',
            'vimdoc',
            'diff',
            'css',
            'clojure',
        }

        local treesitter = require('nvim-treesitter')
        treesitter.install(filetypes)

        vim.api.nvim_create_autocmd('FileType', {
            pattern = filetypes,
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
