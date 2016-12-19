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

"==========================================================================}}}1

" Basic {{{1
"==============================================================================
" encoding
set encoding=utf-8

" file encofing
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

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

" Tab setting
  " Expand TAB to Space
set expandtab
  " TAB characters that appear 2-Spaces-wide 
set tabstop=2
  " TAB characters(auto indent) that appear 2-Spaces-wide 
set shiftwidth=2
  " Sets the number of columns for a TAB
set softtabstop=2
  " Auto indent on
set autoindent
set smartindent

" Clipboard setting
set clipboard=unnamed,autoselect

" Complete option setting
set completeopt=menu,preview

set list
set listchars=tab:>-,trail:.


" Local vimrc
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
"==========================================================================}}}1

" Key map{{{1
"==============================================================================
nnoremap , <Nop>
" Leader key
let mapleader=","

nnoremap <Space> <Nop>

" Reload vimrc
nnoremap <F5> :<C-u>source $MYVIMRC<CR>

" Open help
nnoremap <F3> :<C-u>vertical belowright help<Space>
nnoremap <F2> :<C-u>tab help<Space>

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

" Create new tab
nnoremap <C-w>t :<C-u>tabnew<CR>
nnoremap <C-w><C-t> :<C-u>tabnew<CR>

" Change ; & :
noremap ;  :
noremap :  ;

"==========================================================================}}}1

" File type{{{1
"==============================================================================
augroup Vimrc
  autocmd!
  autocmd BufRead,BufNewFile *.go setlocal noexpandtab
  autocmd FileType go nmap <leader>gr <Plug>(go-run)
  autocmd FileType go nmap <leader>gb <Plug>(go-build)
  autocmd FileType go nmap <leader>gt <Plug>(go-test)
  autocmd FileType go nmap <leader>gc <Plug>(go-coverage)
augroup END
"==========================================================================}}}1

" Plugin {{{
"==============================================================================
let s:vim_plug_url='https://github.com/junegunn/vim-plug'
if !filereadable(expand('~/.vim/vim-plug/plug.vim'))
    call system("git clone " . s:vim_plug_url . " " . $HOME . "/.vim/vim-plug/")
endif
source ~/.vim/vim-plug/plug.vim
call plug#begin('~/.vim/plugged')

" 'ctrlpvim/ctrlp.vim' {{{
Plug 'ctrlpvim/ctrlp.vim'

nnoremap <C-p> <Nop>
nnoremap <silent> <Space>b :<C-u>CtrlPBuffer<CR>
nnoremap <silent> <Space>u :<C-u>CtrlPMRUFiles<CR>
nnoremap <silent> <Space>x :<C-u>CtrlPMixed<CR>
nnoremap <silent> <Space>l :<C-u>CtrlPLine<CR>
nnoremap <silent> <Space>i :<C-u>CtrlP<CR>

let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'rtscript', 'mixed',
                         \'line', 'bookmarkdir', 'changes', 'cmdline']
let g:ctrlp_max_files  = 10000
let g:ctrlp_by_filename = 1
let g:ctrlp_max_depth = 20
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_use_caching = 1
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --hidden
    let g:ctrlp_user_command = 'ag %s -i
          \ --ignore "*.gif"
          \ --ignore "*.png"
          \ --ignore "*.PNG"
          \ --ignore "*.jpg"
          \ --ignore "*.JPG"
          \ --ignore "*.ico"
          \ --ignore "*.app"
          \ --ignore "*.zip"
          \ --ignore "*.rar"
          \ --ignore "Applications/*"
          \ --ignore "Library/*"
          \ -g ""'

    let g:ctrlp_use_caching = 0

else
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(txt)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }
endif
" }}}

" 'mattn/ctrlp-launcher' {{{
Plug 'ctrlpvim/ctrlp.vim' |  Plug 'mattn/ctrlp-launcher'

nnoremap <Space><Space> :<C-u>CtrlPLauncher<CR>
" }}}

" 'sgur/ctrlp-extensions.vim' {{{
Plug 'ctrlpvim/ctrlp.vim' | Plug 'sgur/ctrlp-extensions.vim'
nnoremap <Space>p :<C-u>CtrlPMenu<CR>
" }}}

" 'tacahiroy/ctrlp-funky' {{{
Plug 'ctrlpvim/ctrlp.vim' | Plug 'tacahiroy/ctrlp-funky'
" }}}

" 'fatih/vim-go' {{{
Plug 'fatih/vim-go'

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" }}}

Plug 'itmammoth/doorboy.vim'

" 'glidenote/memolist.vim' {{{
Plug 'glidenote/memolist.vim'

let g:memolist_memo_suffix = "md"
let g:memolist_path = "~/Dropbox/Memo"
let g:memolist_memo_date = "%Y-%m-%d %H:%M"

" }}}

" 'justinmk/vim-dirvish' {{{
Plug 'justinmk/vim-dirvish'

" }}}

Plug 'mattn/webapi-vim'

Plug 'tsuyoshiwada/slack-memo-vim'

call plug#end()

"==========================================================================}}}1

" My Plugin {{{

" }}}
filetype plugin indent on
" vim:foldmethod=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2
