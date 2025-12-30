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

"==========================================================================}}}1

" GUI{{{1
"==============================================================================

"if has('mac')
"  set guifont=RictyDiminished-Regular:h18
"else
"  set guifont=Ricty\ Diminished\ 22
"endif
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
let maplocalleader="s"

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

" vim:foldmethod=marker
