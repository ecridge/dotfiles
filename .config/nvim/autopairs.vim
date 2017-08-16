set encoding=utf-8
scriptencoding utf-8


"------------------------------------------------------------------------------
" jiangmiao/auto-pairs: automatic bracket/quote pairing
"------------------------------------------------------------------------------

if !exists('g:AutoPairs')
  let g:AutoPairs = {}
endif

" Default pairs
"
" The plugin doesn’t seem to define the default pairs if g:AutoPairs is
" already initialised; and we can’t define additional pairs here without
" first initialising g:AutoPairs.
"
" Workaround: redefine the default pairs...
let g:AutoPairs['`']='`'
let g:AutoPairs['"']='"'
let g:AutoPairs['{']='}'
let g:AutoPairs['''']=''''
let g:AutoPairs['(']=')'
let g:AutoPairs['[']=']'

" Custom pairs
let g:AutoPairs['“']='”'
let g:AutoPairs['‘']='’'
