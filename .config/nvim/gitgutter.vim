"------------------------------------------------------------------------------
" airblade/vim-gitgutter: annotate unstaged changes
"------------------------------------------------------------------------------

set signcolumn=yes
set updatetime=250 " ms

" Highlight line changes.
" HACK: This also toggles the indent guides, because together they look awful!
noremap <silent> <Leader>hc :<C-u>GitGutterLineHighlightsToggle
      \ <Bar> IndentGuidesToggle<CR>
