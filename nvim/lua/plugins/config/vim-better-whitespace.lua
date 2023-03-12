-- remove trailing whitespaces when saving file
vim.g.strip_whitelines_at_eof = 1
vim.cmd("autocmd BufWritePre * :StripWhitespace")
