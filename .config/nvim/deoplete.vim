"------------------------------------------------------------------------------
" Shougo/Deoplete.nvim: asynchronous keyword completion
"------------------------------------------------------------------------------

let g:deoplete#enable_at_startup = 1

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = ['tern#Complete', 'jspc#omni']

let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['buffer', 'file', 'ternjs']

let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

" Use tab for autocompletion.
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" Use `gb` to go to definition using Tern.
augroup GotoDefinition
  autocmd!
  autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>
augroup END
