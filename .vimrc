" This file needs to be moved into the gVim installation under Program Files.
" It also needs to be renamed from `.vimrc` to `_vimrc`.
"
" HACK: I haven’t got around to properly setting up QGMLWY on Windows yet, so
"   this version of my .vimrc contains (somewhat haphazard) remaps for the
"   alphabetical keys on the keyboard.
"
" TODO: Bring this .vimrc up to date with the one I use on Darwin and Linux.
"   The only differences should be the path formats and the aforementioned key
"   remaps.

let mapleader = " "

" Add custom task tags.
autocmd Syntax * call matchadd('Todo', '\v<(BUG|HACK)>')
autocmd Syntax * call matchadd('Error', '\v^([<|=>])\1{6}( .*)?$')

set nocompatible
behave mswin

execute pathogen#infect('c:\\cygwin64\\home\\joe\\.vim\\bundle\\{}')
" sensible.vim - Defaults everyone can agree on
" Maintainer:   Tim Pope <http://tpo.pe/>
" Version:      1.1

if exists('g:loaded_sensible') || &compatible
  finish
else
  let g:loaded_sensible = 1
endif

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set nrformats-=octal

set ttimeout
set ttimeoutlen=10

set incsearch
nnoremap <silent> <leader>h :set nohlsearch<cr>

set laststatus=2
set ruler
set showcmd
set wildmenu

"if !&scrolloff
"  set scrolloff=1
"endif
"if !&sidescrolloff
"  set sidescrolloff=5
"endif
"set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

if &shell =~# 'fish$'
  set shell=/bin/bash
endif

set autoread
set fileformats+=mac

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

inoremap <C-U> <C-G>u<C-U>

" vim:set ft=vim et sw=2:

" My Settings

set number
set hlsearch
set tabstop=2 shiftwidth=2 expandtab
set guifont=Consolas:h11:cANSI
colorscheme solarized
set background=light

noremap! w g
noremap! e m
noremap! r l
noremap! t w
noremap! u f
noremap! i u
noremap! o b
noremap! p -

noremap! W G
noremap! E M
noremap! R L
noremap! T W
noremap! U F
noremap! I U
noremap! O B
noremap! P _

noremap! a d
noremap! d t
noremap! f n
noremap! g r
noremap! h i
noremap! j a
noremap! k e
noremap! l o
noremap! ; h

noremap! A D
noremap! D T
noremap! F N
noremap! G R
noremap! H I
noremap! J A
noremap! K E
noremap! L O
noremap! : H

noremap! b j
noremap! n k
noremap! m p

noremap! B J
noremap! N K
noremap! M P

noremap! [ <backspace>
noremap! ] <esc>

noremap! ' :
inoremap # <esc>:w<cr>i
nnoremap # :w<cr>

nnoremap <leader>kv :vs C:\Program Files (x86)\vim\_vimrc<cr>
nnoremap <leader>sv :source C:\Program Files (x86)\vim\_vimrc<cr>

noremap w g
noremap e m
noremap r h
noremap t w
noremap u f
noremap i u
noremap o b
noremap p -

noremap W G
noremap E M
noremap R L
noremap T W
noremap U F
noremap I U
noremap O B
noremap P _

noremap a d
noremap d t
noremap f n
noremap g r
noremap h i
noremap j a
noremap k e
noremap l o
noremap ; l

noremap A D
noremap D T
noremap F N
noremap G R
noremap H I
noremap J A
noremap K E
noremap L O
noremap : L

noremap b j
noremap n k
noremap m p

noremap B J
noremap N K
noremap M P

noremap [ <backspace>
noremap ] <esc>

noremap ' :

lnoremap w g
lnoremap e m
lnoremap r l
lnoremap t w
lnoremap u f
lnoremap i u
lnoremap o b
lnoremap p -

lnoremap W G
lnoremap E M
lnoremap R L
lnoremap T W
lnoremap U F
lnoremap I U
lnoremap O B
lnoremap P _

lnoremap a d
lnoremap d t
lnoremap f n
lnoremap g r
lnoremap h i
lnoremap j a
lnoremap k e
lnoremap l o
lnoremap ; h

lnoremap A D
lnoremap D T
lnoremap F N
lnoremap G R
lnoremap H I
lnoremap J A
lnoremap K E
lnoremap L O
lnoremap : H

