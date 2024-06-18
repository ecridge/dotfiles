"------------------------------------------------------------------------------
" Shougo/Deoplete.nvim: asynchronous keyword completion
"------------------------------------------------------------------------------

set completeopt-=preview

let g:echodoc#enable_at_startup = 1
let g:deoplete#enable_at_startup = 1

call deoplete#custom#option('smart_case', v:true)

" Use tab for autocompletion.
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<Tab>"
