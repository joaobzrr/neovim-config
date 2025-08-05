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
                strings = green,
                green = green,
              }
            end,
          },
        },
        highlight_overrides = {
          dark = function(hl, colors)
            hl.set('Keyword', { fg = colors.red })
            hl.set('CursorLine', { bg = colors.bg })
            hl.set('NormalFloat', { fg = colors.fg, bg = colors.bg })
            hl.set('FloatBorder', { fg = colors.fg4, bg = colors.bg })

            -- status line
            local sl_fg = colors.fg2.hex
            local sl_fg_red = colors.red:saturated(20).hex
            local sl_fg_green = colors.green:saturated(20).hex
            local sl_fg_yellow = colors.yellow:saturated(20).hex
            local sl_fg_purple = colors.purple:saturated(20).hex
            local sl_fg_blue = colors.blue:saturated(20).hex

            local sl_bg = colors.bg2.hex
            local sl_bg_gray = colors.bg4:lightened(5).hex
            local sl_bg_gray2 = colors.bg3:lightened(2).hex
            local sl_bg_gray3 = colors.bg2.hex
            local sl_bg_red = colors.red:darkened(30):saturated(20).hex
            local sl_bg_green = colors.green:darkened(40):saturated(20).hex
            local sl_bg_purple = colors.purple:darkened(30):saturated(20).hex

            hl.set('LuaLineA_ModeNormal', { fg = sl_fg, bg = sl_bg_gray, bold = true })
            hl.set('LuaLineB_ModeNormal', { fg = sl_fg, bg = sl_bg_gray2 })
            hl.set('LuaLineC_ModeNormal', { fg = sl_fg, bg = sl_bg_gray3 })
            hl.set('LuaLineA_ModeInsert', { fg = sl_fg, bg = sl_bg_green, bold = true })
            hl.set('LuaLineA_ModeVisual', { fg = sl_fg, bg = sl_bg_purple, bold = true })
            hl.set('LuaLineA_ModeReplace', { fg = sl_fg, bg = sl_bg_red, bold = true })
            hl.set('LuaLineA_Inactive', { fg = sl_fg, bg = sl_bg, bold = true })
            hl.set('LuaLineB_Inactive', { fg = sl_fg, bg = sl_bg })
            hl.set('LuaLineC_Inactive', { fg = sl_fg, bg = sl_bg })

            hl.set('DiagnosticError', { fg = sl_fg_red })
            hl.set('DiagnosticWarn', { fg = sl_fg_yellow })
            hl.set('DiagnosticInfo', { fg = sl_fg_purple })
            hl.set('DiagnosticHint', { fg = sl_fg_blue })
            hl.set('LuaLineDiffAdd', { fg = sl_fg_green })
            hl.set('LuaLineDiffChange', { fg = sl_fg_yellow })
            hl.set('LuaLineDiffDelete', { fg = sl_fg_red })
          end,
        },
      },
    }
    vim.cmd.colorscheme 'mellifluous'
  end,
}
