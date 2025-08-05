-- Highlight todo, notes, etc in comments
return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false,
      keywords = {
        TODO = { color = 'todo' },
        NOTE = { color = 'note', alt = { 'INFO' } },
      },
      gui_style = {
        fg = 'bold,underline',
        bg = 'none',
      },
      highlight = {
        multiline = false,
        keyword = 'fg',
        after = '',
      },
      colors = {
        todo = { '#d86264' },
        note = { '#bf6ab4' },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
