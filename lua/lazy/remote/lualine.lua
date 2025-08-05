return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'ramojus/mellifluous.nvim',
  },
  config = function()
    require('lualine').setup {}
  end,
}
