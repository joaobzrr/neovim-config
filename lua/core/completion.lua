local function has_docs(doc)
    if not doc then return false end
    if type(doc) == "string" then
        return doc ~= ""
    end
    return doc.value and doc.value ~= ""
end

local function show_docs(doc, selected)
    local value = type(doc) == "string" and doc or doc.value
    local filetype = (doc.kind == "markdown") and "markdown" or ""


    -- NOTE: nvim__complete_set is internal and *may change in future*.
    -- If it ever changes, completion popup APIs will need updating here.
    local preview = vim.api.nvim__complete_set(selected, { info = value })
    if preview.bufnr then
        vim.bo[preview.bufnr].filetype = filetype

        vim.api.nvim_win_set_config(preview.winid, { border = 'rounded' })
    end
end

local function update_docs(completed_item)
    if not completed_item then return end

    -- Did this completion come from LSP?
    local lsp_item = completed_item.user_data
        and completed_item.user_data.nvim
        and completed_item.user_data.nvim.lsp
        and completed_item.user_data.nvim.lsp.completion_item

    if not lsp_item then
        -- Non-LSP completion → clear filetype (optional)
        return
    end

    -- If docs already present, show immediately.
    if has_docs(lsp_item.documentation) then
        local selected = vim.fn.complete_info({ "selected" }).selected
        show_docs(lsp_item.documentation, selected)
        return
    end

    --------------------------------------------------------------------
    -- Documentation not included → try completionItem/resolve
    -- IMPORTANT: Most LSP servers support resolve, but not all.
    -- If support detection becomes stable in future Neovim versions,
    -- replace this unconditional resolve with a capability check.
    --------------------------------------------------------------------
    local client_id = completed_item.user_data.nvim.lsp.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    if not client then return end

    client:request(
        "completionItem/resolve",
        lsp_item,
        function(err, res)
            if err or not res or not has_docs(res.documentation) then
                return
            end
            local sel = vim.fn.complete_info({ "selected" }).selected
            show_docs(res.documentation, sel)
        end
    )
end

local function enable_lsp_doc_popup(bufnr)
    vim.api.nvim_create_autocmd("CompleteChanged", {
        group = vim.api.nvim_create_augroup("LspDocPopup" .. bufnr, {}),
        buffer = bufnr,
        callback = function()
            if vim.fn.pumvisible() == 0 then return end
            update_docs(vim.v.event.completed_item)
        end,
    })
end

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(e)
        local client = vim.lsp.get_client_by_id(e.data.client_id)
        if not client then return end

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, e.buf, { autotrigger = true })
            enable_lsp_doc_popup(e.buf)
        end
    end,
})
