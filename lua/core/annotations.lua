---@class AnnotationConfig
---@field keywords string[]   -- list of keywords (uppercase)
---@field delay integer       -- re-scan delay in ms

--- User configuration
---@type AnnotationConfig
local config = {
    keywords = { "TODO", "NOTE" },
    delay = 100,
}

local ns = vim.api.nvim_create_namespace("annotation")
local timer ---@type uv_timer_t?
local enabled = false

---Check if position is inside a comment.
---@param bufnr integer
---@param row integer
---@param col integer
---@return boolean
local function is_comment(bufnr, row, col)
    local ok, ts = pcall(require, "vim.treesitter")
    if ok and ts.highlighter.active[bufnr] then
        for _, cap in ipairs(vim.treesitter.get_captures_at_pos(bufnr, row, col) or {}) do
            if cap[2] and cap[2]:match("comment") then
                return true
            end
        end
        return false
    end

    local id = vim.fn.synID(row + 1, col + 1, true)
    return id > 0 and vim.fn.synIDattr(id, "name"):match("Comment") ~= nil
end

local function scan(bufnr, start, finish)
    if not vim.api.nvim_buf_is_valid(bufnr) then
        return
    end

    local last = vim.api.nvim_buf_line_count(bufnr) - 1
    start = math.max(start, 0)
    finish = math.min(finish, last)
    if start > finish then
        return
    end

    vim.api.nvim_buf_clear_namespace(bufnr, ns, start, finish + 1)

    local lines = vim.api.nvim_buf_get_lines(bufnr, start, finish + 1, false)
    for i, line in ipairs(lines) do
        local row = start + i - 1
        local upper = line:upper()

        for _, key in ipairs(config.keywords) do
            -- Must be KEYWORD:
            local target = key .. ":"
            local s, e = upper:find(target, 1, true)
            if s and is_comment(bufnr, row, s - 1) then
                local colon_col = e - 1 -- index of ':'
                local before = s - 2    -- possible preceding space

                -- background highlight range:
                -- include preceding space *iff* it exists and is a space
                local start_col = s - 1
                if before >= 0 and line:sub(before + 1, before + 1) == " " then
                    start_col = before
                end

                -- highlight keyword + colon background
                vim.api.nvim_buf_set_extmark(bufnr, ns, row, start_col, {
                    end_col = e,                    -- up to colon
                    hl_group = "Annotation" .. key, -- user-colorscheme-defined
                    priority = 100,
                })

                -- overlay colon with a single space (visually hides it)
                vim.api.nvim_buf_set_extmark(bufnr, ns, row, colon_col, {
                    virt_text = { { " " } },
                    virt_text_pos = "overlay",
                    hl_mode = "combine",
                    priority = 200,
                })
            end
        end
    end
end

local function schedule()
    if not enabled then
        return
    end
    if timer and timer:is_active() then
        timer:stop()
    end

    timer = vim.uv.new_timer()
    timer:start(
        config.delay,
        0,
        vim.schedule_wrap(function ()
            local buf = vim.api.nvim_get_current_buf()
            if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].buftype ~= "" then
                return
            end
            scan(buf, vim.fn.line("w0") - 1, vim.fn.line("w$") - 1)
        end)
    )
end

local function init()
    if enabled then
        return
    end
    enabled = true

    for _, key in ipairs(config.keywords) do
        vim.api.nvim_set_hl(0, "Annotation" .. key, {})
    end

    local grp = vim.api.nvim_create_augroup("Annotation", { clear = true })

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWinEnter" }, {
        group = grp,
        callback = function (args)
            vim.schedule(function ()
                scan(args.buf, vim.fn.line("w0") - 1, vim.fn.line("w$") - 1)
            end)
        end,
    })

    -- Reapply highlights on changes (debounced)
    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
        group = grp,
        callback = schedule,
    })

    -- Reapply when scrolling
    vim.api.nvim_create_autocmd("WinScrolled", {
        group = grp,
        callback = schedule,
    })
end

init()
