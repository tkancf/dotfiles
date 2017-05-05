scriptencoding utf-8
nnoremap ; :
nnoremap : ;

" dein {{{
" dein basic{{{
let $DEIN_BASE = expand('~/.local/share/vim/dein')
let $DEIN_REPOS_DIR = expand('$DEIN_BASE/repos/github.com/Shougo/dein.vim')
if !isdirectory($DEIN_REPOS_DIR)
  if !executable('git')
    echo 'Please install git.'
    finish
  endif
  let s:base_dir = fnamemodify($DEIN_REPOS_DIR, ':h')
  if !isdirectory(s:base_dir)
    call mkdir(s:base_dir, 'p')
  endif
  call system('git clone https://github.com/Shougo/dein.vim.git ' .
  \   shellescape($DEIN_REPOS_DIR))
  if !isdirectory($DEIN_REPOS_DIR)
    echo 'dein install failed.'
    finish
  endif
endif
set runtimepath^=$DEIN_REPOS_DIR

let g:dein#enable_name_conversion = 1

function! s:update_cmpl(lead, line, pos) abort
  return filter(keys(dein#get()), 'v:val =~# "^" . a:lead')
endfunction
function! s:source_cmpl(lead, line, pos) abort
  return keys(filter(dein#get(), 'v:key =~# "^" . a:lead && !v:val.sourced'))
endfunction
command! -nargs=* -complete=customlist,s:update_cmpl DeinUpdate
\   try
\ |   let s:updatetime = &updatetime
\ |   let &updatetime = 50
\ |   call call('dein#update', [<f-args>])
\ | finally
\ |   let &updatetime = s:updatetime
\ | endtry
command! -nargs=* -complete=customlist,s:update_cmpl DeinReinstall
\   call call('dein#reinstall', [<f-args>])
command! -nargs=+ -complete=customlist,s:source_cmpl DeinSource
\   call call('dein#source', [<f-args>])
command! DeinRecache call dein#recache_runtimepath()

if !dein#load_state($DEIN_BASE)
  finish
endif

call dein#begin($DEIN_BASE, [expand('<sfile>')])

if $DROPBOX_HOME !=# ''
  call dein#local($DROPBOX_HOME . '/work/vim-plugins/labs', {'frozen': 1})
endif

call dein#add('Shougo/dein.vim')
" }}}
    call dein#add('Shougo/deoplete.nvim')
      let g:deoplete#enable_at_startup = 1
    "{{{
    call dein#end()
    call dein#save_state()

    if dein#check_install()
        call dein#install()
    endif
    "}}}
" }}}
filetype plugin indent on

" vim:set foldmethod=marker:
