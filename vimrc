" Startup {{{1
"==============================================================================
" Reset autocmd
autocmd!

" Define vimrc's encoding
scriptencoding utf-8

" Set .vim directory
let s:vimdir = $HOME . "/.vim"
if has("vim_starting")
  if ! isdirectory(s:vimdir)
    call system("mkdir " . s:vimdir)
  endif
endif

"==========================================================================}}}1
" Basic {{{1
"==============================================================================
" encoding
set encoding=utf-8

" file encofing
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8

" Backspace key settings
  " start :Pressing Backspace delete text that was previously inserted.
  " eol   :Pressing Backspace also remove EOL markers(\n or \r\n)
  " indent:Pressing Backspace also remove autoindent
set backspace=start,eol,indent

" Colorscheme
colorscheme desert

" Font setting
set guifont=ricty:h18

" Beep setting
  " Disable all beep
set visualbell t_vb=
set noerrorbells

" Golang
" let g:go_bin_path = expand("~/bin")
" set completeopt=menu,preview
" let g:go_highlight_functions = 1
" let g:go_highlight_methods = 1
" let g:go_highlight_structs = 1

" File type settings
" augroup FiletypeSetting
"   autocmd!
"   autocmd BufRead,BufNewFile *.go setfiletype golang
"   autocmd Filetype go setlocal omnifunc=go#complete#Complete
"   autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4
"   autocmd FileType go nmap <Space>gr <Plug>(go-run)
"   autocmd FileType go nmap <Space>gb <Plug>(go-build)
"   autocmd FileType go nmap <Space>gt <Plug>(go-test)
"   autocmd FileType go nmap <Space>gc <Plug>(go-coverage)
"   autocmd FileType go nmap <Space>gd <Plug>(go-doc)
"   autocmd FileType go nmap <Space>gi <Plug>(go-import)
"   autocmd FileType go nmap <Space>gm <Plug>(go-implements)
" augroup END

"==========================================================================}}}1
" Key map{{{1
"==============================================================================
" Leader key
let mapleader=","

" Open vimrc
nnoremap <F2> :<C-u>edit $MYVIMRC<CR>

" Reload vimrc
nnoremap <F3> :<C-u>source $MYVIMRC<CR>

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

" Create new tab
nnoremap <C-w>t :<C-u>tabnew<CR>

" Change ; & :
noremap ;  :
noremap :  ;

"==========================================================================}}}1
"" Load plugins list{{{3
"if dein#load_state(s:dein_dir)
"  call dein#begin(s:dein_dir)
"      call dein#add('Shougo/dein.vim')
"      call dein#add('Shougo/neocomplete.vim', {'if': has('lua'), 'on_i': 1,'lazy': 1})
"      call dein#add('Shougo/neocomplcache.vim', {'if': !has('lua'), 'on_i': 1,'lazy': 1})
"      call dein#add('ctrlpvim/ctrlp.vim')
"      call dein#add('fatih/vim-go')
"      call dein#add('glidenote/memolist.vim')
"      call dein#add('LeafCage/yankround.vim')
"      call dein#add('sgur/ctrlp-extensions.vim', {'depends': ['ctrlp.vim']})
"  call dein#end()
"  call dein#save_state()
"endif
"
""--------------------------------------------------------------------------}}}3
" Plugins setting{{{2
"------------------------------------------------------------------------------
" 'ctrlp/ctrlp.vim' {{{
nnoremap <C-p> <Nop>
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'rtscript', 'mixed',
                         \'line', 'bookmarkdir', 'changes', 'cmdline']
let g:ctrlp_max_files  = 10000
let g:ctrlp_by_filename = 1
let g:ctrlp_max_depth = 10
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_use_caching = 1
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png,*.mp3,*.docx
if executable('ag')
  let g:ctrlp_use_caching = 0
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup -g ""'
endif
" }}}
" 'sgur/ctrlp-extensions.vim' {{{
nnoremap <Space>p :<C-u>CtrlPMenu<CR>
" }}}
" 'glidenote/memolist.vim' {{{
let g:memolist_memo_suffix = "md"
let g:memolist_path = "~/src/github.com/tkancf/memo"
let g:memolist_memo_date = "%Y-%m-%d %H:%M"
nnoremap ,mf :exe "CtrlP" g:memolist_path<cr><f5>
nnoremap ,mn :MemoNew<cr>
nnoremap ,mg :MemoGrep<cr>
" }}}
"--------------------------------------------------------------------------}}}2
"==========================================================================}}}1
" vim:foldmethod=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
