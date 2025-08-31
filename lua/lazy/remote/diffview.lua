return {
  'sindrets/diffview.nvim',
  config = function()
    vim.api.nvim_set_keymap('n', '<leader>dv', ':DiffviewOpen<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>dc', ':DiffviewClose<CR>', { noremap = true, silent = true })
    require('diffview').setup {
      enhanced_diff_hl = true,
      hooks = {
        diff_buf_win_enter = function(_, _, ctx)
          if ctx.layout_name:match '^diff2' then
            if ctx.symbol == 'a' then
              vim.opt_local.winhl = table.concat({
                'DiffAdd:DiffviewDiffDelete',
                'DiffChange:DiffviewDiffDelete',
                'DiffText:DiffviewDiffTextRed',
              }, ',')
            elseif ctx.symbol == 'b' then
              vim.opt_local.winhl = table.concat({
                'DiffAdd:DiffviewDiffAdd',
                'DiffChange:DiffviewDiffAdd',
                'DiffText:DiffviewDiffTextGreen',
              }, ',')
            end
          end
        end,
      },
    }
  end,
}
