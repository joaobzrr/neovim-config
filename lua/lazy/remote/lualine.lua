local function extract_hl(name)
  local hl = vim.api.nvim_get_hl(0, { name = name })
  return {
    fg = hl.fg and string.format('#%06x', hl.fg) or nil,
    bg = hl.bg and string.format('#%06x', hl.bg) or nil,
    gui = hl.bold and 'bold' or nil,
  }
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = function()
    return {
      options = {
        theme = {
          normal = {
            a = extract_hl 'LuaLineA_ModeNormal',
            b = extract_hl 'LuaLineB_ModeNormal',
            c = extract_hl 'LuaLineC_ModeNormal',
          },
          insert = {
            a = extract_hl 'LuaLineA_ModeInsert',
          },
          visual = {
            a = extract_hl 'LuaLineA_ModeVisual',
          },
          replace = {
            a = extract_hl 'LuaLineA_ModeReplace',
          },
          inactive = {
            a = extract_hl 'LuaLineA_Inactive',
            b = extract_hl 'LuaLineB_Inactive',
            c = extract_hl 'LuaLineC_Inactive',
          },
        },
      },
      sections = {
        lualine_x = { 'filetype' },
      },
    }
  end,
}
