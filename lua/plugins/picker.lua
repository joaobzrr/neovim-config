vim.pack.add({ "https://github.com/nvim-mini/mini.pick" })

local function win_config()
    local has_tabline = vim.o.showtabline == 2 or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)
    local has_statusline = vim.o.laststatus > 0

    local max_height = vim.o.lines - vim.o.cmdheight - (has_tabline and 1 or 0) - (has_statusline and 1 or 0)
    local max_width = vim.o.columns

    local height = math.max(math.floor(0.15 * vim.o.lines), 8)

    return {
        relative = 'editor',
        anchor = 'SW',
        width = max_width,
        height = height,
        row = max_height,
        col = 0,
        border = 'rounded'
    }
end

require('mini.pick').setup({
    window = {
        config = win_config
    }
})

local function truncate_path(path, max_width)
    max_width = max_width or 40
    if #path <= max_width then
        return path
    end

    local parts = vim.split(path, "/")
    local filename = parts[#parts]
    if #filename + 4 >= max_width then
        return "..." .. filename:sub(-(max_width - 3))
    end

    local tail = filename
    local i = #parts - 1

    while i > 0 do
        local next_tail = parts[i] .. "/" .. tail
        if #next_tail + 4 > max_width then
            break
        end
        tail = next_tail
        i = i - 1
    end

    if i == 0 then
        return tail
    end

    local head = parts[1]
    if #head + 4 + #tail <= max_width then
        return head .. "/.../" .. tail
    end

    return ".../" .. tail
end

MiniPick.registry.nice_grep = function(local_opts)
    local_opts = local_opts or {}
    local cwd = local_opts.cwd or vim.fn.getcwd()
    print('cwd: ' .. cwd)

    local set_items_opts = { do_match = false, querytick = MiniPick.get_querytick() }
    local spawn_opts = { cwd = cwd }

    local match = function(_, _, query)
        pcall(vim.loop.process_kill, process)
        if MiniPick.get_querytick() == set_items_opts.querytick then return end
        if #query == 0 then return MiniPick.set_picker_items({}, set_items_opts) end

        set_items_opts.querytick = MiniPick.get_querytick()
        local command = {
            'rg',
            '--column',
            '--line-number',
            '--no-heading',
            '--field-match-separator',
            '|',
            '--no-follow',
            '--color=never',
            '--',
            table.concat(query)
        }

        process = MiniPick.set_picker_items_from_cli(command, {
            set_items_opts = set_items_opts,
            spawn_opts = spawn_opts
        })
    end

    local show = function(buf_id, items, query)
        local parsed = {}
        local max_path, max_row, max_col = 0, 0, 0

        for _, item in ipairs(items) do
            local path, row, col, text = string.match(item, '^([^|]*)|([^|]*)|([^|]*)|(.*)$')

            local relpath = truncate_path(vim.fn.fnamemodify(path, ':.'), 40)

            row = tostring(row)
            col = tostring(col)

            text = text:gsub('^%s*(.-)%s*$', '%1')

            max_path = math.max(max_path, #relpath)
            max_row = math.max(max_row, #row)
            max_col = math.max(max_col, #col)

            table.insert(parsed, {
                path = relpath,
                row = row,
                col = col,
                text = text,
            })
        end

        local aligned = {}
        for _, entry in ipairs(parsed) do
            local path = entry.path .. string.rep(' ', max_path - #entry.path)
            local row  = string.rep(' ', max_row - #entry.row) .. entry.row
            local col  = string.rep(' ', max_col - #entry.col) .. entry.col

            table.insert(aligned, string.format('%s │ %s │ %s │ %s', path, row, col, entry.text))
        end

        MiniPick.default_show(buf_id, aligned, query, { show_icons = false })
    end

    local choose = function(item)
        local path, row, column = string.match(item, '^([^|]*)|([^|]*)|([^|]*)|.*$')
        local chosen = { path = path, lnum = tonumber(row), col = tonumber(column) }
        MiniPick.default_choose(chosen)
    end

    return MiniPick.start({
        source = {
            cwd = cwd,
            name = local_opts.name,
            items = {},
            match = match,
            show = show,
            choose = choose,
        }
    })
end

vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>g', ':Pick nice_grep<CR>')

local function get_jai_path()
    local jai_path = os.getenv('JAI_PATH')
    if not jai_path then
        vim.notify 'JAI_PATH is not set'
        return '', false
    end
    return jai_path, true
end

vim.keymap.set('n', '<leader>jf', function()
    local jai_path, ok = get_jai_path()
    if not ok then return end
    MiniPick.builtin.files(nil, {
        source = { name = 'Jai files', cwd = jai_path }
    })
end)

vim.keymap.set('n', '<leader>jg', function()
    local jai_path, ok = get_jai_path()
    if not ok then return end
    MiniPick.registry.nice_grep({ name = 'Jai grep', cwd = jai_path })
end)
