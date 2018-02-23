" VIM configuration
" jachermocilla@gmail.com
"

set background=dark
set tabstop=3
set shiftwidth=3
set expandtab
set smarttab
set modeline
set wrap

autocmd FileType plugin indent on

" Filetype-specific tabs
autocmd FileType html setlocal ts=3 sw=3 expandtab
autocmd FileType javascript setlocal ts=3 sw=3 expandtab
autocmd FileType python setlocal ts=4 sw=4 expandtab

"save everytime
set autowriteall
autocmd CursorHold,CursorHoldI,InsertLeave * silent! wall

set encoding=utf8
set ffs=unix,dos,mac

set nobackup
set nowb
set noswapfile

syntax on
colorscheme torte

set number
set showmatch

"stick to 80x25
"set textwidth=75

"Key Mappings
let Tlist_WinWidth=30


"Generate ctags for current dir
map <F9> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>

"make
map <F8> :!make<cr>

"make clean
map <F7> :!make clean<cr>

"git commit
map <F6> :!git commit -m'edits' * && git push <cr>

"git push
map <F5> :!git ftp -A push <cr>

"Toggle tags list
map <F4> :TlistToggle<cr>

"Open the tags window
map <F3> :TlistOpen<cr>

"shortcut to insert license
map <F2> :0r ~/.vim/srg-license.txt<cr>

