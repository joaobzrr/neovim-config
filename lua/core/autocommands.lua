-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Add highlighting for Jai function calls
--vim.api.nvim_create_autocmd("FileType", {
--	pattern = "jai",
--	callback = function()
--		print("HERE WE ARE!")
--
--		-- Define new syntax group for function calls
--		vim.cmd([[
--      syntax match jaiFunctionCall "\v<\h\w*>\ze\(" display
--      highlight default link jaiFunctionCall Function
--    ]])
--	end,
--})
