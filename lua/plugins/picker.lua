return {
    'nvim-mini/mini.pick',
    config = function()
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
                        relative = 'editor',
                        anchor = 'SW',
                        width = max_width,
                        height = height,
                        row = max_height,
                        col = 0,
                        border = 'rounded',
                    }
                end,
            },
        })

        vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
        vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
        vim.keymap.set('n', '<leader>g', ':Pick grep_live<CR>')

        vim.keymap.set('n', '<leader>cg', function()
            MiniPick.builtin.files(nil, {
                source = { name = 'Config files', cwd = vim.fn.stdpath('config') },
            })
        end)

        vim.keymap.set('n', '<leader>cg', function()
            MiniPick.builtin.grep_live(nil, {
                source = { name = 'Config grep', cwd = vim.fn.stdpath('config') },
            })
        end)

        local function get_jai_path()
            local jai_path = os.getenv('JAI_PATH')
            if not jai_path then
                vim.notify('JAI_PATH is not set')
                return '', false
            end
            return jai_path, true
        end

        vim.keymap.set('n', '<leader>jf', function()
            local jai_path, ok = get_jai_path()
            if not ok then
                return
            end

            MiniPick.builtin.files(nil, {
                source = { name = 'Jai files', cwd = jai_path },
            })
        end)

        vim.keymap.set('n', '<leader>jg', function()
            local jai_path, ok = get_jai_path()
            if not ok then
                return
            end

            MiniPick.builtin.grep_live(nil, {
                source = { name = 'Jai grep', cwd = jai_path },
            })
        end)
    end,
}
