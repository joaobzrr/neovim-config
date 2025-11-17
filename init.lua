-- OPTIONS

-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Basics
vim.opt.number = true         -- Absolute line numbers
vim.opt.relativenumber = true -- Relative numbers for motion
vim.opt.cursorline = true     -- Highlight current line
vim.opt.signcolumn = 'yes'    -- Prevent text shifting when signs appear
vim.opt.scrolloff = 10        -- Keep 10 lines of padding when scrolling
vim.opt.mouse = 'a'           -- Enable mouse in all modes
vim.opt.showmode = false      -- Mode shown by statusline instead
vim.opt.winborder = 'rounded' -- Rounded floating window borders

-- Indentation
vim.opt.breakindent = true -- Preserve indent on wrapped lines
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.cinoptions = 'l1' -- Small tweak for C indentation rules

-- Search behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true -- Case-sensitive only when uppercase used

-- Whitespace display
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }
vim.opt.fillchars = vim.opt.fillchars + 'diff:╱' -- Character used in diff filler lines

-- Window behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Persistence and system integration
vim.opt.clipboard = 'unnamedplus'
vim.opt.undofile = true
vim.opt.inccommand = 'split' -- Live :substitute preview

-- Timings
vim.opt.updatetime = 100
vim.opt.timeoutlen = 300

-- GUI font
vim.opt.guifont = 'JetBrainsMonoNL NFM:h10'


-- GENERAL KEYMAPS

-- Save and reload config
vim.keymap.set('n', '<leader>o', function()
  local name = vim.api.nvim_buf_get_name(0)
  if name:sub(-4) == ".lua" then
    vim.cmd("update | source %")
  else
    vim.notify("Not a Lua file", vim.log.levels.WARN)
  end
end)

-- Basic editing
vim.keymap.set('n', '<leader>w', ':w<CR>')          -- Save file
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>') -- Clear search highlight

-- Quickfix navigation
vim.api.nvim_set_keymap('n', ']q', ':cnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[q', ':cprev<CR>', { noremap = true, silent = true })

-- Diagnostic navigation (uses float windows)
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = 1, float = true }) end)
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = -1, float = true }) end)

-- Diagnostic utilities
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Leave terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- Window movement
vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')

-- Move selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Scrolling (center cursor after movement)
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Delete without yanking
vim.keymap.set('x', '<leader>p', '"_dP')
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

-- Toggle quickfix window
vim.keymap.set('n', '<leader>qf', function()
  local windows = vim.fn.getwininfo()
  for _, win in pairs(windows) do
    if win.quickfix == 1 then
      vim.cmd.cclose()
      return
    end
  end
  vim.cmd.copen()
end)


-- AUTOCOMMANDS

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- Enable LSP autocompletion when server supports it
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
vim.cmd('set completeopt+=noselect')


-- LSP

vim.lsp.enable({ 'lua_ls' })                          -- Enable LSP servers
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format) -- Format buffer


-- PACKAGES

vim.pack.add({
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-mini/mini.pick',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/ramojus/mellifluous.nvim',
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/rluba/jai.vim'
})

-- Mason
require('mason').setup()

-- Treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'c', 'cpp', 'go', 'lua', 'luadoc', 'bash', 'html', 'markdown', 'vim',
    'vimdoc', 'diff',
  },
  highlight = { enable = true },
})

-- MiniPick
require('mini.pick').setup({
  window = {
    config = function()
      local has_tabline = vim.o.showtabline == 2 or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)
      local has_statusline = vim.o.laststatus > 0

      local max_height = vim.o.lines - vim.o.cmdheight - (has_tabline and 1 or 0) - (has_statusline and 1 or 0)
      local max_width  = vim.o.columns

      local height = math.max(math.floor(0.2 * vim.o.lines), 8)
      return {
        relative = 'editor',
        anchor = 'SW',
        width = max_width,
        height = height,
        row = max_height,
        col = 0,
        border = 'rounded'
      }
    end
  }
})
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')

