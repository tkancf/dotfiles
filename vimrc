" Basic {{{1
"==============================================================================
" encoding
set encoding=utf-8

" file encofing
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp

" Clipboard
set clipboard&
set clipboard^=unnamedplus

" Backspace key settings
  " start :Pressing Backspace delete text that was previously inserted.
  " eol   :Pressing Backspace also remove EOL markers(\n or \r\n)
  " indent:Pressing Backspace also remove autoindent
set backspace=start,eol,indent

" Buffer setting
set hidden

" Status line
set laststatus=2

" Cursor line
set cursorline

" 256 color
set t_Co=256

" swp output directory
set directory=~/.vim/tmp

" Enable matchit
if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif

" Font setting
set guifont=ricty:h20

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
set guioptions-=m
set guioptions-=T
"==========================================================================}}}1

" Key map{{{1
"==============================================================================
nnoremap <ENTER> <Nop>

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

" 'mattn/sonictemplate-vim' {{{
Plug 'mattn/sonictemplate-vim'
" }}}

" 'sgur/ctrlp-extensions.vim' {{{
Plug 'ctrlpvim/ctrlp.vim' | Plug 'sgur/ctrlp-extensions.vim'
nnoremap <Space>p :<C-u>CtrlPMenu<CR>
" }}}

" 'tacahiroy/ctrlp-funky' {{{
Plug 'ctrlpvim/ctrlp.vim' | Plug 'tacahiroy/ctrlp-funky'

nnoremap <Space>f :<C-u>CtrlPFunky<CR>
" }}}

" 'fisadev/vim-ctrlp-cmdpalette' {{{
Plug 'ctrlpvim/ctrlp.vim' | Plug 'fisadev/vim-ctrlp-cmdpalette'

nnoremap <Space>c :<C-u>CtrlPCmdPalette<CR>
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

" 'kana/vim-smartinput' {{{
Plug 'kana/vim-smartinput'
" }}}

" 'glidenote/memolist.vim' {{{
Plug 'glidenote/memolist.vim'

let g:memolist_memo_suffix = "md"
let g:memolist_path = "~/Dropbox/Memo/"
let g:memolist_memo_date = "%Y-%m-%d %H:%M"

" }}}

" 'vim-jp/vimdoc-ja' {{{
Plug 'vim-jp/vimdoc-ja'
set helplang=ja,en
" }}}

" 'tpope/vim-markdown' {{{
Plug 'tpope/vim-markdown', {'for': 'markdown'}
" }}}

" 'kannokanno/previm' {{{
Plug 'kannokanno/previm'
let g:previm_open_cmd = 'open -a Firefox'
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
" }}}

" 'thinca/vim-quickrun' {{{
Plug 'thinca/vim-quickrun'
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
" }}}

" 'Shougo/neocomplete' {{{
Plug 'Shougo/neocomplete', { 'on': 'InsertEnter' }
"----------------------------------------------------
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" }}}

" {{{ 'Shougo/neosnippet'
Plug 'Shougo/neosnippet', { 'on': 'NeocompleteEnable' } | Plug 'Shougo/neocomplete'
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" My snippets directory
let g:neosnippet#snippets_directory='~/.vim/plugged/neosnippet-snippets/neosnippets/'
let g:neosnippet#snippets_directory='~/.vim/snippets/'
" }}}

" {{{ 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet-snippets' | Plug 'Shougo/neosnippet'
" }}}

" 'tyru/eskk.vim' {{{
Plug 'tyru/eskk.vim'
Plug 'tyru/skkdict.vim'
let g:eskk#enable_completion = 1
let g:eskk#large_dictionary = { 'path': "~/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp' }
"}}}

" 'mck/vim-coffee-script' {{{
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
"}}}

" 'slim-template/vim-slim' {{{
Plug 'slim-template/vim-slim', { 'for': 'slim' }
"}}}

" 'soramugi/auto-ctags.vim' {{{
Plug 'soramugi/auto-ctags.vim'
let g:auto_ctags = 1
let g:auto_ctags_directory_list = ['.git', '.svn']
"}}}

" 'cocopon/vaffle.vim'{{{
Plug 'cocopon/vaffle.vim'
nnoremap - :<C-u>Vaffle<CR>
"}}}

" 'w0rp/ale'{{{
"Plug 'w0rp/ale'
"}}}

" 'itchyny/lightline.vim'{{{
Plug 'itchyny/lightline.vim'
let g:lightline = { 'colorscheme': 'wombat' }

"}}}

Plug 'vim-scripts/wombat256.vim'


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

" In help file
function! KeymapInHelp()
  if &buftype == 'help'
    "echo "readonly modo!"
    nnoremap <buffer> u <C-d>
    nnoremap <buffer> i <C-u>
    nnoremap <buffer> o <C-o>
    nnoremap <buffer> p <C-]>
    nnoremap <buffer> <S-j> <C-e>
    nnoremap <buffer> <S-k> <C-y>
  else
"   echo "This file is not Read only FILE!!!!"
endif
endfunction

augroup KeymapInHelp
  autocmd!
  autocmd BufReadPost,BufEnter * call KeymapInHelp()
augroup END

command! ChangeCharactersD2Ha call s:ChangeCharactersD2H()
function! s:ChangeCharactersD2H()
  %s/　/ /ge
  %s/！/!/ge
  %s/＃/#/ge
  %s/＄/$/ge
  %s/％/%/ge
  %s/＾/^/ge
  %s/＆/&/ge
  %s/＊/*/ge
  %s/（/(/ge
  %s/）/)/ge
  %s/\(^\s*\)ー/\1-/ge
  %s/＿/_/ge
  %s/＋/+/ge
  %s/＝/=/ge
  %s/｛/{/ge
  %s/｝/}/ge
  %s/｜/|/ge
  %s/＼/\\/ge
  %s/〜/~/ge
  %s/｀/`/ge
  %s/：/:/ge
  %s/；/;/ge
  %s/，/,/ge
  %s/．/./ge
  %s/＜/</ge
  %s/＞/>/ge
  %s/’/'/ge
  %s/”/"/ge
  %s/０/0/ge
  %s/１/1/ge
  %s/２/2/ge
  %s/３/3/ge
  %s/４/4/ge
  %s/５/5/ge
  %s/６/6/ge
  %s/７/7/ge
  %s/８/8/ge
  %s/９/9/ge
endfunction

"===========================================================================}}}

syntax enable
filetype plugin indent on
" Colorscheme
colorscheme wombat256mod

" vim:foldmethod=marker
