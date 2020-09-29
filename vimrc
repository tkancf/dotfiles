" Basic {{{1
"==============================================================================
" plug install
let s:vim_plug_url='https://github.com/junegunn/vim-plug'

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" keyword define
set iskeyword+=-

" encoding
set encoding=utf-8

" file encofing
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp

" Clipboard
"set clipboard&
if has('mac')
  set clipboard+=unnamed
else
  set clipboard^=unnamedplus
endif

" Mouse disable
set mouse=

" Backspace key settings
  " start :Pressing Backspace delete text that was previously inserted.
  " eol   :Pressing Backspace also remove EOL markers(\n or \r\n)
  " indent:Pressing Backspace also remove autoindent
set backspace=start,eol,indent

" Allow unsaved buffer hidden
set hidden

" Status line
set laststatus=2

" Cursor line
set cursorline

" 256 color
set t_Co=256

" swp output directory
if !filereadable(expand($HOME . '/.vim/tmp'))
    call system("mkdir" . " " . $HOME . "/.vim/tmp/")
endif
set directory=$HOME/.vim/tmp


" Enable matchit
if !exists('loaded_matchit')
  runtime macros/matchit.vim
endif

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

" Complete option setting
set completeopt=menu,preview
set pumheight=10

set list
set listchars=tab:>-,trail:.

" incsearch setting
set hlsearch
set incsearch

" double:Use twice the width of ASCII characters.
set ambiwidth=double

" Command line window height setting
set cmdwinheight=20

" Local vimrc
if filereadable(expand($HOME . '/.vimrc.local'))
  source $HOME/.vimrc.local
endif

"if has('mac')
"  set shell=/usr/local/bin/zsh
"else
"  set shell=/usr/bin/zsh
"endif


"==========================================================================}}}1

" GUI{{{1
"==============================================================================
if has('mac')
  set guifont=RictyDiminished-Regular:h18
else
  set guifont=Ricty\ Diminished\ 22
endif
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
set guioptions=c
"==========================================================================}}}1

" File type{{{1
"==============================================================================
augroup vimrc
    au!
  " Haskell {{{
    autocmd FileType haskell setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
  " }}}
  " Markdown {{{
    autocmd FileType markdown setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
  " }}}
  " Go {{{
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
  " }}}
  " Vue {{{
    autocmd BufRead,BufNewFile *.vue setlocal filetype=vue
  " }}}
  " Elm {{{
    autocmd FileType elm setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
  " }}}
  " racket {{{
    autocmd BufNewFile,BufRead,BufReadPost *.rkt,*.rktl set filetype=scheme
  " }}}
augroup END

"==========================================================================}}}1

" Function {{{
"==============================================================================
" {{{  Easy change directory
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
" }}}

"{{{ Rename file
" > vim-users.jp/Hack #17
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))
"}}}

"===========================================================================}}}

" Key map{{{1
"==============================================================================
nnoremap s <Nop>
nnoremap <Space> <Nop>

" j, kで見た目通りに移動
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" Reload vimrc
nnoremap <F5> :<C-u>source $MYVIMRC<CR>

" Open vimrc
nnoremap <F4> :<C-u>tabedit $MYVIMRC<CR>

" Open help
nnoremap <F3> :<C-u>vertical belowright help<Space>
nnoremap <F2> :<C-u>tab help<Space>

" Save file
nnoremap <ENTER><ENTER> :<C-u>w<CR>

" Create new tab
nnoremap <C-w>t :<C-u>tabnew<CR>
nnoremap <C-w><C-t> :<C-u>tabnew<CR>

" Change ; & :
noremap ;  :
noremap :  ;

" Ex-mode
nnoremap gQ Q
nnoremap Q <Nop>

" Insertmode
inoremap <C-k> <Nop>

" Search selected strings visualmode
vnoremap * "zy:let @/ = '\V' . substitute(escape(@z, '\/'), '\n', '\\n', 'g')<CR>n

" Edit macro
nnoremap <Space>... :<c-u><c-r><c-r>='let @q = '. string(getreg('q'))<cr><c-f><left>

"==========================================================================}}}1

" Plugin Load {{{
"==============================================================================

call plug#begin($HOME . "/.vim/plugged")
"

" Color
Plug 'vim-scripts/wombat256.vim'
Plug 'itchyny/lightline.vim'

" ctrlp
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/ctrlp-launcher'
Plug 'sgur/ctrlp-extensions.vim'
Plug 'haya14busa/vim-migemo'
Plug 'kaneshin/ctrlp-sonictemplate'

" Basics
"Plug 'vim-jp/vimdoc-ja'
Plug 'scrooloose/nerdtree'
Plug 'glidenote/memolist.vim'

Plug 'rhysd/vim-operator-surround' | Plug 'kana/vim-operator-user'
Plug 'jiangmiao/auto-pairs'
Plug 'kana/vim-submode'
Plug 'lambdalisue/gina.vim'
Plug 'previm/previm' | Plug 'tyru/open-browser.vim'
Plug 'junegunn/vim-easy-align'
Plug 'jeetsukumaran/vim-buffergator'

" Languages
Plug 'thinca/vim-quickrun'
Plug 'mattn/vim-goimports'
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
Plug 'moorereason/vim-markdownfmt'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

" LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Others
Plug 'mattn/sonictemplate-vim'
Plug 'tkancf/vim-sonictemplate-templates'
Plug 'haya14busa/vim-asterisk'
Plug 'easymotion/vim-easymotion'
Plug 'miyakogi/seiya.vim'
Plug 'rizzatti/dash.vim'

