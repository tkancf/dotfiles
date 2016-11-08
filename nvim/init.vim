" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

"""""""""""""""""""""""""""""""""""""
" dein settings
"""""""""""""""""""""""""""""""""""""
" Install dein
"""""""""""""""""""""""""""""""""""""
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" Load Plugins & Create Cache
"""""""""""""""""""""""""""""""""""""
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
    call dein#add('Shougo/dein.vim')
    call dein#add('ctrlpvim/ctrlp.vim')
  call dein#end()
  call dein#save_state()
endif
" Auto install plugins
"""""""""""""""""""""""""""""""""""""
if !has('vim_starting') && dein#check_install()
  call dein#install()
endif

"""""""""""""""""""""""""""""""""""""
" other settings
"""""""""""""""""""""""""""""""""""""
set guifont=Ricty:h18
colorscheme desert
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set ambiwidth=double
