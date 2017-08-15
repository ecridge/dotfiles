"------------------------------------------------------------------------------
" airblade/vim-gitgutter: annotate unstaged changes
"------------------------------------------------------------------------------

set signcolumn=yes
set updatetime=250 " ms

" Highlight line changes.
noremap <silent> <Leader>hc :<C-u>GitGutterLineHighlightsToggle<CR>
