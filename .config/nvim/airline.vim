"------------------------------------------------------------------------------
" vim-airline/vim-airline: lightweight status line
"------------------------------------------------------------------------------

set noshowmode

let g:airline_powerline_fonts = 1

let g:airline_detect_spell = 0

let g:airline_mode_map = {
    \ '__' : '   ',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'L',
    \ '' : 'B',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
\ }

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.branch = ''
let g:airline_symbols.notexists = ''
let g:airline_symbols.whitespace = ''

let g:airline_skip_empty_sections = 1

let g:airline_section_x = ''
let g:airline_section_z = '%l:%c (%p%%)'

let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'

let g:airline#extensions#default#section_truncate_width = {
    \ 'b': 79,
    \ 'x': 79,
    \ 'y': 79,
    \ 'warning': 69,
    \ 'error': 59
\ }
