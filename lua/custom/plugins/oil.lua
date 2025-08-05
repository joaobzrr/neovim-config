return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  config = function()
    local function endswith(s, suffix)
      return s:sub(-#suffix) == suffix
    end

    require('oil').setup {
      columns = { 'icon' },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return endswith(name, '_templ.go')
        end,
      },
    }

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    vim.keymap.set('n', '<leader>-', require('oil').toggle_float)
  end,
}
