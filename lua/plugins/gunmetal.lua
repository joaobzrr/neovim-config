vim.opt.rtp:prepend(vim.fn.expand('~/dev/nvim/gunmetal'))

require('gunmetal').setup({
    colorset = 'night',
    transparent = false
})
vim.cmd.colorscheme('gunmetal')

vim.api.nvim_create_user_command("PackageReload", function (info)
    for _, pkg in ipairs(info.fargs) do
        -- clear top-level package
        package.loaded[pkg] = nil

        -- clear all submodules too
        for loaded_name, _ in pairs(package.loaded) do
            if loaded_name:match("^" .. pkg) then
                package.loaded[loaded_name] = nil
            end
        end

        require(pkg)
    end
end, {
    nargs = "+",
    complete = function (_, _, _)
        return vim.tbl_keys(package.loaded)
    end,
    desc = "Clear cached lua modules and re-require them",
})

vim.keymap.set("n", "<leader>r", function ()
    vim.cmd("PackageReload gunmetal")
    require("gunmetal").set_colorset("night")
end)
