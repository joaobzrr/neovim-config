local codelens = require("core.codelens")

vim.defer_fn(function ()
    codelens.setup()
end, 0)

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("my.lsp", {}),
    callback = function (ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

        if client.name == "jot_ls" and client.server_capabilities.codeLensProvider then
            codelens.attach(ev.buf, client.id)
        end
    end,
})

vim.api.nvim_create_autocmd("BufDelete", {
    group = vim.api.nvim_create_augroup("my.codelens.cleanup", {}),
    callback = function (ev)
        codelens.detach(ev.buf)
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("my.yank", {}),
    callback = function ()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})
