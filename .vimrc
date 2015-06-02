" Set leaders
noremap <space> <nop>
let mapleader = "\<space>"
let maplocalleader = "\\"

" Load sensible defaults and solarized theme
set nocompatible
execute pathogen#infect()
syntax on
filetype plugin indent on
syntax enable
if has('gui_running')
  "
else
  let g:solarized_termcolors=256
endif
colorscheme solarized
set guifont=Consolas:h14
set hlsearch

" Turn off annoying bell
set visualbell t_vb=

" Useful metrics
set number
set showcmd

" Split options
set equalalways eadirection=hor
set splitbelow splitright

" Prefer vertical split for help
autocmd FileType help wincmd L
autocmd FileType help vertical resize 97

" Use 2 spaces for a tab
set tabstop=2 shiftwidth=2 expandtab

" Bash-style autocompletion
set wildmode=longest,list

" Only insert one space after sentence end on joining
set nojoinspaces

" Wrapping options
set textwidth=78
" set formatoptions=tcroqanlBj
set formatoptions=tcrqnlBj
set colorcolumn=+1

" Swap h and l
noremap h l
noremap l h
noremap <c-w>h <c-w>l
noremap <c-w>l <c-w>h

" Use arrow keys to move between buffers
noremap <left> <c-w>h
noremap <down> <c-w>j
noremap <up> <c-w>k
noremap <right> <c-w>l

" LEARN VIMSCRIPT THE HARD WAY
echom ">^.^<"
inoremap <c-u> <esc>viwUea
inoremap <c-space> <insert>
nnoremap <silent> - :m .+<cr>
nnoremap <silent> _ :m .-2<cr>
noremap Y y$
noremap <leader>ev :<c-u>vsplit $MYVIMRC<cr>G
noremap <silent> <leader>h :<c-u>nohlsearch<cr>
noremap <leader>sv :<c-u>source $MYVIMRC<cr>
nnoremap <leader>u viwU
noremap <leader>. :<c-u>cd %:h<cr>:<c-u>pwd<cr>
noremap <leader><leader> :<c-u>cd<cr>:<c-u>pwd<cr>

" FIXME: Make this toggle between dark and light
noremap <leader>bg :<c-u>set background=dark<cr>

" HACK: Create "an entire" object
onoremap <silent> ae :<c-u>normal! ggVG<cr>
vnoremap <silent> ae <esc>ggVG<cr>

iabbrev thne then
iabbrev j Joe
iabbrev jc Joe Cridge
iabbrev @@ joe.cridge@me.com
iabbrev @@k ***REMOVED***
iabbrev mmobile ***REMOVED***
iabbrev wweb www.joecridge.me
iabbrev ccopy Copyright (C) 2015 Joe Cridge. All rights reserved.
