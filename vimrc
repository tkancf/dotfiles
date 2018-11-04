" Basic {{{1
"==============================================================================
" encoding
set encoding=utf-8

" file encofing
set fileencodings=utf-8,euc-jp,sjis,cp932,iso-2022-jp

" Clipboard
"set clipboard&
set clipboard^=unnamedplus

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

"==========================================================================}}}1

" GUI{{{1
"==============================================================================
set guifont=Ricty\ Diminished\ 16

set guioptions-=m
set guioptions-=T
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
    autocmd FileType go setlocal noexpandtab
    autocmd FileType go nnoremap <buffer> <Leader>ar :<C-u>GoRun<CR>
    autocmd FileType go nnoremap <buffer> <Leader>r :<C-u>GoRun %<CR>
  " }}}
  " Vue {{{
    autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
  " }}}
augroup END
"==========================================================================}}}1

" Key map{{{1
"==============================================================================
nnoremap <ENTER> <Nop>
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

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>

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

" Search selected strings visualmode
vnoremap * "zy:let @/ = '\V' . substitute(escape(@z, '\/'), '\n', '\\n', 'g')<CR>n

" Show registers
nnoremap ,g :<C-u>registers<CR>

" Edit macro
nnoremap <leader>... :<c-u><c-r><c-r>='let @q = '. string(getreg('q'))<cr><c-f><left>
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

" Plugin Load {{{
"==============================================================================
let s:vim_plug_url='https://github.com/junegunn/vim-plug'

if !filereadable(expand($HOME . '/.vim/vim-plug/plug.vim'))
    call system("git clone " . s:vim_plug_url . " " . $HOME . "/.vim/vim-plug/")
endif
source $HOME/.vim/vim-plug/plug.vim
call plug#begin($HOME . "/.vim/plugged")
"

" Color
Plug 'vim-scripts/wombat256.vim'
Plug 'itchyny/lightline.vim'

" ctrlp
Plug 'ctrlpvim/ctrlp.vim' | Plug 'mattn/ctrlp-launcher'
Plug 'ctrlpvim/ctrlp.vim' | Plug 'sgur/ctrlp-extensions.vim'
Plug 'ctrlpvim/ctrlp.vim' | Plug 'tacahiroy/ctrlp-funky'
Plug 'ctrlpvim/ctrlp.vim' | Plug 'fisadev/vim-ctrlp-cmdpalette'

" Complete
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'

" Basics
Plug 'vim-jp/vimdoc-ja'
Plug 'cocopon/vaffle.vim'
Plug 'soramugi/auto-ctags.vim'
Plug 'thinca/vim-quickrun'
Plug 'glidenote/memolist.vim'
Plug 'mattn/vim-fz'
Plug 'kana/vim-operator-user'
Plug 'rhysd/vim-operator-surround'
Plug 'Townk/vim-autoclose'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" Languages
Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'fatih/vim-go' , { 'for': 'go' }
Plug 'kannokanno/previm', {'for': 'markdown'}
Plug 'tpope/vim-markdown', {'for': 'markdown'}
Plug 'jszakmeister/markdown2ctags', {'for': 'markdown'}

" Others
Plug 'mattn/sonictemplate-vim'
Plug 'tyru/open-browser.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'easymotion/vim-easymotion'
Plug 'miyakogi/seiya.vim'

" Twitter
Plug 'basyura/TweetVim'
Plug 'mattn/webapi-vim'
Plug 'basyura/twibill.vim'
Plug 'basyura/bitly.vim'

Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

call plug#end()

"==========================================================================}}}1

" Plugin config {{{1
"==============================================================================
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

" 'ctrlpvim/ctrlp.vim' {{{
nnoremap <C-p> <Nop>
nnoremap <silent> <Space>b :<C-u>CtrlPBuffer<CR>
nnoremap <silent> <Space>u :<C-u>CtrlPMRUFiles<CR>
nnoremap <silent> <Space>l :<C-u>CtrlPLine<CR>
nnoremap <silent> <Space>i :<C-u>CtrlP<CR>

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

" 'tacahiroy/ctrlp-funky' {{{
nnoremap <Space>f :<C-u>CtrlPFunky<CR>
" }}}

" 'fisadev/vim-ctrlp-cmdpalette' {{{
nnoremap <Space>c :<C-u>CtrlPCmdPalette<CR>
" }}}

" 'fatih/vim-go' {{{
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"
set completeopt=menuone
augroup vimrc
  autocmd FileType go nmap <Leader>K <Plug>(go-doc-vertical)
augroup END
" }}}

" 'glidenote/memolist.vim' {{{
let g:memolist_memo_suffix = "md"
let g:memolist_template_dir_path = "~/.vim/template/memolist"
let g:memolist_path = $HOME . "/memo/content/memo/"
let g:memolist_memo_date = "%Y-%m-%dT%H:%M:%S+09:00"
" }}}

" 'vim-jp/vimdoc-ja' {{{
set helplang=ja,en
" }}}

" 'kannokanno/previm' {{{
"let g:previm_open_cmd = 'open -a Firefox'
augroup vimrc
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setlocal filetype=markdown
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setlocal filetype=markdown
augroup END
" }}}

" 'thinca/vim-quickrun' {{{
if !exists("g:quickrun_config")
    let g:quickrun_config={}
endif

let g:quickrun_config = {
\  "_" : {
\    'runner' : 'vimproc' ,
\    'runner/vimproc/updatetime' : 80,
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

" 'kannokanno/previm'{{{
let g:previm_enable_realtime = 1
" }}}

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
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" }}}

" 'seiya.vim' {{{
let g:seiya_auto_enable=1
" }}}

" 'dag/vim2hs' {{{
let g:haskell_conceal_wide = 1
" }}}

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:deoplete#enable_at_startup = 1

inoremap <expr><CR> pumvisible() ? deoplete#close_popup() : "<CR>"

"==========================================================================}}}1

" vim:foldmethod=marker
