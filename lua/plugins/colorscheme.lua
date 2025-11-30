vim.pack.add({ "https://github.com/ramojus/mellifluous.nvim" })

local color = require("mellifluous.color")

require("mellifluous").setup({
	mellifluous = {
		bg_contrast = "hard",
		styles = {
			comments = { italic = false },
		},
		color_overrides = {
			dark = {
				colors = function(colors)
                    -- Colorscheme 1
                    --local bg         = "#0f1613"
                    --local fg         = "#d4e2d8"
                    --local keywords   = "#8fdaa0"
                    --local types      = "#c8c7a3"
                    --local strings    = "#9dbc80"
                    --local functions  = "#7fb5b1"
                    --local constants  = "#a3c8c6"
                    --local comments   = "#888888"
                    --local directives = "#b4efd7"
                    --local todo       = "#4a5c36"
                    --local note       = "#234d3d"
                    --local statusline = "#1f2e29"

                    -- Colorscheme 2
                    --local bg         = "#101812"
                    --local fg         = "#d6e3d8"
                    --local keywords   = "#9aefaa"
                    --local types      = "#cfcbaa"
                    --local strings    = "#a1c48b"
                    --local functions  = "#7ab8b3"
                    --local constants  = "#a3d1ce"
                    --local comments   = "#8a8f87"
                    --local directives = "#c0f7df"
                    --local todo       = "#4c6037"
                    --local note       = "#224c3f"
                    --local statusline = "#23352e"

                    -- Colorscheme 3
                    --local bg         = "#0e1411"
                    --local fg         = "#dee8e1"
                    --local keywords   = "#86f0a3"
                    --local types      = "#d2d1b0"
                    --local strings    = "#98c789"
                    --local functions  = "#78bdbc"
                    --local constants  = "#afd6d3"
                    --local comments   = "#8b8d88"
                    --local directives = "#baf7e0"
                    --local todo       = "#46592f"
                    --local note       = "#1f4a41"
                    --local statusline = "#23342c"

                    -- Colorscheme 4
                    --local bg         = "#0e1714"
                    --local fg         = "#d8e7e1"
                    --local keywords   = "#90f0b0"
                    --local types      = "#ccd1b0"
                    --local strings    = "#9ecaa0"
                    --local functions  = "#82c1c0"
                    --local constants  = "#a6d5d3"
                    --local comments   = "#89908d"
                    --local directives = "#befae7"
                    --local todo       = "#455e37"
                    --local note       = "#1f4d44"
                    --local statusline = "#243630"

                    -- Colorscheme 5
                    --local bg         = "#0c1714"
                    --local fg         = "#d7e8e1"
                    --local keywords   = "#6af0a9"
                    --local types      = "#d0c89e"
                    --local strings    = "#8fc783"
                    --local functions  = "#57b9b3"
                    --local constants  = "#7ed4ce"
                    --local comments   = "#7f897f"
                    --local directives = "#9ff7dc"
                    --local todo       = "#3d5c37"
                    --local note       = "#1b4f45"
                    --local statusline = "#1a2f2a"

                    -- Colorscheme 6
                    --local bg         = "#151c17"
                    --local fg         = "#e9f1ea"
                    --local keywords   = "#a6f4b1"
                    --local types      = "#dcd7b8"
                    --local strings    = "#b3d8a2"
                    --local functions  = "#8dc9b8"
                    --local constants  = "#bcded6"
                    --local comments   = "#9aa195"
                    --local directives = "#d5ffe8"
                    --local todo       = "#556c44"
                    --local note       = "#2d5c4a"
                    --local statusline = "#2b3c33"

                    -- Colorscheme 7
                    --local bg         = "#161b12"
                    --local fg         = "#e4eddc"
                    --local keywords   = "#b1f779"
                    --local types      = "#d3cc95"
                    --local strings    = "#c0d484"
                    --local functions  = "#9db78d"
                    --local constants  = "#b7d6a4"
                    --local comments   = "#8c8f79"
                    --local directives = "#d3f7b7"
                    --local todo       = "#5b6331"
                    --local note       = "#2e522f"
                    --local statusline = "#303c29"

                    -- Colorscheme 8
                    --local bg         = "#0d1518"
                    --local fg         = "#d4e8e9"
                    --local keywords   = "#8af7cf"
                    --local types      = "#cfd7c0"
                    --local strings    = "#9fd1b3"
                    --local functions  = "#78c3d8"
                    --local constants  = "#a5dce7"
                    --local comments   = "#7f8d90"
                    --local directives = "#b8f9f1"
                    --local todo       = "#345a51"
                    --local note       = "#1a4953"
                    --local statusline = "#1c3137"

                    -- Colorscheme 9
                    local bg         = "#141c11"
                    local fg         = "#e8f4e1"
                    local keywords   = "#afff82"
                    local types      = "#e0d9ab"
                    local strings    = "#b4e48f"
                    local functions  = "#92d8be"
                    local constants  = "#b9ecd7"
                    local comments   = "#97a08d"
                    local directives = "#ceffd7"
                    local todo       = "#545f38"
                    local note       = "#2b5642"
                    local statusline = "#2b3a2f"

					return {
                        fg             = fg,
                        bg             = bg,
						main_keywords  = keywords,
						other_keywords = keywords,
						types          = types,
						strings        = strings,
						functions      = functions,
						constants      = constants,
						comments       = comments,
						directives     = directives,
						statusline     = statusline,
						todo           = todo,
						note           = note,

						operators      = colors.fg,
					}
				end,
			},
		},
		highlight_overrides = {
			dark = function(hl, colors)
				hl.set("Keyword", { fg = colors.main_keywords })
				hl.set("Comment", { fg = colors.comments, italic = false })
				hl.set("PreProc", { fg = colors.directives })

				hl.set("NormalFloat", { bg = colors.bg })
				hl.set("FloatBorder", { fg = colors.bg4 })

				hl.set("Pmenu", { fg = colors.fg, bg = colors.bg })
				hl.set("PmenuSel", { bg = colors.bg2 })
				hl.set("PmenuBorder", { fg = colors.bg4 })
				hl.set("PmenuMatch", { fg = colors.blue })
				hl.set("PmenuExtra", { fg = colors.green })

				hl.set("StatusLine", { fg = colors.fg1, bg = colors.statusline })
				hl.set("StatusLineNC", { fg = colors.fg3, bg = colors.bg4 })

				hl.set("MiniPickNormal", { bg = colors.bg })
				hl.set("MiniPickBorder", { fg = colors.bg4 })
				hl.set("MiniPickBorderBusy", { fg = colors.bg4 })

				hl.set("DiffAdd", { bg = "#1d221d" })
				hl.set("DiffDelete", { bg = "#231b1a" })

				hl.set("AnnotationTODO", { fg = colors.fg, bg = colors.todo, bold = true })
				hl.set("AnnotationNOTE", { fg = colors.fg, bg = colors.note, bold = true })
			end,
		},
	},
})

vim.cmd.colorscheme("mellifluous")
