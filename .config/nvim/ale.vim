"------------------------------------------------------------------------------
" w0rp/ale: asynchronous lint engine
"------------------------------------------------------------------------------

" Manually enable linters.
let g:ale_linters = {
    \ 'css': ['stylelint'],
    \ 'html': ['htmlhint'],
    \ 'markdown': ['mdl'],
    \ 'javascript': ['standard'],
    \ 'json': ['jsonlint'],
    \ 'python': ['pylint', 'flake8'],
    \ 'scss': ['sasslint'],
    \ 'sql': ['sqlint'],
    \ 'typescript': ['tslint'],
    \ 'vim': ['vint'],
    \ 'yaml': ['yamllint'],
\ }

" Always keep the gutter open.
let g:ale_sign_column_always = 1

" Customise gutter indicators.
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'

" Add mappings for jumping between errors.
nmap <silent> [<lt> <Plug>(ale_previous_wrap)
nmap <silent> ]> <Plug>(ale_next_wrap)
