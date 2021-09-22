" Basic {{{1
"==============================================================================

" Reset augroup
augroup vimrc
  au!
augroup END

set number

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
set listchars=tab:»-,trail:.

" incsearch setting
set hlsearch
set incsearch

" double:Use twice the width of ASCII characters.
set ambiwidth=double

" Command line window height setting
set cmdwinheight=20

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Local vimrc
if filereadable(expand($HOME . '/.vimrc.local'))
  source $HOME/.vimrc.local
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
  autocmd FileType haskell setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType markdown setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufRead,BufNewFile *.vue setfiletype vue
  autocmd FileType elm setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufNewFile,BufRead *.rkt,*.rktl setfiletype scheme
augroup END

"==========================================================================}}}1

" Function {{{
"==============================================================================

" Easy change directory
" > vim-users.jp/Hack #69
" https://vim-jp.org/vim-users-jp/2009/09/08/Hack-69.html
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

"Rename file
" > vim-users.jp/Hack #17
" https://vim-jp.org/vim-users-jp/2009/05/27/Hack-17.html
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

"===========================================================================}}}

" Key map{{{1
"==============================================================================

" s, Space を無効化
nnoremap s <Nop>
nnoremap <Space> <Nop>
nnoremap <Enter> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>

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
nnoremap <Enter><Enter> :<C-u>w<CR>

" Create new tab
nnoremap <C-w>t :<C-u>tabnew<CR>
nnoremap <C-w><C-t> :<C-u>tabnew<CR>

" Swap ; :
noremap ;  :
noremap :  ;

" Q の誤入力 で Ex-mode になるのを防ぐ
nnoremap gQ Q
nnoremap Q <Nop>

" Insert-mode の <C-k> 誤入力で不可視文字が入って泣いたことがあるので、Disable する
inoremap <C-k> <Nop>

" Visual-mode の * をいい感じにする
vnoremap * "zy:let @/ = '\V' . substitute(escape(@z, '\/'), '\n', '\\n', 'g')<CR>n

" q に割り当てた macro を編集する
nnoremap <Space>. :<c-u><c-r><c-r>='let @q = '. string(getreg('q'))<cr><c-f><left>

"==========================================================================}}}1

" Plugin Load {{{
"==============================================================================

" Plug install
" vim-plug がない時に自動でインストール
let s:vim_plug_url='https://github.com/junegunn/vim-plug'
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin($HOME . "/.vim/plugged")

" Color
Plug 'vim-scripts/wombat256.vim'
Plug 'itchyny/lightline.vim'

" Basics
Plug 'vim-jp/vimdoc-ja'
Plug 'scrooloose/nerdtree'
Plug 'glidenote/memolist.vim'
Plug 'rhysd/vim-operator-surround' | Plug 'kana/vim-operator-user'
Plug 'jiangmiao/auto-pairs'
Plug 'kana/vim-submode'
Plug 'lambdalisue/gina.vim'
Plug 'previm/previm' | Plug 'tyru/open-browser.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'easymotion/vim-easymotion'
Plug 'miyakogi/seiya.vim'

" Ctrlp
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/ctrlp-launcher'
Plug 'sgur/ctrlp-extensions.vim'
Plug 'kaneshin/ctrlp-sonictemplate'

" Languages
Plug 'thinca/vim-quickrun'
Plug 'mattn/vim-goimports'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'mattn/sonictemplate-vim'
Plug 'tkancf/vim-sonictemplate-templates'
Plug 'hashivim/vim-terraform'

" LSP
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'vim-denops/denops.vim'
Plug 'Shougo/ddc.vim'
Plug 'Shougo/ddc-around'
Plug 'shun/ddc-vim-lsp'
Plug 'Shougo/ddc-matcher_head'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

"if str2nr(strpart(system("node -v"), 1)) < 10.12
"  Plug 'prabirshrestha/async.vim'
"  Plug 'prabirshrestha/asyncomplete.vim'
"  Plug 'prabirshrestha/asyncomplete-lsp.vim'
"else
"  Plug 'neoclide/coc.nvim', {'branch': 'release'}
"  Plug 'Shougo/neosnippet.vim' | Plug 'Shougo/neosnippet-snippets'
"endif

