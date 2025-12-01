vim.api.nvim_create_user_command('PackageReload', function(info)
  for _, pkg in ipairs(info.fargs) do
    package.loaded[pkg] = nil
    require(pkg) -- may want to comment this out depending on how you want to use the module
  end
end, {
  nargs = '+',
  complete = function(_, _, _)
    return vim.tbl_keys(package.loaded)
  end,
  desc = 'Clear cached lua modules and re-require them',
})
