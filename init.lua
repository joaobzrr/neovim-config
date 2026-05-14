vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.keymaps")
require("core.autocommands")

require("plugins.treesitter")
require("plugins.oil")
require("plugins.tokyonight")
require("plugins.picker")
require("plugins.diff")
require("plugins.todo-comments")
require('plugins.jai')
require("plugins.gunmetal")
require("plugins.blink")

vim.lsp.enable({ "lua_ls", "jot_ls" })