Plug 'tsuyoshicho/vim-efm-langserver-settings'

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

" プラグインが plug でインストールされているかチェックする
function s:is_plugged(name)
  if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
    return 1
  else
    return 0
  endif
endfunction

" カラースキーム
colorscheme wombat256mod

" 'ctrlpvim/ctrlp.vim' {{{
let g:ctrlp_map = '<Nop>'
nnoremap <silent> <Space>b :<C-u>CtrlPBuffer<CR>
nnoremap <silent> <Space>u :<C-u>CtrlPMRUFiles<CR>

" 'mattn/ctrlp-launcher'
nnoremap <silent> <Space><Space> :<C-u>CtrlPLauncher<CR>

" 'sgur/ctrlp-extensions.vim'
nnoremap <silent> <Space>p :<C-u>CtrlPMenu<CR>

" 'mattn/ctrlp-launcher'
let g:ctrlp_launcher_file = '~/.vim/ctrlp-launcher'

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

"{{{ 'tyru/open-browser.vim'

nmap <Space>o <Plug>(openbrowser-smart-search)
vmap <Space>o <Plug>(openbrowser-smart-search)

"}}}

" 'thinca/vim-quickrun' {{{
if !exists("g:quickrun_config")
  let g:quickrun_config={}
endif

let g:quickrun_config = {
      \  "_" : {
      \    'runner' : 'job',
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
nnoremap <Space>r :cclose<CR>:write<CR>:QuickRun -mode n<CR>
xnoremap <Space>r :<C-U>cclose<CR>:write<CR>gv:QuickRun -mode v<CR>
augroup vimrc
  autocmd FileType qf nnoremap <silent><buffer>q :quit<CR>
augroup END
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

augroup vimrc
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

" 'miyakogi/seiya.vim' {{{
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

"{{{ 'scrooloose/nerdtree'
nnoremap - :<C-u>NERDTreeToggle<CR>
"}}}

" 'prabirshrestha/vim-lsp' {{{

if s:is_plugged("coc.nvim")
  let g:lsp_auto_enable = 0
else
  function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-rename)
    nmap <buffer> <Leader>r <plug>(lsp-references)
    nmap <buffer> <Leader>i <plug>(lsp-implementation)
    nmap <buffer> <Leader>t <plug>(lsp-type-definition)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
    " refer to doc to add more commands
  endfunction

  augroup vimrc
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
  augroup END

  " 'mattn/vim-lsp-settings'
  let g:lsp_diagnostics_enabled = 1
  let g:lsp_diagnostics_echo_cursor = 1
  let g:asyncomplete_auto_popup = 1
  let g:asyncomplete_auto_completeopt = 1
  let g:asyncomplete_popup_delay = 200
  let g:lsp_text_edit_enabled = 1
  "let g:lsp_settings_servers_dir = $HOME/.local/share/vim-lsp-settings/servers
  augroup vimrc
    autocmd BufWritePre <buffer> LspDocumentFormatSync
  augroup END

endif
" }}}

" {{{ 'lambdalisue/gina.vim'

nnoremap <silent> <Up> :<C-u>vertical split \| Gina status<CR>
nnoremap <silent> <Down> :<C-u>Gina commit<CR>
nnoremap <silent> <Right> :<C-u>vertical split \| Gina diff<CR>
nnoremap <silent> <Left> :<C-u>Gina patch<CR>
augroup vimrc
    autocmd FileType gina-status nnoremap <buffer> q :<C-u>close<CR>
    autocmd FileType gina-status nnoremap <buffer> <Up> :<C-u>close<CR>
    autocmd FileType diff nnoremap <buffer> q :<C-u>close<CR>
    autocmd FileType diff nnoremap <buffer> <Right> :<C-u>close<CR>
augroup END

" }}}

"{{{ 'mattn/sonictemplate-vim'

let g:sonictemplate_vim_template_dir = ['~/.vim/plugged/vim-sonictemplate-templates']

"}}}

" {{{ 'neoclide/coc.nvim'

if s:is_plugged("coc.nvim")

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  inoremap <silent><expr> <c-@> coc#refresh()

  if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  nmap <silent> gd <Plug>(coc-definition)
  nmap gr <Plug>(coc-rename)
  nnoremap <silent> K :call <SID>show_documentation()<CR>
  nmap <silent> <Leader>t <Plug>(coc-type-definition)
  nmap <silent> <Leader>r <Plug>(coc-references)
  nmap <silent> <Leader>i <Plug>(coc-implementation)

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocActionAsync('doHover')
    endif
  endfunction

  " カーソルが止まった箇所をハイライト
  autocmd CursorHold * silent call CocActionAsync('highlight')

  augroup vimrc
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  xmap <Enter>s  <Plug>(coc-codeaction-selected)
  nmap <Enter>s <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <Enter>a  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <Enter>f  <Plug>(coc-fix-current)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Use CTRL-S for selections ranges.
  " Requires 'textDocument/selectionRange' support of language server.
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings for CoCList
  " Show all diagnostics.
  nnoremap <silent><nowait> <Enter>d  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent><nowait> <Enter>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent><nowait> <Enter>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent><nowait> <Enter>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent><nowait> <Enter>l  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent><nowait> <Enter>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent><nowait> <Enter>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent><nowait> <Enter>r  :<C-u>CocListResume<CR>

  command! -nargs=0 Prettier :CocCommand prettier.formatFile
  command! -bang CocInstallPlugins call s:InstallCocPlugins()
  function! s:InstallCocPlugins()
    CocInstall coc-docker
    CocInstall coc-yaml
  endfunction
endif

" }}}

" {{{ 'hashivim/vim-terraform'
let g:terraform_fmt_on_save=1
" }}}

let g:goimports = 1
"==========================================================================}}}1

" Customize global settings
" Use around source.
" https://github.com/Shougo/ddc-around
call ddc#custom#patch_global('sources', ['around'])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']},
      \ })

