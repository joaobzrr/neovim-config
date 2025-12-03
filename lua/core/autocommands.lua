-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "jai",
  callback = function()
    vim.cmd([[
      " Function call highlighting
      syntax match jaiFunctionCall "\v(\h\w+\.)*\h\w+\ze\(" display
      highlight default link jaiFunctionCall Function
    ]])
  end,
})
