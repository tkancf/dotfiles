" Basic {{{1
"==============================================================================
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
set guifont=Ricty\ Diminished\ 13
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
    autocmd FileType go setlocal noexpandtab
  " }}}
  " Vue {{{
    autocmd BufRead,BufNewFile *.vue setlocal filetype=vue
  " }}}
  " Elm {{{
    autocmd FileType elm setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
  " }}}
  " TypeScript jsx
    autocmd BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
  "
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

" Languages
Plug 'fatih/vim-go' , { 'for': 'go' }
Plug 'tpope/vim-markdown', {'for': 'markdown'}
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
Plug 'jszakmeister/markdown2ctags', {'for': 'markdown'}
Plug 'ElmCast/elm-vim', {'for': 'elm'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

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

"==========================================================================}}}1

Plug 'l04m33/vlime', { 'rtp': 'vim' }
Plug 'lambdalisue/gina.vim'
Plug 'posva/vim-vue', { 'for': ['vue'] }

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'natebosch/vim-lsc'

Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-neosnippet.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'ianks/vim-tsx'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'ryanolsonx/vim-lsp-typescript'

call plug#end()
" Plugin config {{{1 "==============================================================================
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
let g:go_def_mode = 'godef'
let g:go_test_show_name=1
set completeopt=menuone
augroup vimrc
  autocmd FileType go nmap K <Plug>(go-doc-vertical)
  autocmd FileType go nnoremap <buffer> <Leader>ar :<C-u>GoRun<CR>
  autocmd FileType go nnoremap <buffer> <Leader>r :<C-u>GoRun %<CR>
  "autocmd FileType go nnoremap <buffer> <Space>r :<C-u>GoRename<CR>
  autocmd FileType go nnoremap <buffer> <Space>t :<C-u>GoTest<CR>
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

" sumbode{{{
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')
" }}}

"==========================================================================}}}1

if executable('go-langserver')
  augroup LspGo
    au!
    au User lsp_setup call lsp#register_server({
        \ 'name': 'go-langserver',
        \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
        \ 'whitelist': ['go'],
        \ })
    au FileType go setlocal omnifunc=lsp#complete
   " au FileType go nnoremap <buffer><silent> <C-]> :<C-u>LspDefinition<CR>
   " au FileType go nnoremap <buffer><silent> gD :<C-u>LspReferences<CR>
   " au FileType go nnoremap <buffer><silent> gs :<C-u>LspDocumentSymbol<CR>
   " au FileType go nnoremap <buffer><silent> gS :<C-u>LspWorkspaceSymbol<CR>
   " au FileType go nnoremap <buffer><silent> gQ :<C-u>LspDocumentFormat<CR>
   " au FileType go vnoremap <buffer><silent> gQ :LspDocumentRangeFormat<CR>
    au FileType go nnoremap <buffer><silent> K :<C-u>LspHover<CR>
   " au FileType go nnoremap <buffer><silent> <Leader>i :<C-u>LspImplementation<CR>
   au FileType go nnoremap <buffer><silent> <Leader>r :<C-u>LspRename<CR>
 augroup END
endif

if executable('bash-language-server')
  augroup LspBash
    au!
    au User lsp_setup call lsp#register_server({
          \ 'name': 'bash-language-server',
          \ 'cmd': {server_info->['bash-language-server', 'start']},
          \ 'whitelist': ['sh'],
          \ })
    " omnifunc
    au FileType sh setlocal omnifunc=lsp#complete
    " map
    au FileType sh nnoremap <buffer><silent> <C-]> :<C-u>LspDefinition<CR>
    au FileType sh nnoremap <buffer><silent> gD :<C-u>LspReferences<CR>
    au FileType sh nnoremap <buffer><silent> gs :<C-u>LspDocumentSymbol<CR>
    au FileType sh nnoremap <buffer><silent> gS :<C-u>LspWorkspaceSymbol<CR>
    au FileType sh nnoremap <buffer><silent> gQ :<C-u>LspDocumentFormat<CR>
    au FileType sh vnoremap <buffer><silent> gQ :LspDocumentRangeFormat<CR>
    au FileType sh nnoremap <buffer><silent> K :<C-u>LspHover<CR>
    au FileType sh nnoremap <buffer><silent> <Leader>i :<C-u>LspImplementation<CR>
    au FileType sh nnoremap <buffer><silent> <Leader>r :<C-u>LspRename<CR>
  augroup END
endif

