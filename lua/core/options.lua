-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Basics
vim.o.number = true         -- Absolute line numbers
vim.o.relativenumber = true -- Relative numbers for motion
vim.o.cursorline = true     -- Highlight current line
vim.o.signcolumn = 'yes'    -- Prevent text shifting when signs appear
vim.o.scrolloff = 10        -- Keep 10 lines of padding when scrolling
vim.o.mouse = 'a'           -- Enable mouse in all modes
vim.o.showmode = false      -- Mode shown by statusline instead
vim.o.winborder = 'rounded' -- Rounded floating window borders

-- Indentation
vim.o.breakindent = true -- Preserve indent on wrapped lines
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.cinoptions = 'l1' -- Small tweak for C indentation rules

-- Search behavior
vim.o.ignorecase = true
vim.o.smartcase = true -- Case-sensitive only when uppercase used

-- Whitespace display
vim.o.list = true
--vim.o.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
--vim.o.fillchars = vim.o.fillchars + 'diff:╱' -- Character used in diff filler lines

-- Window behavior
vim.o.splitright = true
vim.o.splitbelow = true

-- Persistence and system integration
vim.o.clipboard = 'unnamedplus'
vim.o.undofile = true
vim.o.inccommand = 'split' -- Live :substitute preview

-- Timings
vim.o.updatetime = 100
vim.o.timeoutlen = 300

-- GUI font
vim.o.guifont = 'JetBrainsMonoNL NFM:h10'

 -- Completion options
vim.o.completeopt = "menu,menuone,noinsert,noselect,popup"
vim.o.pumborder = "rounded"
