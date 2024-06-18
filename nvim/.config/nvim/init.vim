set encoding=utf-8
scriptencoding utf-8

"------------------------------------------------------------------------------
" Define leaders
"
" This must stay at the top of `init.vim`!
" Leader commands are defined further down.
"------------------------------------------------------------------------------

" Use space as the leader.
" This will show up in the status line as `<20>`.
noremap <Space> <Nop>
let g:mapleader = "\<Space>"

" Use backspace as the local leader.
" This will show up in the status line as `<80>kb` [sic].
noremap <Backspace> <Nop>
let g:maplocalleader = "\<Backspace>"

" Unmap return for good measure.
nnoremap <Return> <Nop>


"------------------------------------------------------------------------------
" General settings
"------------------------------------------------------------------------------

" Basics.
set formatoptions+=n1
set list listchars=extends:$,nbsp:+,precedes:$,tab:>\ ,trail:-
set matchtime=2 showmatch
set number
set colorcolumn=+1 sidescroll=1 sidescrolloff=1 textwidth=120 nowrap
set mouse=
set shiftround shiftwidth=4 softtabstop=-1 tabstop=4 expandtab
set spell spelllang=en_gb spellfile=~/.config/nvim/spell/en.utf-8.add
set splitbelow splitright
set wildignorecase wildmode=longest,list

" Python.
let g:python_host_prog = 0
let g:python3_host_prog = '~/.envs/neovim/bin/python3'

" Colour scheme.
set background=dark
set cursorline
set termguicolors

" Prefer vertical split for help.
augroup HelpSplit
  autocmd!
  autocmd FileType help wincmd L
  autocmd FileType help vertical resize 82
augroup END


"------------------------------------------------------------------------------
" Insert mode
"------------------------------------------------------------------------------

" Ctrl-A to jump to line start.
" Ctrl-E to jump to line end.
inoremap <C-a> <Esc>I
inoremap <C-e> <Esc>A

" Ctrl-U to upper-case word under cursor.
inoremap <silent> <C-u> _<Esc>mza<C-Right><Esc>bgUiw`zi<Del>


"------------------------------------------------------------------------------
" Normal mode
"------------------------------------------------------------------------------

" Use arrow keys to move between windows.
noremap <Left> <C-w>h
noremap <Down> <C-w>j
noremap <Up> <C-w>k
noremap <Right> <C-w>l

" Use tab and shift-tab to cycle windows.
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

" Ctrl-U to upper-case word under cursor.
nnoremap <C-u> mzgUiw`z


"------------------------------------------------------------------------------
" Leader commands
"------------------------------------------------------------------------------

" Edit and source `init.vim`.
noremap <silent> <Leader>ev :<C-u>tabedit $MYVIMRC<CR>G
noremap <silent> <Leader>sv :<C-u>source $MYVIMRC<CR>

" Hide search matches.
noremap <silent> <Leader>nh :<C-u>nohlsearch<CR>

" Set working directory based on current file.
noremap <Leader>. :<C-u>cd %:h<CR>:<C-u>pwd<CR>


"------------------------------------------------------------------------------
" Miscellaneous
"------------------------------------------------------------------------------

" Create ‘an entire’ text object.
onoremap <silent> ae :<C-u>normal! ggVG<CR>
vnoremap <silent> ae <Esc>ggVG<CR>

" Use enter and backspace to navigate the tag stack.
nnoremap <CR> <C-]>
vnoremap <CR> <C-]>
nnoremap <BS> <C-t>
vnoremap <BS> <C-t>
nnoremap <C-]> <C-W>v<C-]>
vnoremap <C-]> <C-W>v<C-]>


"------------------------------------------------------------------------------
" General autocommands
"------------------------------------------------------------------------------

" Add custom task tags (BUG, HACK, and merge conflict delimiters).
augroup CustomTaskTags
  autocmd!
  autocmd Syntax * call matchadd('Todo', '\v<(BUG|HACK|TL;DR)>')
  autocmd Syntax * call matchadd('Error', '\v^([<|=>])\1{6}( .*)?$')
augroup END


"------------------------------------------------------------------------------
" Language-specific autocommands
"------------------------------------------------------------------------------

augroup LanguageSpecific
  autocmd!
  autocmd BufNewFile,BufRead *.xkb,*/xkb/*/* set filetype=xkb
  autocmd BufNewFile,BufRead .pg_service.conf set filetype=dosini
  autocmd BufNewFile,BufRead .pgpass set filetype=conf
augroup END


"------------------------------------------------------------------------------
" Plugin configuration
"------------------------------------------------------------------------------

source ~/.config/nvim/plug.vim

source ~/.config/nvim/airline.vim
source ~/.config/nvim/cpp-modern.vim
source ~/.config/nvim/deoplete.vim
source ~/.config/nvim/everforest.vim
source ~/.config/nvim/gitgutter.vim
source ~/.config/nvim/indent-guides.vim
source ~/.config/nvim/pgsql.vim


"------------------------------------------------------------------------------
" Local overrides
"------------------------------------------------------------------------------

if filereadable(expand('~/.config/nvim/local.vim'))
  source ~/.config/nvim/local.vim
endif
