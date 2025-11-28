vim.pack.add({ "https://github.com/ramojus/mellifluous.nvim" })

require("mellifluous").setup({
	mellifluous = {
		bg_contrast = "hard",
		styles = {
			comments = { italic = false },
		},
		color_overrides = {
			dark = {
				colors = function(_)
					local color = require("mellifluous.color")
					local green = color.new_from_hsl({ h = 130, s = 30, l = 70 })
					return { strings = green, green = green }
				end,
			},
		},
		highlight_overrides = {
			dark = function(hl, colors)
				hl.set("Keyword", { fg = colors.red })
				hl.set("NormalFloat", { bg = colors.bg })
				hl.set("FloatBorder", { fg = colors.bg4 })
				hl.set("Pmenu", { fg = colors.fg, bg = colors.bg })
				hl.set("PmenuSel", { bg = colors.bg2 })
				hl.set("PmenuBorder", { fg = colors.bg4 })
                hl.set("PmenuMatch", { fg = colors.blue })
				hl.set("PmenuExtra", { fg = colors.green })
				hl.set("StatusLine", { bg = colors.bg3 })
				hl.set("StatusLineNC", { fg = colors.fg3, bg = colors.bg3 })

				hl.set("MiniPickNormal", { bg = colors.bg })
				hl.set("MiniPickBorder", { fg = colors.bg4 })
				hl.set("MiniPickBorderBusy", { fg = colors.bg4 })

                hl.set("DiffviewDiffAdd", { bg = "#1d221d" }) -- Added line
                hl.set("DiffviewDiffTextGreen", { bg = "#173619" }) -- Added text
                hl.set("DiffviewDiffDelete", { bg = "#231b1a" }) -- Deleted line
                hl.set("DiffviewDiffTextRed", { bg = "#390e0e" }) -- Deleted text
                hl.set("DiffDelete", { fg = "#2b2b2b" }) -- Filler color

				hl.set("AnnotationTODO", { fg = "#d86264" })
				hl.set("AnnotationNOTE", { fg = "#bf6ab4" })
			end,
		},
	},
})

vim.cmd.colorscheme("mellifluous")
