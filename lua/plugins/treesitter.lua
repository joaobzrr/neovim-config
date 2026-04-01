vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        if ev.data.spec.name == 'nvim-treesitter' and (ev.data.kind == 'install' or ev.data.kind == 'update')
        then
            vim.cmd('TSUpdate')
        end
    end
})

vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

local filetypes = {
    "c", "cpp", "go", "lua", "luadoc", "bash", "html",
    "markdown", "vim", "vimdoc", "diff", "css", "clojure",
}

require('nvim-treesitter').install(filetypes)

vim.api.nvim_create_autocmd("FileType", {
    pattern = filetypes,
    callback = function()
        vim.treesitter.start()
    end,
})