lnoremap b j
lnoremap n k
lnoremap m p

lnoremap B J
lnoremap N K
lnoremap M P

lnoremap [ <backspace>
lnoremap ] <esc>

lnoremap ' :

set visualbell t_vb=
set showcmd

set equalalways eadirection=hor
set splitbelow splitright

autocmd FileType help wincmd L
autocmd FileType help vertical resize 96

set wildmode=longest,list

set nojoinspaces

set textwidth=78
set colorcolumn=+1
set formatoptions=tcqnlBj " FIXME: Something is doing +=ro.
set sidescroll=1

set formatoptions=croqanl1

noremap <left> <c-w>h
noremap <down> <c-w>j
noremap <up> <c-w>k
noremap <right> <c-w>l

" Enable vim-easy-align.
" NB: Shadows `ga` for get-ascii-under-cursor; use `:as[cii]` instead.
" FIXME: The nmap doesn’t appear to work?
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

nnoremap p :m .+<cr>
nnoremap P :m .-2<cr>

noremap Y y$
noremap <silent> <leader>h :<c-u>nohlsearch<cr>

nnoremap <leader>u viwU
noremap <leader>. :<c-u>cd %:h<cr>:<c-u>pwd<cr>

onoremap <silent> ae :<c-u>normal! ggVG<cr>
vnoremap <silent> ae :<esc>ggVG<cr>

" Syntastic syntax checking.
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_html_checkers = ['validator']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_markdown_mdl_args = "--style ~/.mdstyle"
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_sass_checkers = ['sass_lint']
let g:syntastic_scss_checkers = ['sass_lint']
let g:syntastic_sh_checkers = ['bashate']  " FIXME: Not working at all.
let g:syntastic_typescript_checkers = ['tslint']
let g:syntastic_yaml_checkers = ['yamllint']
let g:syntastic_vim_checkers = ['vint']

" Setup vim-airline.
set noshowmode
let g:airline_theme='solarized'
let g:airline_mode_map = {
    \ '__' : '   ',
    \ 'n'  : 'NRM',
    \ 'i'  : 'INS',
    \ 'R'  : 'REP',
    \ 'c'  : 'CMD',
    \ 'v'  : 'VIS',
    \ 'V'  : 'LIN',
    \ '' : 'BLK',
    \ 's'  : 'SEL',
    \ 'S'  : 'SEL',
    \ '' : 'SEL',
    \ }

noremap <silent> <leader>bg :<c-u>set background=dark<cr>

nnoremap QZQ :retab<cr>:%s:\s*//.*$::e<cr>:%s:/\*\_.\{-}\*/::ge<cr>:g/^\s*$/de<cr>:%s/\s\+$//e<cr>:%s/}\s*\n\s*else/} else/e<cr>:%s/\s*\n\s*{/ {/e<cr>:%s/}\s*\(\n\)/}\1\1/e<cr>:%s/(\s\+/(/ge<cr>:%s/\s\+)/)/ge<cr>
"nnoremap g_ /\<[a-jl-z][a-z]\{0,2\}_\w\+\><cr>

set listchars+=trail:-,precedes:$,extends:$
set list

set nowrap
set spell spelllang=en_gb

" File-specific autocommands.
autocmd FileType c setlocal comments=s:/*,m:**,ex:*/
autocmd FileType c setlocal ts=3 sw=3
autocmd FileType diff setlocal nospell nolist ro
autocmd FileType matlab setlocal ts=3 sw=3
autocmd FileType matlab setlocal comments=b:% nospell
autocmd FileType matlab setlocal fo+=o
autocmd FileType changelog setlocal tabstop=8 shiftwidth=8 noexpandtab
autocmd FileType sh,zsh setlocal tabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile .babelrc setlocal filetype=json
autocmd BufRead,BufNewFile .gitconfig,.gitmodules setlocal noexpandtab
autocmd BufRead,BufNewFile .gitconfig,.gitmodules setlocal ts=8 sw=8

" Save swapfiles in a single place on the `C:\` drive. Creating swapfiles on
" networked drives turned out to be somewhat temperamental…
set backupdir=c:\\cygwin64\\home\\joe\\.vim\\backup\\\\
set directory=c:\\cygwin64\\home\\joe\\.vim\\swap\\\\
set undodir=c:\\cygwin64\\home\\joe\\.vim\\undo\\\\
