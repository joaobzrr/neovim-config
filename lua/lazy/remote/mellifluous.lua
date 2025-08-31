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

            local fg = colors.fg2.hex
            local fg_red = colors.red:saturated(20).hex
            local fg_green = colors.green:saturated(20).hex
            local fg_yellow = colors.yellow:saturated(20).hex
            local fg_purple = colors.purple:saturated(20).hex
            local fg_blue = colors.blue:saturated(20).hex

            local bg = colors.bg2.hex
            local bg_gray = colors.bg4:lightened(5).hex
            local bg_gray2 = colors.bg3:lightened(2).hex
            local bg_gray3 = colors.bg2.hex
            local bg_red = colors.red:darkened(40):saturated(20).hex
            local bg_green = colors.green:darkened(40):saturated(20).hex
            local bg_purple = colors.purple:darkened(40):saturated(20).hex

            hl.set('DiagnosticError', { fg = fg_red })
            hl.set('DiagnosticWarn', { fg = fg_yellow })
            hl.set('DiagnosticInfo', { fg = fg_purple })
            hl.set('DiagnosticHint', { fg = fg_blue })
            hl.set('DiffDelete', { fg = '#2b2b2b' })

            hl.set('LuaLineA_ModeNormal', { fg = fg, bg = bg_gray, bold = true })
            hl.set('LuaLineB_ModeNormal', { fg = fg, bg = bg_gray2 })
            hl.set('LuaLineC_ModeNormal', { fg = fg, bg = bg_gray3 })
            hl.set('LuaLineA_ModeInsert', { fg = fg, bg = bg_green, bold = true })
            hl.set('LuaLineA_ModeVisual', { fg = fg, bg = bg_purple, bold = true })
            hl.set('LuaLineA_ModeReplace', { fg = fg, bg = bg_red, bold = true })
            hl.set('LuaLineA_Inactive', { fg = fg, bg = bg, bold = true })
            hl.set('LuaLineB_Inactive', { fg = fg, bg = bg })
            hl.set('LuaLineC_Inactive', { fg = fg, bg = bg })
            hl.set('LuaLineDiffAdd', { fg = fg_green })
            hl.set('LuaLineDiffChange', { fg = fg_yellow })
            hl.set('LuaLineDiffDelete', { fg = fg_red })

            hl.set('DiffviewDiffAdd', { bg = '#152112' })
            hl.set('DiffviewDiffTextGreen', { bg = '#2a4125' })
            hl.set('DiffviewDiffDelete', { bg = '#24150f' })
            hl.set('DiffviewDiffTextRed', { bg = '#492c1d' })
            hl.set('DiffDelete', { fg = '#2b2b2b' })
          end,
        },
      },
    }
    vim.cmd.colorscheme 'mellifluous'
  end,
}
