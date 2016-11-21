" reset augroup
augroup MyAutoCmd
autocmd!
augroup END

  " plugin settings {{{1
  "==============================================================================

let g:deoplete#enable_at_startup=1
let g:deoplete#auto_complete_start_length=1

" denite.nvim
" " Change file_rec command.
" call denite#custom#var('file_rec', 'command',
" \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
" " Change mappings.
" call denite#custom#map('insert', '<C-j>', 'move_to_next_line')
" call denite#custom#map('insert', '<C-k>', 'move_to_prev_line')
" " Change ignore_globs
" call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
"       \ [ '.git/', '.ropeproject/', '__pycache__/',
"       \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])


"" vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_term_enabled = 1
let g:go_highlight_build_constraints = 1

" deoplete-go
" deoplete.nvim recommend
set completeopt+=noselect
let g:python3_host_skip_check = 1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/$GOOS_$GOARCH'
inoremap <expr><C-h> deolete#mappings#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"

  "===========================================================================}}}1
" Other settings {{{1
"==============================================================================
set guifont=Ricty:h18
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
colorscheme desert
set termguicolors
set clipboard+=unnamedplus
set ambiwidth=double
set ttimeout
set ttimeoutlen=10 "100?
filetype plugin indent on
"==========================================================================}}}1
" Key map{{{1
"==============================================================================
" Leader key
let mapleader=","

nnoremap <leader>hv :<C-u>vertical belowright help<Space>
nnoremap <leader>ht :<C-u>tab help<Space>

" Create new tab
nnoremap <C-w>t :<C-u>tabnew<CR>

" Reload vimrc
nnoremap <F3> :<C-u>source $MYVIMRC<CR>

noremap ; :
noremap : ;

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

"==========================================================================}}}1
" vim:foldmethod=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
