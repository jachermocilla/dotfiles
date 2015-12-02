" VIM configuration
" jachermocilla@gmail.com
"

set background=dark
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set wrap

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
set textwidth=80

"Key Mappings
let Tlist_WinWidth=20

"Toggle tags list
map <F4> :TlistToggle<cr>

"Generate ctags for current dir
map <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<cr>

"Open the tags window
map <F3> :TlistOpen<cr>
