"------------------------------------------------------------------------------
" JSDoc-specific autocommands
"------------------------------------------------------------------------------

augroup JSDoc
  autocmd!
  autocmd BufRead,BufNewFile *.jsdoc set filetype=javascript
  autocmd BufRead,BufNewFile .jsdocrc set filetype=json
augroup END
