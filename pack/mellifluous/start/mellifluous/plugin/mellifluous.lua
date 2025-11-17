vim.pack.add({ 'https://github.com/ramojus/mellifluous.nvim' })

require('mellifluous').setup({
  mellifluous = {
    bg_contrast = 'hard',
    color_overrides = {
      dark = {
        colors = function(_)
          local color = require 'mellifluous.color'
          local green = color.new_from_hsl { h = 130, s = 30, l = 70 }
          return { strings = green, green = green }
        end,
      },
    },
    highlight_overrides = {
      dark = function(hl, colors)
        hl.set('Keyword', { fg = colors.red })

        hl.set('StatusLine', { bg = nil })
        hl.set('StatusLineNC', { bg = nil })

        hl.set('MiniPickNormal', { bg = colors.bg })
        hl.set('MiniPickBorder', { fg = colors.bg4 })
        hl.set('MiniPickBorderBusy', { fg = colors.bg4 })
      end,
    },
  },
  styles = {
    comments = { italic = false },
  },
})

vim.cmd.colorscheme('mellifluous')
