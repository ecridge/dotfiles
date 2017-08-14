"------------------------------------------------------------------------------
" Shougo/Deoplete.nvim: asynchronous keyword completion
"------------------------------------------------------------------------------

let g:deoplete#enable_at_startup = 1

" Use tab for autocompletion.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Use `gb` to go to definition using Tern.
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
