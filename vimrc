" Startup {{{1
"==============================================================================
" Reset autocmd
autocmd!

" Define vimrc's encoding
scriptencoding utf-8

"==========================================================================}}}1

" Basic {{{1
"==============================================================================

" Backspace key settings
  " start :Pressing Backspace delete text that was previously inserted.
  " eol   :Pressing Backspace also remove EOL markers(\n or \r\n)
  " indent:Pressing Backspace also remove autoindent
set backspace=start,eol,indent

" Colorscheme
colorscheme desert

" Font setting
set guifont=ricty:h18

" Beep setting
  " Disable all beep
set visualbell t_vb=
set noerrorbells

"==========================================================================}}}1

" Key map{{{1
"==============================================================================
" Leader key
let mapleader=","

" Open vimrc
nnoremap <F2> :<C-u>edit $MYVIMRC<CR>

" Reload vimrc
nnoremap <F3> :<C-u>source $MYVIMRC<CR>

" Create new tab
nnoremap <C-w>t :<C-u>tabnew<CR>
"==========================================================================}}}1

" vim:foldmethod=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
