" Set leaders.
noremap <space> <nop>
let mapleader = "\<space>"
let maplocalleader = "\\"

" Load Pathogen plugins and Solarized theme; set some sensible defaults.
set nocompatible
execute pathogen#infect()
syntax on
filetype plugin indent on
syntax enable
colorscheme solarized
set showtabline=1
set guifont=Droid\ Sans\ Mono:h14
set hlsearch
set list listchars=tab:>\ ,trail:-,extends:$,precedes:$,nbsp:+

" Add custom task tags.
autocmd Syntax * call matchadd('Todo', '\v<(BUG|HACK)>')
autocmd Syntax * call matchadd('Error', '\v^([<|=>])\1{6}( .*)?$')

" Requirements for Vim-LaTeX.
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" Set background colour dependent on context.
if has('gui_running')
  set background=light
  noremap <leader>bg :<c-u>set background=dark<cr>
else
  set background=dark
  noremap <leader>bg :<c-u>set background=light<cr>
endif

" Turn off annoying bell.
set visualbell t_vb=

" Display useful metrics.
set number
set showcmd

" Split options.
set equalalways eadirection=hor
set splitbelow splitright

" Prefer vertical split for help.
autocmd FileType help wincmd L
autocmd FileType help vertical resize 96

" Default to two spaces for a tab.
set tabstop=2 shiftwidth=2 expandtab

" Bash-style autocompletion.
set wildmode=longest,list

" Only insert one space after period when joining.
set nojoinspaces

" Enable spell checking.
set spell spelllang=en_gb

" Text wrapping options.
set nowrap
set textwidth=79
set colorcolumn=+1
set formatoptions=tcqnlBj " FIXME: Something is doing +=ro.
set sidescroll=1

" Swap h and l.
noremap h l
noremap l h
noremap <c-w>h <c-w>l
noremap <c-w>l <c-w>h

" Use arrow keys to move between buffers.
noremap <left> <c-w>h
noremap <down> <c-w>j
noremap <up> <c-w>k
noremap <right> <c-w>l

" Enable vim-easy-align.
" NB: Shadows `ga` for get-ascii-under-cursor; use `:as[cii]` instead.
" FIXME: The nmap doesn’t appear to work?
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

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

" HACK: Create ‘an entire’ object.
onoremap <silent> ae :<c-u>normal! ggVG<cr>
vnoremap <silent> ae <esc>ggVG<cr>

" Syntastic syntax checking.
"
" FIXME: One of these status line options is wiping out all of the other useful
" information (location, number of selected characters, etc.).
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
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

" File-specific autocommands.
autocmd FileType c setlocal tabstop=8 shiftwidth=8
autocmd FileType changelog setlocal tabstop=8 shiftwidth=8 noexpandtab
autocmd FileType sh,zsh setlocal tabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile .babelrc setlocal filetype=json
autocmd BufRead,BufNewFile .gitconfig,.gitmodules setlocal noexpandtab
autocmd BufRead,BufNewFile .gitconfig,.gitmodules setlocal ts=8 sw=8
