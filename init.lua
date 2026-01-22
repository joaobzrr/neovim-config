-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local function whatever(tbl)
    return tbl
end

whatever({ a = 2 })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup('plugins')

-- Load core config
require('core.options')
require('core.keymaps')
require('core.autocommands')
require('core.commands')
require('core.completion')
require('core.annotations')
