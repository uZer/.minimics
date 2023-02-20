--
-- Vim compatibility 
--

-- Include vim config and set runtimepath to classic vim (for plugins)
vim.cmd([[
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
  source ~/.vimrc
]])
