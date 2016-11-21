" reset augroup
augroup MyAutoCmd
autocmd!
augroup END
" dein settings {{{1
"==============================================================================
let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let s:dein_cache_dir = g:cache_home . '/dein'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_host_prog = '/usr/local/bin/python2'

" reset augroup
augroup MyAutoCmd
autocmd!
augroup END

if &runtimepath !~# '/dein.vim'
let s:dein_repo_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

  " Auto Download
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
  endif

  " Load dein.vim
  execute 'set runtimepath^=' . s:dein_repo_dir
  endif

if dein#load_state(s:dein_repo_dir)
  call dein#begin(s:dein_cache_dir)
    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/deoplete.nvim')
    call dein#add('Shougo/denite.nvim')
    call dein#add('altercation/solarized')
    call dein#source('solarized')
    colorscheme solarized
    call dein#add('tpope/vim-fugitive')
    call dein#add('zchee/deoplete-go', {'build': 'make'})
    call dein#add('fatih/vim-go')
  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif

let g:deoplete#enable_at_startup=1
let g:deoplete#auto_complete_start_length=1

" denite.nvim
" Change file_rec command.
call denite#custom#var('file_rec', 'command',
\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
" Change mappings.
call denite#custom#map('insert', '<C-j>', 'move_to_next_line')
call denite#custom#map('insert', '<C-k>', 'move_to_prev_line')
" Change ignore_globs
call denite#custom#filter('matcher_ignore_globs', 'ignore_globs',
      \ [ '.git/', '.ropeproject/', '__pycache__/',
      \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])


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
