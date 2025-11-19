vim.pack.add({ 'https://github.com/ramojus/mellifluous.nvim' })

require('mellifluous').setup({
    mellifluous = {
        bg_contrast = 'hard',
        styles = {
            comments = { italic = false },
        },
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
                hl.set('NormalFloat', { bg = colors.bg })
                hl.set('FloatBorder', { fg = colors.bg4 })
                hl.set('Pmenu', { fg = colors.fg, bg = colors.bg })
                hl.set('PmenuSel', { bg = colors.bg2 })
                hl.set('PmenuBorder', { fg = colors.bg4 })
                hl.set('StatusLine', { bg = nil })
                hl.set('StatusLineNC', { fg = colors.fg3, bg = nil })

                hl.set('MiniPickNormal', { bg = colors.bg })
                hl.set('MiniPickBorder', { fg = colors.bg4 })
                hl.set('MiniPickBorderBusy', { fg = colors.bg4 })
            end,
        },
    },
})

vim.cmd.colorscheme('mellifluous')

vim.api.nvim_set_hl(0, 'DiffviewDiffAdd', { bg = '#1d221d' })       -- Added line
vim.api.nvim_set_hl(0, 'DiffviewDiffTextGreen', { bg = '#173619' }) -- Added text
vim.api.nvim_set_hl(0, 'DiffviewDiffDelete', { bg = '#231b1a' })    -- Deleted line
vim.api.nvim_set_hl(0, 'DiffviewDiffTextRed', { bg = '#390e0e' })   -- Deleted text
vim.api.nvim_set_hl(0, 'DiffDelete', { fg = '#2b2b2b' })            -- Filler color
