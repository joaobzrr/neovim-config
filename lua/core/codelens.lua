local M = {}

local codelens_namespace = vim.api.nvim_create_namespace("custom_codelens")
local timers = {}
local buffer_state = {}

local function request_codelenses(bufnr)
    if timers[bufnr] then
        timers[bufnr]:stop()
        timers[bufnr]:close()
        timers[bufnr] = nil
    end

    timers[bufnr] = vim.defer_fn(function ()
        timers[bufnr] = nil

        if not vim.api.nvim_buf_is_valid(bufnr) then
            return
        end

        local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "jot_ls" })
        if #clients == 0 then
            return
        end

        local params = { textDocument = vim.lsp.util.make_text_document_params(bufnr) }

        vim.lsp.buf_request_all(bufnr, "textDocument/codeLens", params, function (results, ctx)
            if not vim.api.nvim_buf_is_valid(bufnr) then
                return
            end

            local current_version = vim.lsp.util.buf_versions[bufnr]
            if ctx.version and current_version ~= ctx.version then
                return
            end

            local state = buffer_state[bufnr]
            if not state then
                return
            end

            local lenses_by_line = {}
            for _, response in pairs(results) do
                if response.result and not response.err then
                    for _, lens in ipairs(response.result) do
                        local line = lens.range.start.line
                        local text = lens.command and lens.command.title or ""
                        if text ~= "" then
                            lenses_by_line[line] = lenses_by_line[line] or {}
                            table.insert(lenses_by_line[line], text)
                        end
                    end
                end
            end

            state.lenses_by_line = lenses_by_line
            state.version = current_version
            state.row_version = {}

            vim.api.nvim__redraw({ buf = bufnr, valid = true, flush = false })
        end)
    end, 200)
end

local function render_visible(bufnr, toprow, botrow)
    local state = buffer_state[bufnr]
    if not state or not state.lenses_by_line then
        return
    end

    for row = toprow, botrow do
        if state.row_version and state.row_version[row] == state.version then
            goto continue
        end

        vim.api.nvim_buf_clear_namespace(bufnr, codelens_namespace, row, row + 1)

        local texts = state.lenses_by_line[row]
        if texts then
            local combined = table.concat(texts, " | ")
            vim.api.nvim_buf_set_extmark(bufnr, codelens_namespace, row, 0, {
                virt_text = { { combined, "LspCodeLens" } },
                virt_text_pos = "eol",
                hl_mode = "combine",
            })
        end

        if not state.row_version then
            state.row_version = {}
        end
        state.row_version[row] = state.version

        ::continue::
    end

    local line_count = vim.api.nvim_buf_line_count(bufnr)
    if botrow >= line_count - 1 then
        vim.api.nvim_buf_clear_namespace(bufnr, codelens_namespace, line_count, -1)
    end
end

function M.setup()
    vim.api.nvim_set_decoration_provider(codelens_namespace, {
        on_win = function (_, _, bufnr, toprow, botrow)
            if buffer_state[bufnr] then
                render_visible(bufnr, toprow, botrow)
            end
        end,
    })
end

function M.attach(bufnr, client_id)
    local client = vim.lsp.get_client_by_id(client_id)
    if not client then
        return
    end

    vim.lsp.codelens.enable(false, { bufnr = bufnr })

    buffer_state[bufnr] = {
        lenses_by_line = {},
        version = 0,
        row_version = {},
    }

    request_codelenses(bufnr)

    vim.api.nvim_create_autocmd(
        { "TextChanged", "InsertLeave", "BufEnter", "BufWritePost" },
        {
            buffer = bufnr,
            group = vim.api.nvim_create_augroup("my.codelens." .. bufnr, {}),
            callback = function ()
                request_codelenses(bufnr)
            end,
        })

    client.handlers["workspace/codeLens/refresh"] = function ()
        local client_obj = vim.lsp.get_client_by_id(client_id)
        if not client_obj then return nil end

        for bnr, _ in pairs(client_obj.attached_buffers) do
            if vim.api.nvim_buf_is_valid(bnr) and buffer_state[bnr] then
                request_codelenses(bnr)
            end
        end
        return nil
    end
end

function M.detach(bufnr)
    buffer_state[bufnr] = nil
    if timers[bufnr] then
        timers[bufnr]:stop()
        timers[bufnr]:close()
        timers[bufnr] = nil
    end
end

return M
