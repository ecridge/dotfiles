"------------------------------------------------------------------------------
" nathanaelkane/vim-indent-guides: indent markers
"------------------------------------------------------------------------------

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0

augroup ColorIndentGuides
  autocmd!
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg='#313a40' ctermbg=none
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg='#313a40' ctermbg=237
augroup END
