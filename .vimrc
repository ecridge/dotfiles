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
colorscheme solarized
set guifont=Consolas:h14
set hlsearch
set list listchars=tab:>\ ,trail:-,extends:$,precedes:$,nbsp:+

" Vim-LaTeX requirements
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" Set background colour dependent on context
if has('gui_running')
  set background=light
  noremap <leader>bg :<c-u>set background=dark<cr>
else
  set background=dark
  noremap <leader>bg :<c-u>set background=light<cr>
endif

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

" Spell checking
set spell spelllang=en_gb

" Wrapping options
set nowrap
set textwidth=79
set colorcolumn=+1
set formatoptions=tcqnlBj " FIXME: Something is doing +=ro

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
inoremap <c-u> <esc>viwUea
inoremap <c-space> <insert>
nnoremap <silent> - :m .+<cr>
nnoremap <silent> _ :m .-2<cr>
noremap Y y$
noremap <silent> <leader>co :e!<cr>
noremap <leader>ev :<c-u>vsplit $MYVIMRC<cr>G
noremap <silent> <leader>h :<c-u>nohlsearch<cr>
noremap <leader>sv :<c-u>source $MYVIMRC<cr>
nnoremap <leader>u viwU
noremap <leader>. :<c-u>cd %:h<cr>:<c-u>pwd<cr>
noremap <leader><leader> :<c-u>cd<cr>:<c-u>pwd<cr>

" HACK: Create "an entire" object
onoremap <silent> ae :<c-u>normal! ggVG<cr>
vnoremap <silent> ae <esc>ggVG<cr>

" Syntastic syntax checking
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Abbreviations
iabbrev @@ joe.cridge@me.com
iabbrev @@k ***REMOVED***
iabbrev ccopy Copyright (C) 2015 Joe Cridge. All rights reserved.
iabbrev ddef #define  
iabbrev envv #!/usr/bin/env
iabbrev j- Joe
iabbrev jc Joe Cridge
iabbrev mmobile ***REMOVED***
iabbrev thne then
iabbrev wweb www.joecridge.me

" File-specific autocommands
autocmd FileType changelog setlocal ts=8 sw=8 noexpandtab
autocmd FileType c setlocal ts=8 sw=8
