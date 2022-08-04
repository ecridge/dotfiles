"------------------------------------------------------------------------------
" Go-specific autocommands
"------------------------------------------------------------------------------

" Run :GoBuild or :GoTestCompile based on the current Go file.
function! s:go_build_file()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

aug GoSpecific
  au!
  au FileType go setl cc= | setl tw=80
  au FileType go setl sw=4 | setl ts=4 | setl noet
  au FileType go setl listchars=extends:$,nbsp:+,precedes:$,tab:\ \ ,trail:-
  au FileType go setl com=:// | setl fo+=ar
  au FileType go setl aw
  au FileType go map <C-n> :cnext<CR>
  au FileType go map <C-m> :cprevious<CR>
  au FileType go nm <leader>a <Plug>(go-alternate)
  au FileType go nm <leader>b :<C-u>call <SID>go_build_file()<CR>
  au FileType go nm <leader>c <Plug>(go-coverage-toggle)
  au FileType go nn <leader>ne :cclose<CR>
  au FileType go nm <leader>r <Plug>(go-run)
  au FileType go nm <leader>t <Plug>(go-test)
aug END


"------------------------------------------------------------------------------
" Other Go configuration
"------------------------------------------------------------------------------

let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_template_autocreate = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