local function truncate_path(path, max_width)
  max_width = max_width or 40
  if #path <= max_width then
    return path
  end

  local parts = vim.split(path, "/")
  local filename = parts[#parts]
  if #filename + 4 >= max_width then
    -- Worst case: only show the end of the filename
    return "..." .. filename:sub(-(max_width - 3))
  end

  -- Start building from the right
  local tail = filename
  local i = #parts - 1

  -- Add parent directories until we fill up
  while i > 0 do
    local next_tail = parts[i] .. "/" .. tail
    if #next_tail + 4 > max_width then
      break
    end
    tail = next_tail
    i = i - 1
  end

  -- If we used all dirs, just return tail
  if i == 0 then
    return tail
  end

  -- Otherwise show one or two leading dirs + ellipsis
  local head = parts[1]
  if #head + 4 + #tail <= max_width then
    return head .. "/.../" .. tail
  end

  -- If even that doesn’t fit, just ellipsize beginning
  return ".../" .. tail
end

local function live_grep()
  local cwd = vim.fn.getcwd()
  local set_items_opts = { do_match = false, querytick = MiniPick.get_querytick() }
  local spawn_opts = { cwd = cwd }

  local match = function(_, _, query)
    pcall(vim.loop.process_kill, process)
    if MiniPick.get_querytick() == set_items_opts.querytick then return end
    if #query == 0 then return MiniPick.set_picker_items({}, set_items_opts) end

    set_items_opts.querytick = MiniPick.get_querytick()
    local command = {
      'rg',
      '--column',
      '--line-number',
      '--no-heading',
      '--field-match-separator',
      '|',
      '--no-follow',
      '--color=never',
      '--',
      table.concat(query)
    }

    process = MiniPick.set_picker_items_from_cli(command, {
      set_items_opts = set_items_opts,
      spawn_opts = spawn_opts
    })
  end

  local show = function(buf_id, items, query)
    local parsed = {}
    local max_path, max_row, max_col = 0, 0, 0

    for _, item in ipairs(items) do
      local path, row, col, text = string.match(item, '^([^|]*)|([^|]*)|([^|]*)|(.*)$')

      local relpath = truncate_path(vim.fn.fnamemodify(path, ':.'), 40)

      row = tostring(row)
      col = tostring(col)

      text = text:gsub('^%s*(.-)%s*$', '%1')

      max_path = math.max(max_path, #relpath)
      max_row = math.max(max_row, #row)
      max_col = math.max(max_col, #col)

      table.insert(parsed, {
        path = relpath,
        row = row,
        col = col,
        text = text,
      })
    end

    local aligned = {}
    for _, entry in ipairs(parsed) do
      local path = entry.path .. string.rep(' ', max_path - #entry.path)
      local row  = string.rep(' ', max_row - #entry.row) .. entry.row
      local col  = string.rep(' ', max_col - #entry.col) .. entry.col

      table.insert(aligned, string.format('%s │ %s │ %s │ %s', path, row, col, entry.text))
    end

    MiniPick.default_show(buf_id, aligned, query, { show_icons = false })
  end

  local choose = function(item)
    local path, row, column = string.match(item, '^([^|]*)|([^|]*)|([^|]*)|.*$')
    local chosen = {
      path = path,
      lnum = tonumber(row),
      col = tonumber(column),
    }
    MiniPick.default_choose(chosen)
  end

  return MiniPick.start({
    source = {
      name = 'Live Grep',
      items = {},
      match = match,
      show = show,
      choose = choose,
      choose_marked = MiniPick.default_choose_marked
    }
  })
end

vim.keymap.set('n', '<leader>g', live_grep)

local function get_jai_path()
  local jai_path = os.getenv('JAI_PATH')
  if not jai_path then
    vim.notify 'JAI_PATH is not set'
    return '', false
  end
  return jai_path, true
end

vim.keymap.set('n', '<leader>jf', function()
  local jai_path, ok = get_jai_path()
  if not ok then return end
  MiniPick.builtin.files(nil, { source = { name = 'Jai files', cwd = jai_path } })
end)

vim.keymap.set('n', '<leader>jg', function()
  local jai_path, ok = get_jai_path()
  if not ok then return end
  MiniPick.builtin.grep_live(nil, { source = { name = 'Jai grep', cwd = jai_path } })
end)

-- Oil
require('oil').setup()
vim.keymap.set('n', '-', '<CMD>Oil<CR>')
vim.keymap.set('n', '<leader>-', require('oil').toggle_float)

-- Diffview
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


-- COLORS

require('mellifluous').setup({
  mellifluous = {
    bg_contrast = 'hard',
    color_overrides = {
      dark = {
        colors = function(_)
          local color = require 'mellifluous.color'
          local green = color.new_from_hsl { h = 130, s = 30, l = 70 }
          return { strings = green, green = green }
        end,
      },
    },
    highlight_overrides = {
      dark = function(hl, colors)
        hl.set('Keyword', { fg = colors.red })

        hl.set('StatusLine', { bg = nil })
        hl.set('StatusLineNC', { bg = nil })

        hl.set('MiniPickNormal', { bg = colors.bg })
        hl.set('MiniPickBorder', { fg = colors.bg4 })
        hl.set('MiniPickBorderBusy', { fg = colors.bg4 })
      end,
    },
  },
  styles = {
    comments = { italic = false },
  },
})

vim.cmd.colorscheme('mellifluous')

-- Diff colors
vim.api.nvim_set_hl(0, 'DiffviewDiffAdd', { bg = '#1d221d' })       -- Added line
vim.api.nvim_set_hl(0, 'DiffviewDiffTextGreen', { bg = '#173619' }) -- Added text
vim.api.nvim_set_hl(0, 'DiffviewDiffDelete', { bg = '#231b1a' })    -- Deleted line
vim.api.nvim_set_hl(0, 'DiffviewDiffTextRed', { bg = '#390e0e' })   -- Deleted text
vim.api.nvim_set_hl(0, 'DiffDelete', { fg = '#2b2b2b' })            -- Filler color

-- vim: ts=2 sts=2 sw=2 et
