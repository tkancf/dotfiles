" , = <Leader>
let mapleader = ","
noremap \ ,

nmap <Space> <Nop>

"others
nnoremap <Leader>h :<C-u>noh<CR>

" move visual one line
nnoremap j gj
nnoremap k gk

" paste clipbord
nnoremap <Space> "*p
vnoremap <Space> "*p

" cd open file directory
nnoremap <Leader>dg :<C-u>cd<Space>%:h<CR>
nnoremap <Leader>dl :<C-u>lcd<Space>%:h<CR>
