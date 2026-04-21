vim.pack.add({
    'https://github.com/nvim-mini/mini.pick',
    'https://github.com/nvim-mini/mini.extra',
})

require('mini.pick').setup({
    window = {
        config = function()
            local has_tabline = vim.o.showtabline == 2
                or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)
            local has_statusline = vim.o.laststatus > 0

            local max_height = vim.o.lines
                - vim.o.cmdheight
                - (has_tabline and 1 or 0)
                - (has_statusline and 1 or 0)
            local max_width = vim.o.columns

            local height = math.max(math.floor(0.15 * vim.o.lines), 8)

            return {
                relative = "editor",
                anchor = "SW",
                width = max_width,
                height = height,
                row = max_height,
                col = 0,
                border = "rounded",
            }
        end,
    },
})

require('mini.extra').setup()

local local_pick_dir = "_local"

local function extra_paths()
    if local_pick_dir and vim.fn.isdirectory(local_pick_dir) == 1 then
        return { ".", local_pick_dir }
    end
    return { "." }
end

local function show_with_icons(buf_id, items, query)
    return MiniPick.default_show(buf_id, items, query, { show_icons = true })
end

-- Help
vim.keymap.set("n", "<leader>h", ":Pick help<CR>")

-- TODO:
-- 1) remove period at the beginning of paths
-- 2) color icons correctly
--
-- Project files
vim.keymap.set("n", "<leader>f", function()
    local paths = extra_paths()
    local command = vim.list_extend({ "rg", "--files", "--color=never" }, paths)
    MiniPick.builtin.cli({
        command = command,
        postprocess = function(items)
            return vim.tbl_map(function(item)
                return item:gsub("^%./", "")
            end, items)
        end,
    }, {
        source = {
            name = "Files (rg)",
            show = show_with_icons,
        },
    })
end)

-- TODO:
-- 1) remove period at the beginning of paths
-- 2) color icons correctly
--
-- Project grep live
vim.keymap.set("n", "<leader>g", function()
    local paths = extra_paths()
    local cwd = vim.fn.getcwd()
    local set_items_opts = { do_match = false, querytick = MiniPick.get_querytick() }
    local spawn_opts = { cwd = cwd }
    local sys = { kill = function() end }

    local match = function(_, _, query)
        sys:kill()
        if MiniPick.get_querytick() == set_items_opts.querytick then return end
        if #query == 0 then
            sys = { kill = function() end }
            return MiniPick.set_picker_items({}, set_items_opts)
        end

        set_items_opts.querytick = MiniPick.get_querytick()
        local pattern = table.concat(query)
        local case = vim.o.ignorecase
            and (vim.o.smartcase and "smart-case" or "ignore-case")
            or "case-sensitive"
        local command = vim.list_extend({
            "rg",
            "--column",
            "--line-number",
            "--no-heading",
            "--field-match-separator", "\\x00",
            "--color=never",
            "--" .. case,
            "--",
            pattern,
        }, vim.deepcopy(paths))
        sys = MiniPick.set_picker_items_from_cli(command, {
            set_items_opts = set_items_opts,
            spawn_opts = spawn_opts,
        })
    end

    MiniPick.start({
        source = {
            name = "Grep live (rg)",
            items = {},
            match = match,
            show = show_with_icons,
        },
    })
end)

-- Document symbols
vim.keymap.set("n", "<leader>s", function()
    MiniExtra.pickers.lsp({ scope = "document_symbol" })
end)

-- Neovim config files
vim.keymap.set("n", "<leader>cf", function()
    MiniPick.builtin.files(nil, {
        source = { name = "Config files", cwd = vim.fn.stdpath("config") },
    })
end)

-- Neovim config grep
vim.keymap.set("n", "<leader>cg", function()
    MiniPick.builtin.grep_live(nil, {
        source = { name = "Config grep", cwd = vim.fn.stdpath("config") },
    })
end)

local function get_jai_path()
    local jai_path = os.getenv("JAI_PATH")
    if not jai_path then
        vim.notify("JAI_PATH is not set")
        return "", false
    end
    return jai_path, true
end

-- Jai compiler files
vim.keymap.set("n", "<leader>jf", function()
    local jai_path, ok = get_jai_path()
    if not ok then return end
    MiniPick.builtin.files(nil, {
        source = { name = "Jai files", cwd = jai_path },
    })
end)

-- Jai compiler grep
vim.keymap.set("n", "<leader>jg", function()
    local jai_path, ok = get_jai_path()
    if not ok then return end
    MiniPick.builtin.grep_live(nil, {
        source = { name = "Jai grep", cwd = jai_path },
    })
end)