" Change source options
call ddc#custom#patch_global('sourceOptions', {
      \ 'around': {'mark': 'A'},
      \ })
call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
      \ })

" Customize settings on a filetype
"call ddc#custom#patch_filetype(['ruby', 'rb'], 'sources', ['solargraph'])
call ddc#custom#patch_global('sources', ['ddc-vim-lsp'])
call ddc#custom#patch_global('sourceOptions', {
\ '_': { 'matchers': ['matcher_head'] },
\ 'vsnip': {'mark': 'vsnip'},
\ 'ddc-vim-lsp': {
\   'mark': 'lsp',
\   'forceCompletionPattern': '\\.|:|->',
\   'minAutoCompleteLength': 1
\ },
\ })
call ddc#custom#patch_global('sources', [
\ 'vsnip',
\ 'ddc-vim-lsp'
\ ])

call ddc#custom#patch_global('sourceOptions', {
\ '_': { 'matchers': ['matcher_head'] },
\ 'vsnip': {'mark': 'vsnip'},
\ 'ddc-vim-lsp': {
\   'mark': 'lsp',
\   'forceCompletionPattern': '\\.|:|->',
\   'minAutoCompleteLength': 1
\ },
\ })

call ddc#custom#patch_filetype(['typescript', 'go', 'rust', 'ruby'], 'sources', ['ddc-vim-lsp', 'vsnip'])
call ddc#custom#patch_filetype(['vim'], 'sources', ['vsnip'])

" Mappings
"" <TAB>: completion.
"inoremap <silent><expr> <TAB>
"\ pumvisible() ? '<C-n>' :
"\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
"\ '<TAB>' : ddc#manual_complete()
"
"" <S-TAB>: completion back.
"inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'
" Use ddc.
call ddc#enable()

" vim:foldmethod=marker
