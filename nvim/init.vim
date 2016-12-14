" reset augroup
augroup MyAutoCmd
autocmd!
augroup END

source ~/.config/nvim/plugins/dein.vim

" Other settings {{{1
"==============================================================================
set tabstop=4
set shiftwidth=4
set guifont=Ricty:h18
set termguicolors
set clipboard+=unnamedplus
set ambiwidth=double
set ttimeout
set ttimeoutlen=10 "100?
filetype plugin indent on
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
"==========================================================================}}}1
" Key map{{{1
"==============================================================================

nnoremap ; :
nnoremap : ;
" Leader key
  let mapleader=","

  nnoremap <F3> :<C-u>vertical belowright help<Space>
  nnoremap <F2> :<C-u>tab help<Space>

  " Create new tab
  nnoremap <C-w>t :<C-u>tabnew<CR>

  " Reload vimrc
  nnoremap <F5> :<C-u>source $MYVIMRC<CR>

  " Easy change directory
  " > vim-users.jp/Hack #69
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
nnoremap <silent> <Space>b :<C-u>Denite buffer<CR>
nnoremap <silent> <Space>u :<C-u>Denite file_mru<CR>
" vim:foldmethod=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
