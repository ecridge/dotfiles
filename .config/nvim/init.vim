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
set nojoinspaces
set number
set colorcolumn=+1 sidescroll=1 sidescrolloff=1 textwidth=79 nowrap
set shiftround shiftwidth=2 softtabstop=-1 tabstop=2 expandtab
set spell spelllang=en_gb spellfile=~/.config/nvim/spell/en.utf-8.add
set splitbelow splitright
set wildmode=longest,list

" Syntax highlighting.
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
execute pathogen#infect()
syntax on
filetype plugin indent on

" Colour scheme.
set background=dark
colorscheme gruvbox
"colorscheme solarized
"call togglebg#map('<F5>')

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

" Ctrl-D to delete line under cursor.
inoremap <silent> <C-d> <Esc>ddi

" Ctrl-G to move line under cursor up.
" Ctrl-- to move line under cursor down.
inoremap <silent> <C-g> <Esc>:m .-2<CR>==gi
inoremap <silent> <C-_> <Esc>:m .+1<CR>==gi

" Ctrl-U to upper-case word under cursor.
inoremap <silent> <C-u> _<Esc>mza<C-Right><Esc>bgUiw`zi<Del>


"------------------------------------------------------------------------------
" Normal mode
"------------------------------------------------------------------------------

" Swap H and L.
noremap h l
noremap l h
noremap <C-w>h <C-w>l
noremap <C-w>l <C-w>h

" Use arrow keys to move between windows.
noremap <Left> <C-w>h
noremap <Down> <C-w>j
noremap <Up> <C-w>k
noremap <Right> <C-w>l

" Use tab and shift-tab to cycle windows.
nnoremap <Tab> <C-w>w
nnoremap <S-Tab> <C-w>W

" \ to delete line under cursor.
nnoremap <silent> \ dd

" Ctrl-U to upper-case word under cursor.
nnoremap <C-u> mzgUiw`z


"------------------------------------------------------------------------------
" Leader commands
"------------------------------------------------------------------------------

" ‘Check out’ a file.
noremap <silent> <Leader>co :<C-u>e!<CR>

" Edit and source `init.vim`.
noremap <silent> <Leader>ev :<C-u>tabedit $MYVIMRC<CR>G
noremap <silent> <Leader>sv :<C-u>source $MYVIMRC<CR>

" Hide search matches.
noremap <silent> <Leader>nh :<C-u>nohlsearch<CR>

" Toggle background.
map <silent> <Leader>bg <F5>

" Set working directory based on current file.
noremap <Leader>. :<C-u>cd %:h<CR>:<C-u>pwd<CR>

" Save and quit.
noremap <Leader>q :<C-u>wq<CR>


"------------------------------------------------------------------------------
" Miscellaneous
"------------------------------------------------------------------------------

" Create ‘an entire’ text object.
onoremap <silent> ae :<C-u>normal! ggVG<CR>
vnoremap <silent> ae <Esc>ggVG<CR>


"------------------------------------------------------------------------------
" Autocommands
"------------------------------------------------------------------------------

" Disable comment continuation (when opening lines).
augroup CommentContinuation
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" Add custom task tags (BUG, HACK, and merge conflict delimiters).
augroup CustomTaskTags
  autocmd!
  autocmd Syntax * call matchadd('Todo', '\v<(BUG|HACK)>')
  autocmd Syntax * call matchadd('Error', '\v^([<|=>])\1{6}( .*)?$')
augroup END


"------------------------------------------------------------------------------
" Plugin configuration
"------------------------------------------------------------------------------

source ~/.config/nvim/gitgutter.vim
source ~/.config/nvim/indent-guides.vim
source ~/.config/nvim/deoplete.vim
source ~/.config/nvim/airline.vim
source ~/.config/nvim/ale.vim
source ~/.config/nvim/autopairs.vim
