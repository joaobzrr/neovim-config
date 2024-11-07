return {
  'sindrets/diffview.nvim',
  config = function()
    -- Keymap to open Diffview
    vim.api.nvim_set_keymap('n', '<leader>dv', ':DiffviewOpen<CR>', { noremap = true, silent = true })

    -- Keymap to close Diffview
    vim.api.nvim_set_keymap('n', '<leader>dc', ':DiffviewClose<CR>', { noremap = true, silent = true })

    local function set_diffview_highlights()
      vim.api.nvim_set_hl(0, 'DiffviewDiffAdd', { bg = '#152112' })
      vim.api.nvim_set_hl(0, 'DiffviewDiffTextGreen', { bg = '#2a4125' })

      vim.api.nvim_set_hl(0, 'DiffviewDiffDelete', { bg = '#24150f' })
      vim.api.nvim_set_hl(0, 'DiffviewDiffTextRed', { bg = '#492c1d' })

      vim.api.nvim_set_hl(0, 'DiffDelete', { fg = '#2b2b2b' })
    end

    -- Call this function to set the highlights initially
    set_diffview_highlights()

    -- Reapply the highlights if the colorscheme changes
    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = '*',
      callback = set_diffview_highlights,
    })

    require('diffview').setup {
      hooks = {
        diff_buf_win_enter = function(bufnr, winid, ctx)
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
