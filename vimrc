" Startup {{{1
"==============================================================================

" Define vimrc's encoding
scriptencoding utf-8

"==========================================================================}}}1

" Basic {{{1
"==============================================================================

" Change cursor shape in different modes on tmux
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

" colorscheme
colorscheme desert

"==========================================================================}}}1
" vim:foldmethod=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
