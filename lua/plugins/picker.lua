vim.pack.add({ "https://github.com/ibhagwan/fzf-lua" })

require("fzf-lua").setup({
	winopts = function()
        local height = math.max(math.floor(vim.o.lines * 0.3), 8)

		local has_statusline = vim.o.laststatus > 0
		local used_bottom = vim.o.cmdheight + (has_statusline and 1 or 0)
		local row = (vim.o.lines - used_bottom) / vim.o.lines

		return {
			height = height,
			width = vim.o.columns,
			row = row,
			col = 0,

            backdrop = 100,
			border = "rounded",
		}
	end,

	files = { previewer = "builtin" },
	live_grep = { previewer = "builtin" },
})

vim.keymap.set("n", "<leader>f", function()
	require("fzf-lua").files()
end)

vim.keymap.set("n", "<leader>g", function()
	require("fzf-lua").live_grep()
end)

vim.keymap.set("n", "<leader>cf", function()
    require("fzf-lua").files({ cwd = vim.fn.stdpath('config') })
end)

vim.keymap.set("n", "<leader>cg", function()
    require("fzf-lua").files({ cwd = vim.fn.stdpath('config') })
end)

local function get_jai_path()
    local jai_path = os.getenv('JAI_PATH')
    if not jai_path then
        vim.notify 'JAI_PATH is not set'
    end
    return jai_path
end

vim.keymap.set("n", "<leader>jf", function()
    local jai_path = get_jai_path()
    require("fzf-lua").files({ cwd = jai_path })
end)

vim.keymap.set("n", "<leader>jg", function()
    local jai_path = get_jai_path()
    require("fzf-lua").live_grep({ cwd = jai_path })
end)
