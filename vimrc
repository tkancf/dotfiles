" Basic {{{1
"==============================================================================
" encoding
set encoding=utf-8

" file encofing
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp

" Backspace key settings
  " start :Pressing Backspace delete text that was previously inserted.
  " eol   :Pressing Backspace also remove EOL markers(\n or \r\n)
  " indent:Pressing Backspace also remove autoindent
set backspace=start,eol,indent

" Colorscheme
colorscheme desert

" Buffer setting
set hidden

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

" GUI{{{1
"==============================================================================
set guifont=Monospace
"==========================================================================}}}1

" Key map{{{1
"==============================================================================
nnoremap , <Nop>
nnoremap <ENTER> <Nop>

" Leader key
let mapleader=","

nnoremap <Space> <Nop>

" j, kで見た目通りに移動
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Reload vimrc
nnoremap <F5> :<C-u>source $MYVIMRC<CR>

" Open help
nnoremap <F3> :<C-u>vertical belowright help<Space>
nnoremap <F2> :<C-u>tab help<Space>

" Save file
nnoremap <ENTER><ENTER> :<C-u>w<CR>

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>

" Create new tab
nnoremap <C-w>t :<C-u>tabnew<CR>
nnoremap <C-w><C-t> :<C-u>tabnew<CR>
nnoremap <ENTER>t :<C-u>tabfind 

" Change ; & :
noremap ;  :
noremap :  ;

" Ex-mode
nnoremap Q gQ
"==========================================================================}}}1

" File type{{{1
"==============================================================================
augroup vimrc-filetype
  autocmd!
  " Go {{{
    autocmd BufRead,BufNewFile *.go setlocal noexpandtab
    autocmd BufRead,BufNewFile *.go nnoremap <Leader>ar :<C-u>GoRun<CR>
    autocmd BufRead,BufNewFile *.go nnoremap <Leader>r :<C-u>GoRun %<CR>
    autocmd BufRead,BufNewFile *.go nnoremap <Leader>d :<C-u>GoDoc<CR>
    autocmd BufRead,BufNewFile *.go nnoremap <Leader>i :<C-u>GoImport 
  " }}}
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

nnoremap <Space>f :<C-u>CtrlPFunky<CR>
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

" 'itmammoth/doorboy.vim' {{{
Plug 'itmammoth/doorboy.vim'
" }}}

" 'glidenote/memolist.vim' {{{
Plug 'glidenote/memolist.vim'

let g:memolist_memo_suffix = "md"
let g:memolist_path = "~/src/github.com/tkancf/memo/"
let g:memolist_memo_date = "%Y-%m-%d %H:%M"

" }}}

" 'justinmk/vim-dirvish' {{{
Plug 'justinmk/vim-dirvish'
" }}}

" 'vim-jp/vimdoc-ja' {{{
Plug 'vim-jp/vimdoc-ja'
set helplang=ja,en
" }}}

" 'tpope/vim-markdown' {{{
Plug 'tpope/vim-markdown'
" }}}

" 'kannokanno/previm' {{{
Plug 'kannokanno/previm'
let g:previm_open_cmd = 'open -a Firefox'
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
" }}}

call plug#end()

"==========================================================================}}}1

" Function {{{
"==============================================================================
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

" Rename file
" > vim-users.jp/Hack #17
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

"===========================================================================}}}

filetype plugin indent on
syntax enable

" vim:foldmethod=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2
