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
set wildignorecase wildmode=longest,list

" Python.
let g:python_host_prog = '/Users/joe/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/joe/.pyenv/versions/neovim3/bin/python'

" Syntax highlighting.
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
execute pathogen#infect()
syntax on
filetype plugin indent on

" Colour scheme.
set background=dark
let g:gruvbox_italic = 1
colorscheme gruvbox

" Prefer vertical split for help.
augroup HelpSplit
  autocmd!
  autocmd FileType help wincmd L
  autocmd FileType help vertical resize 82
augroup END

" Don't show boring files in netrw.
let g:netrw_hide = 1
let g:netrw_list_hide= netrw_gitignore#Hide().'.*\.pyc$'


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

" Edit snippets.
noremap <Leader>u :<C-u>UltiSnipsEdit<CR>


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

" Disable comment continuation (when opening lines).
augroup CommentContinuation
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

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
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
  autocmd BufNewFile,BufRead *.xkb,*/xkb/*/* set filetype=xkb
  autocmd BufNewFile,BufRead .pg_service.conf set filetype=dosini
  autocmd BufNewFile,BufRead .pgpass set filetype=conf
  autocmd FileType html,htmldjango,jst setlocal formatoptions-=t textwidth=100
  autocmd FileType kotlin set commentstring=//%s formatoptions+=r
  autocmd FileType kotlin set shiftwidth=4 tabstop=4 textwidth=120
  autocmd FileType python set joinspaces
  autocmd FileType python normal zR
  autocmd FileType sh,sshconfig,sql set shiftwidth=4 tabstop=4
  autocmd FileType xkb set shiftwidth=4 tabstop=4
  autocmd FileType xml set shiftwidth=4 tabstop=4 formatoptions-=t
augroup END

source ~/.config/nvim/go.vim
source ~/.config/nvim/jsdoc.vim


"------------------------------------------------------------------------------
" Plugin configuration
"------------------------------------------------------------------------------

source ~/.config/nvim/airline.vim
source ~/.config/nvim/ale.vim
source ~/.config/nvim/autopairs.vim
source ~/.config/nvim/deoplete.vim
source ~/.config/nvim/editorconfig.vim
source ~/.config/nvim/gitgutter.vim
source ~/.config/nvim/indent-guides.vim
source ~/.config/nvim/pgsql.vim
source ~/.config/nvim/python.vim
source ~/.config/nvim/ultisnips.vim

if filereadable(expand('~/.config/nvim/local.vim'))
  source ~/.config/nvim/local.vim
endif
