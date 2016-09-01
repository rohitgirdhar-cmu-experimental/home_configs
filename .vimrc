execute pathogen#infect()

set nu
set cindent
set ai

syntax enable
syntax on
filetype plugin indent on
set t_Co=256
set background=dark
colorscheme solarized
let g:solarized_termcolors=256

set ts=2
set sw=2
set softtabstop=2
set expandtab

set showcmd

set wildmenu

set lazyredraw

set showmatch
set incsearch
set hlsearch

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" powerline
set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
" Always show statusline
set laststatus=2

nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>
set tags=tags; " search up the hierarchy to find the tags file
