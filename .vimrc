" @author nate zhou
" @since 2023,2024

"set viminfofile=~/.config/vim/viminfo

let mapleader=" "   " set space as leader key

syntax on
set encoding=utf-8
set title           " terminal title
set background=dark
set clipboard=unnamedplus

set nohlsearch
set ignorecase      " case insensitive searching
set smartcase       " search case insensitive; if upper exists sensitive;

set number
set relativenumber
set cursorline
set cursorcolumn

" don't yank to clipboard with c
nnoremap c "_c
" ex mode type Q as q!
cnoremap Q q!

" keybindings
" move focus to next split instead of resizing
nnoremap <Tab> <C-W>w
" split open (<leader>q quit a split)
map <leader>x :split<CR>
map <leader>v :vsplit<CR>
" split movement with ctrl+h/j/k/l
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" split resize with ctrl+y/u/i/o
map <C-y> :vertical resize -2<CR>
map <C-u> :resize +2<CR>
map <C-i> :resize -2<CR>
map <C-o> :vertical resize +2<CR>

map <leader>s :set spell!<CR>
map <leader>w :set wrap!<CR>
map <leader>C :set cursorcolumn!<CR>
map <leader>h :set hlsearch!<CR>
map <leader>t :tabnew<CR>
map <leader>p :tabprev<CR>
map <leader>n :tabnext<CR>

" don't comment on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
