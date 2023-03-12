""   _ _ _  ,  _ _  ,  _ _ _  ,  _, (
""  / / / /_(_/ / /_(_/ / / /_(_(__/_)_
""
""  An opinionated neovim configuration.
""
"" Complaints:
"" https://github.com/uZer/.minimics

"" Special commands for nvim-qt
noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a

GuiFont FiraCode Nerd Font Mono:h11
GuiWindowOpacity 0.93

" See? That's what opinion is.
" Now that's all you need, you silly GUI user...!
