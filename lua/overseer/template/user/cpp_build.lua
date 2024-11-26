return {
  name = 'build',
  builder = function()
    -- Full path to current file (see :help expand())
    return {
      cmd = { 'build.bat' },
      args = {},
      components = {
        {
          'on_output_quickfix',
          open = true,
          errorformat = '%f(%l\\,%c): %t%*[^:]: %m',
        },
        'default',
      },
    }
  end,
}
