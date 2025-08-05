return {
  'ramojus/mellifluous.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    require('mellifluous').setup {
      mellifluous = {
        bg_contrast = 'hard',
      },
      styles = {
        comments = { italic = false },
      },
    }
  end,
  init = function()
    require('mellifluous').setup {
      mellifluous = {
        color_overrides = {
          dark = {
            colors = function(colors)
              local color = require 'mellifluous.color'
              local green = color.new_from_hsl { h = 130, s = 30, l = 70 }

              return {
                other_keywords = colors.main_keywords,
                strings = green,
                green = green,
              }
            end,
          },
        },
        highlight_overrides = {
          dark = function(hl, colors)
            hl.set('CursorLine', { bg = colors.bg })
            hl.set('NormalFloat', { fg = colors.fg4, bg = colors.bg })
            hl.set('FloatBorder', { fg = colors.fg4, bg = colors.bg })
          end,
        },
      },
    }
    vim.cmd.colorscheme 'mellifluous'
  end,
}