if executable('typescript-language-server')
  augroup LspTs
    au!

    function! s:lsp_save_format()
      :LspDocumentFormat
      :w
    endfunction
    command! LspSaveFormat :call s:lsp_save_format()

    au User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': {server_info-> ['typescript-language-server', '--stdio']},
        \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
        \ 'whitelist': ['javascript', 'javascript.jsx', 'typescript', 'typescript.tsx'],
        \ })
    " omnifunc
    au FileType typescript.tsx,javascript,javascript.jsx,typescript setlocal omnifunc=lsp#complete
    " map
    au FileType typescript.tsx,javascript,javascript.jsx,typescript nnoremap <buffer><silent> <C-]> :<C-u>LspDefinition<CR>
    au FileType typescript.tsx,javascript,javascript.jsx,typescript nnoremap <buffer><silent> gD :<C-u>LspReferences<CR>
    au FileType typescript.tsx,javascript,javascript.jsx,typescript nnoremap <buffer><silent> gs :<C-u>LspDocumentSymbol<CR>
    au FileType typescript.tsx,javascript,javascript.jsx,typescript nnoremap <buffer><silent> gS :<C-u>LspWorkspaceSymbol<CR>
    " au FileType typescript.tsx nnoremap <ENTER><ENTER> :<C-u>LspDocumentFormat<CR> :<C-u>w<CR>
    au FileType typescript.tsx,javascript,javascript.jsx,typescript noremap <buffer><silent> <ENTER><ENTER> :<C-u>:LspSaveFormat<CR>
    au FileType typescript.tsx,javascript,javascript.jsx,typescript noremap <buffer><silent> gQ :LspDocumentRangeFormat<CR>
    au FileType typescript.tsx,javascript,javascript.jsx,typescript noremap <buffer><silent> K :<C-u>LspHover<CR>
    au FileType typescript.tsx,javascript,javascript.jsx,typescript noremap <buffer><silent> <Leader>i :<C-u>LspImplementation<CR>
    au FileType typescript.tsx,javascript,javascript.jsx,typescript nnoremap <buffer><silent> <Leader>r :<C-u>LspRename<CR>
  augroup END
endif

if executable('vls')
  augroup LspVls
    au!
    au User lsp_setup call lsp#register_server({
        \ 'name': 'vue-language-server',
        \ 'cmd': {server_info->['vls']},
        \ 'whitelist': ['vue'],
        \ })
    " omnifunc
    au FileType vue setlocal omnifunc=lsp#complete
    " map
    au FileType vue nnoremap <buffer><silent> <C-]> :<C-u>LspDefinition<CR>
    au FileType vue nnoremap <buffer><silent> gD :<C-u>LspReferences<CR>
    au FileType vue nnoremap <buffer><silent> gs :<C-u>LspDocumentSymbol<CR>
    au FileType vue nnoremap <buffer><silent> gS :<C-u>LspWorkspaceSymbol<CR>
    au FileType vue nnoremap <buffer><silent> gQ :<C-u>LspDocumentFormat<CR>
    au FileType vue vnoremap <buffer><silent> gQ :LspDocumentRangeFormat<CR>
    au FileType vue nnoremap <buffer><silent> K :<C-u>LspHover<CR>
    au FileType vue nnoremap <buffer><silent> <Leader>i :<C-u>LspImplementation<CR>
    au FileType vue nnoremap <buffer><silent> <Leader>r :<C-u>LspRename<CR>
  augroup END
endif

if executable('cquery')
  augroup LspCquery
    au!
    au User lsp_setup call lsp#register_server({
          \ 'name': 'cquery',
          \ 'cmd': {server_info->['cquery']},
          \ 'initialization_options': { 'cacheDirectory': '/tmp/cquery/cache' },
          \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
          \ })
          "\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
    au FileType c setlocal omnifunc=lsp#complete
    au FileType c nnoremap <buffer><silent> <C-]> :<C-u>LspDefinition<CR>
    au FileType c nnoremap <buffer><silent> gD :<C-u>LspReferences<CR>
    au FileType c nnoremap <buffer><silent> gs :<C-u>LspDocumentSymbol<CR>
    au FileType c nnoremap <buffer><silent> gS :<C-u>LspWorkspaceSymbol<CR>
    au FileType c nnoremap <buffer><silent> gQ :<C-u>LspDocumentFormat<CR>
    au FileType c vnoremap <buffer><silent> gQ :LspDocumentRangeFormat<CR>
    au FileType c nnoremap <buffer><silent> K :<C-u>LspHover<CR>
    au FileType c nnoremap <buffer><silent> <Leader>i :<C-u>LspImplementation<CR>
    au FileType c nnoremap <buffer><silent> <Leader>r :<C-u>LspRename<CR>
    au FileType cpp setlocal omnifunc=lsp#complete
    au FileType cpp nnoremap <buffer><silent> <C-]> :<C-u>LspDefinition<CR>
    au FileType cpp nnoremap <buffer><silent> gD :<C-u>LspReferences<CR>
    au FileType cpp nnoremap <buffer><silent> gs :<C-u>LspDocumentSymbol<CR>
    au FileType cpp nnoremap <buffer><silent> gS :<C-u>LspWorkspaceSymbol<CR>
    au FileType cpp nnoremap <buffer><silent> gQ :<C-u>LspDocumentFormat<CR>
    au FileType cpp vnoremap <buffer><silent> gQ :LspDocumentRangeFormat<CR>
    au FileType cpp nnoremap <buffer><silent> K :<C-u>LspHover<CR>
    au FileType cpp nnoremap <buffer><silent> <Leader>i :<C-u>LspImplementation<CR>
    au FileType cpp nnoremap <buffer><silent> <Leader>r :<C-u>LspRename<CR>
  augroup END
endif

call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
    \ 'name': 'neosnippet',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
    \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))

" let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_auto_popup = 1
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

"" Plugin key-mappings.
"" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" vim:foldmethod=marker
