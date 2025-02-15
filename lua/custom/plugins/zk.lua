return {
  'zk-org/zk-nvim',
  config = function()
    require('zk').setup {
      -- See Setup section below
    }

    vim.api.nvim_set_keymap('v', '<leader>zn', ":<cmd>'<,'><cr>ZkNewFromTitleSelection<cr>", { noremap = true, silent = true })
  end,
}
