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
    vim.cmd.colorscheme 'mellifluous'
    vim.api.nvim_set_hl(0, 'Todo', {})
  end,
}
