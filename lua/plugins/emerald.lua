local plugin_dir = os.getenv('NVIM_PLUGIN_DIR')
local emerald_dir = plugin_dir .. '/emerald'

return {
    dir = emerald_dir,
    priority = 1000,
    config = function()
        require('emerald').setup({ colorset = 'artichoke' })
        vim.cmd.colorscheme('emerald')
    end,
}
