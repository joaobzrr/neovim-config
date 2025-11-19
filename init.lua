require('core.options')
require('core.autocommands')
require('core.completion')

require('plugins.lsp')
require('plugins.treesitter')
require('plugins.mini_pick')
require('plugins.oil')
require('plugins.diffview')
require('plugins.mellifluous')
require('plugins.jai')

-- Keymaps (last to ensure all dependencies are loaded)
require('core.keymaps')
