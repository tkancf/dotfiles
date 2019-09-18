" Basic {{{1
"==============================================================================
" plug install
let s:vim_plug_url='https://github.com/junegunn/vim-plug'

set rtp^="/Users/tkancf/.opam/default/share/ocp-indent/vim"

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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


if has('mac')
  set shell=/usr/local/bin/zsh
else
  set shell=/usr/bin/zsh
endif

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
  " TypeScript jsx
    autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
    autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
  "
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

" highlight off
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR>

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
inoremap <C-l> <C-o>A
"inoremap <C-k> <Nop>

" Search selected strings visualmode
vnoremap * "zy:let @/ = '\V' . substitute(escape(@z, '\/'), '\n', '\\n', 'g')<CR>n

" Edit macro
nnoremap <leader>... :<c-u><c-r><c-r>='let @q = '. string(getreg('q'))<cr><c-f><left>


"==========================================================================}}}1

" Plugin Load {{{
"==============================================================================

call plug#begin($HOME . "/.vim/plugged")
"

" Color
Plug 'vim-scripts/wombat256.vim'
Plug 'itchyny/lightline.vim'

" ctrlp
Plug 'ctrlpvim/ctrlp.vim' | Plug 'mattn/ctrlp-launcher'
Plug 'ctrlpvim/ctrlp.vim' | Plug 'sgur/ctrlp-extensions.vim'
Plug 'ctrlpvim/ctrlp.vim' | Plug 'fisadev/vim-ctrlp-cmdpalette'

" Basics
Plug 'vim-jp/vimdoc-ja'
Plug 'cocopon/vaffle.vim'
Plug 'soramugi/auto-ctags.vim'
Plug 'thinca/vim-quickrun'
Plug 'glidenote/memolist.vim'
Plug 'mattn/vim-fz'
Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-operator-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'kana/vim-submode'
Plug 'lambdalisue/gina.vim'
Plug 'previm/previm'

" Languages
Plug 'fatih/vim-go' , { 'for': 'go' }
Plug 'tpope/vim-markdown', {'for': 'markdown'}
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
Plug 'jszakmeister/markdown2ctags', {'for': 'markdown'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'ElmCast/elm-vim', { 'for': 'elm' }
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'

" Others
Plug 'mattn/sonictemplate-vim'
Plug 'haya14busa/vim-asterisk'
Plug 'easymotion/vim-easymotion'
Plug 'miyakogi/seiya.vim'

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
let g:previm_open_cmd = 'open '
"}}}

" 'ctrlpvim/ctrlp.vim' {{{
nnoremap <C-p> <Nop>
nnoremap <silent> <Leader>b :<C-u>CtrlPBuffer<CR>
nnoremap <silent> <Leader>u :<C-u>CtrlPMRUFiles<CR>
nnoremap <silent> <Leader>p :<C-u>CtrlP<CR>

let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix',  'mixed',
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
nnoremap <Space><Space> :<C-u>CtrlPLauncher<CR>
" }}}

" 'sgur/ctrlp-extensions.vim' {{{
nnoremap <Space>p :<C-u>CtrlPMenu<CR>
" }}}

" 'fisadev/vim-ctrlp-cmdpalette' {{{
nnoremap <Space>c :<C-u>CtrlPCmdPalette<CR>
" }}}

" 'glidenote/memolist.vim' {{{
let g:memolist_memo_suffix = "md"
let g:memolist_template_dir_path = "~/.vim/template/memolist"
let g:memolist_path = $HOME . "/memo"
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

let g:quickrun_config['go.test'] = {'command' : 'go', 'exec' : ['%c test']}
augroup vimrc
  autocmd BufRead,BufNewFile *_test.go set filetype=go.test
augroup END

let g:quickrun_no_default_key_mappings = 1
nnoremap <space>r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
xnoremap <space>r :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>
augroup vimrc
  autocmd FileType qf nnoremap <silent><buffer>q :quit<CR>
augroup END
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

" }}}

" 'soramugi/auto-ctags.vim' {{{
let g:auto_ctags = 0
let g:auto_ctags_directory_list = ['.git', '.svn']
"}}}

" 'cocopon/vaffle.vim'{{{
nnoremap - :<C-u>Vaffle<CR>
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
" <Leader>f{char} to move to {char}
map  <Space>f <Plug>(easymotion-bd-f)
nmap <Space>f <Plug>(easymotion-overwin-f)

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

" 'ElmCast/elm-vim' {{{
let g:elm_setup_keybindings = 0
" }}}

" 'fatih/vim-go' {{{
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
let g:go_def_mode = 'godef'
let g:go_test_show_name=1
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
set updatetime=100
set completeopt=menuone
augroup vimrc
  autocmd FileType go nmap K <Plug>(go-doc-vertical)
  autocmd FileType go nnoremap <buffer> <Leader>r :<C-u>GoRun %<CR>
  autocmd FileType go nnoremap <buffer> <Leader>gr :<C-u>GoRename<CR>
  autocmd FileType go nnoremap <buffer> <Leader>t :<C-u>GoTest<CR>
  autocmd FileType go nnoremap <buffer> <Leader>f :<C-u>GoDecls<CR>
  autocmd FileType go nnoremap <buffer> <Leader>gf :<C-u>GoDeclsDir<CR>
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END
" }}}

"'Shougo/neosnippet' {{{
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
"}}}

"==========================================================================}}}1

" vim:foldmethod=marker
