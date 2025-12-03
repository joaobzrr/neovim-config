vim.pack.add({
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/esmuellert/vscode-diff.nvim",
})

require("vscode-diff").setup({
    highlights = {
        line_insert = 'DiffAdd',
        line_delete = 'DiffDelete',
        char_brightness = 1.8
    }
})
