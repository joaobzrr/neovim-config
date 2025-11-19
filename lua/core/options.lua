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

 -- Completion options
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