" Twitter
Plug 'basyura/TweetVim'
Plug 'mattn/webapi-vim'
Plug 'basyura/twibill.vim'
Plug 'basyura/bitly.vim'

call plug#end()

"==========================================================================}}}1

" Plugin config {{{1 ==============================================================================
syntax enable
filetype plugin indent on
let s:plug = {
      \ "plugs": get(g:, 'plugs', {})
      \ }

function! s:plug.is_installed(name)
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

" {{{ Colorscheme
colorscheme wombat256mod
" }}}

" 'previm/previm' {{{
"let g:previm_open_cmd = 'open '
"}}}

" 'ctrlpvim/ctrlp.vim' {{{
let g:ctrlp_map = '<Nop>'
nnoremap <silent> <Space>b :<C-u>CtrlPBuffer<CR>
nnoremap <silent> <Space>u :<C-u>CtrlPMRUFiles<CR>

" 'mattn/ctrlp-launcher'
nnoremap <silent> <Space><Space> :<C-u>CtrlPLauncher<CR>

" 'sgur/ctrlp-extensions.vim'
nnoremap <silent> <Space>p :<C-u>CtrlPMenu<CR>

let g:ctrlp_extensions = ['quickfix', 'cmdline']
let g:ctrlp_max_files  = 1000
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
else
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(txt)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }
endif
" }}}

" 'glidenote/memolist.vim' {{{
let g:memolist_memo_suffix = "md"
let g:memolist_template_dir_path = "~/.vim/template/"
let g:memolist_path = $HOME . "/Dropbox/memo"
let g:memolist_memo_date = "%Y-%m-%dT%H:%M:%S+09:00"
let g:memolist_ex_cmd = 'CtrlP'

" }}}

" 'vim-jp/vimdoc-ja' {{{
set helplang=ja,en
" }}}

" 'thinca/vim-quickrun' {{{
if !exists("g:quickrun_config")
    let g:quickrun_config={}
endif

let g:quickrun_config = {
\  "_" : {
\    'outputter/buffer/split' : ':botright 8sp',
\    'outputter' : 'error',
\    'outputter/error/success' : 'buffer',
\    'outputter/error/error' : 'quickfix',
\    'outputter/buffer/close_on_empty' : 1,
\  },
\    'haskell' : { 'type' : 'haskell/stack' },
\    'haskell/stack' : {
\    'command' : 'stack',
\    'exec' : '%c %o %s %a',
\    'cmdopt' : 'runghc',
\  },
\}

let g:quickrun_no_default_key_mappings = 1
nnoremap <space>r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
xnoremap <space>r :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>
augroup vimrc
  autocmd FileType qf nnoremap <silent><buffer>q :quit<CR>
augroup END
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

augroup vimrc
  au!
  autocmd BufNewFile,BufRead *.crs setf rust
  autocmd BufNewFile,BufRead *.rs  let g:quickrun_config.rust = {'exec' : 'cargo run'}
  autocmd BufNewFile,BufRead *.crs let g:quickrun_config.rust = {'exec' : 'cargo script %s -- %a'}
augroup END

" }}}

" 'soramugi/auto-ctags.vim' {{{
let g:auto_ctags = 0
let g:auto_ctags_directory_list = ['.git', '.svn']
"}}}

" 'itchyny/lightline.vim'{{{
let g:lightline = { 'colorscheme': 'wombat' }
"}}}

" 'rhysd/vim-operator-surround'{{{
" operator mappings
map <silent>sa <Plug>(operator-surround-append)
map <silent>sd <Plug>(operator-surround-delete)
map <silent>sr <Plug>(operator-surround-replace)
" }}}

" 'haya14busa/vim-asterisk' {{{
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
" }}}

" 'easymotion/vim-easymotion' {{{
map  <Space>i <Plug>(easymotion-bd-f)
nmap <Space>i <Plug>(easymotion-overwin-f)

" Move to line
map <Space>l <Plug>(easymotion-bd-jk)
nmap <Space>l <Plug>(easymotion-overwin-line)

" Move to word
map  <Space>w <Plug>(easymotion-bd-w)
nmap <Space>w <Plug>(easymotion-overwin-w)
" }}}

" 'seiya.vim' {{{
let g:seiya_auto_enable=1
" }}}

" 'kana/vim-submode' {{{
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')
" }}}

" 'junegunn/vim-easy-align'{{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}

"{{{ 'scrooloose/nerdtree'
nnoremap - :<C-u>NERDTreeToggle<CR>
"}}}

" 'prabirshrestha/vim-lsp' {{{

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-rename)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" }}}

" 'mattn/vim-lsp-settings' {{{

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 1
augroup vimrc
  autocmd BufWritePre <buffer> LspDocumentFormatSync
augroup END

" }}}

" {{{ 'lambdalisue/gina.vim'

nnoremap <silent> <Space>gs :<C-u>Gina status<CR>
nnoremap <silent> <Space>gc :<C-u>Gina commit<CR>

" }}}

"{{{ 'sonictemplate-vim'

let g:sonictemplate_vim_template_dir = ['~/.vim/plugged/vim-sonictemplate-templates']
nnoremap <C-e> :<C-u>CtrlPSonictemplate<CR>
inoremap <C-e> <ESC>:<C-u>CtrlPSonictemplate<CR>

"}}}

"==========================================================================}}}1

" vim:foldmethod=marker
