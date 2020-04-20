" inspired by
" https://stefan.sofa-rockers.org/2018/10/23/macos-dark-mode-terminal-vim
function! SetBackgroundMode(...)
  let s:isdarkmode = trim(system("isdarkmode2"))
  if s:isdarkmode ==? "true"
    colorscheme onehalfdark
    let &background = "dark"
  else
    colorscheme onehalflight
    let &background = "light"
  endif
endfunction

" check every half hour
call SetBackgroundMode()
call timer_start(1800000, "SetBackgroundMode", {"repeat": -1})

" enable true colors so Vim colors match Terminal colors
" see https://github.com/sonph/onehalf/tree/master/vim#true-colors
set t_Co=256
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
