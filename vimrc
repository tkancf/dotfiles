" Startup {{{1
"==============================================================================
" Reset autocmd
autocmd!

" Define vimrc's encoding
scriptencoding utf-8

" Set .vim directory
let s:vimdir = $HOME . "/.vim"
if has("vim_starting")
  if ! isdirectory(s:vimdir)
    call system("mkdir " . s:vimdir)
  endif
endif

let s:dein_enabled  = 0

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

" Easy cd
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>
"==========================================================================}}}1

" Plugin {{{1
"==============================================================================
" dein install {{{2
"------------------------------------------------------------------------------
if v:version >= 704

let s:dein_enabled = 1

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.vim') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
"--------------------------------------------------------------------------}}}2
" Load plugins{{{2
"------------------------------------------------------------------------------
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
      call dein#add('Shougo/dein.vim')
      call dein#add('ctrlpvim/ctrlp.vim')

  call dein#end()
  call dein#save_state()
endif

"--------------------------------------------------------------------------}}}2
" dein.vim installation check{{{2
"------------------------------------------------------------------------------
  if dein#check_install()
    call dein#install()
  endif
endif 
"--------------------------------------------------------------------------}}}2
" Plugins setting{{{2
"------------------------------------------------------------------------------

"--------------------------------------------------------------------------}}}2
"==========================================================================}}}1
" vim:foldmethod=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
