-- OPTIONS

-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Basics
vim.opt.number = true         -- Absolute line numbers
vim.opt.relativenumber = true -- Relative numbers for motion
vim.opt.cursorline = true     -- Highlight current line
vim.opt.signcolumn = 'yes'    -- Prevent text shifting when signs appear
vim.opt.scrolloff = 10        -- Keep 10 lines of padding when scrolling
vim.opt.mouse = 'a'           -- Enable mouse in all modes
vim.opt.showmode = false      -- Mode shown by statusline instead
vim.opt.winborder = 'rounded' -- Rounded floating window borders

-- Indentation
vim.opt.breakindent = true -- Preserve indent on wrapped lines
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.cinoptions = 'l1' -- Small tweak for C indentation rules

-- Search behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Case-sensitive only when uppercase used

-- Whitespace display
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
vim.opt.fillchars = vim.opt.fillchars + 'diff:╱' -- Character used in diff filler lines

-- Window behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Persistence and system integration
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.inccommand = 'split' -- Live :substitute preview

-- Timings
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300

-- GUI font
vim.opt.guifont = 'JetBrainsMonoNL NFM:h10'

vim.opt.loadplugins = true


-- GENERAL KEYMAPS

-- Save and reload config
vim.keymap.set('n', '<leader>o', function()
  local name = vim.api.nvim_buf_get_name(0)
  if name:sub(-4) == ".lua" then
    vim.cmd("update | source %")
  else
    vim.notify("Not a Lua file", vim.log.levels.WARN)
  end
end)

-- Basic editing
vim.keymap.set('n', '<leader>w', ':w<CR>')          -- Save file
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Clear search highlight

-- Quickfix navigation
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[q', ':cprev<CR>', { noremap = true, silent = true })

-- Diagnostic navigation (uses float windows)
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = 1, float = true }) end)
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = -1, float = true }) end)

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
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Delete without yanking
vim.keymap.set('x', '<leader>p', '"_dP')
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

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


-- AUTOCOMMANDS

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})


vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/neovim/nvim-lspconfig',
})

-- LSP

-- Enable LSP autocompletion when server supports it
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.cmd('set completeopt+=noselect')

vim.lsp.enable({ 'lua_ls' })
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format) -- Format buffer

-- Mason
require('mason').setup()

-- Diff colors
vim.api.nvim_set_hl(0, 'DiffviewDiffAdd', { bg = '#1d221d' })       -- Added line
vim.api.nvim_set_hl(0, 'DiffviewDiffTextGreen', { bg = '#173619' }) -- Added text
vim.api.nvim_set_hl(0, 'DiffviewDiffDelete', { bg = '#231b1a' })    -- Deleted line
vim.api.nvim_set_hl(0, 'DiffviewDiffTextRed', { bg = '#390e0e' })   -- Deleted text
vim.api.nvim_set_hl(0, 'DiffDelete', { fg = '#2b2b2b' })            -- Filler color

-- vim: ts=2 sts=2 sw=2 et
