-- Save and reload config
vim.keymap.set('n', '<leader>o', function()
    local name = vim.api.nvim_buf_get_name(0)
    if name:sub(-4) == '.lua' then
        vim.cmd('update | source %')
    else
        vim.notify('Not a Lua file', vim.log.levels.WARN)
    end
end)

-- Basic editing
vim.keymap.set('n', '<leader>w', ':w<CR>')          -- Save file
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Clear search highlight

-- Quickfix navigation
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[q', ':cprev<CR>', { noremap = true, silent = true })

-- Diagnostic navigation (uses float windows)
vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump({ count = 1, float = true })
end)
vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump({ count = -1, float = true })
end)

-- Diagnostic utilities
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Leave terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- Window movement
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')

-- Move selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Scrolling (center cursor after movement)
vim.keymap.set('n', '<C-d>', '<C-d>zz', { silent = true, nowait = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { silent = true, nowait = true })

-- Delete without yanking
vim.keymap.set('x', '<leader>p', '"_dP')
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

-- Format buffer
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format) -- Format buffer

-- Toggle quickfix window
vim.keymap.set('n', '<leader>qf', function()
    local windows = vim.fn.getwininfo()
    for _, win in pairs(windows) do
        if win.quickfix == 1 then
            vim.cmd.cclose()
            return
        end
    end
    vim.cmd.copen()
end)

-- Oil
vim.keymap.set('n', '-', '<CMD>Oil<CR>')
vim.keymap.set('n', '<leader>-', require('oil').toggle_float)

-- TODO: Get rid of this
vim.keymap.set('n', '<leader>r', function()
    vim.cmd('PackageReload emerald')
    require('emerald').set_colorset('artichoke')
end)
