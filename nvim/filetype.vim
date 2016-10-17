" filetype setting

" my filetype file
if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    autocmd!		
    autocmd BufNewFile,BufRead *.py setfiletype python
    autocmd BufNewFile,BufRead *.rb setfiletype ruby
    autocmd BufNewFile,BufRead *.go setfiletype go
augroup END
