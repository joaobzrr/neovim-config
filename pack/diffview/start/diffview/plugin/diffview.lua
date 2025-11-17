vim.pack.add({ 'https://github.com/sindrets/diffview.nvim' })

require('diffview').setup({
  use_icons = false,
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
  }
})

vim.keymap.set('n', '<leader>dv', ':DiffviewOpen<CR>')
vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>')
