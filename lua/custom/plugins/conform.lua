local lsp_fallback_ignore_files = {
  c = true,
  cpp = true,

  -- format these with prettierd or don't format at all
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
}

return {
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format {
          async = true,
          lsp_fallback = not lsp_fallback_ignore_files[vim.bo.filetype],
        }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      return {
        timeout_ms = 500,
        lsp_fallback = not lsp_fallback_ignore_files[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescript = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      css = { 'css' },
      scss = { 'scss' },
      html = { 'html' },
      json = { 'json' },
      jsonc = { 'json' },
      yaml = { 'yaml' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- javascript = { { "prettierd", "prettier" } },
    },
    formatters = {
      prettierd = function()
        local util = require 'conform.util'
        return {
          require_cwd = true,
          cwd = util.root_file {
            '.prettierrc',
            '.prettierrc.json',
            '.prettierrc.yml',
            '.prettierrc.yaml',
            '.prettierrc.json5',
            '.prettierrc.js',
            '.prettierrc.cjs',
            '.prettierrc.toml',
            'prettier.config.js',
            'prettier.config.cjs',
          },
        }
      end,
    },
  },
}
