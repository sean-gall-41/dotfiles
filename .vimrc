" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" set specific directories for backups, swaps, and undos
" (As it is, you won't notice much difference. If it bugs
" you, use set nobackup, nowritebackup, noswapfile, etc)
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//
" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin(s) for the detected file type.
" filetype plugin on

" Begin Plug section (how to use vim-plug: https://github.com/junegunn/vim-plug)
call plug#begin('~/.vim/plugged')
"load fzf (fuzzy file-finder)
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" load Pear Tree (auto-pair plugin: https://github.com/tmsvg/pear-tree)
Plug 'tmsvg/pear-tree'
" Initialize plugin system
call plug#end()

let g:UltiSnipsExpandTrigger="<space>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" always display the status line
set laststatus=2
" Load an indent file for the detected file type
filetype indent on

" turn desired colorscheme on upon open
colorscheme slate

" Turn syntax highlighting on.
syntax on

" indicate tab indentation with '|'
set list lcs=tab:\|\ 

" Add numbers to each line on the left-hand side
set number

" Set line numbers relative to current
set relativenumber

" open new split panels to the right, which feels more natural
set splitright

" Highlight cursor line underneath the cursor horizontally.
" set cursorline

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Reference chart of values:
" 	Ps = 0 -> blinking block
" 	Ps = 1 -> blinking block (default)
" 	Ps = 2 -> steady block
" 	Ps = 3 -> blinking underline
" 	Ps = 4 -> steady underline
" 	Ps = 5 -> blinking bar (xterm)
" 	Ps = 6 -> steady bar (xterm)
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" add new line without entering insert mode
nnoremap o o<Esc>
nnoremap O O<Esc>

" switch ESC to TAB for easier escaping from various places
nnoremap <Tab> <Esc> 
vnoremap <Tab> <Esc>gV
onoremap <Tab> <Esc>
cnoremap <Tab> <C-C><Esc>
inoremap <Tab> <Esc>`^
inoremap <Leader><Tab> <Tab>

" remap fzf invocation to something more convenient
nnoremap <silent> <C-f> :Files<CR>

" remap finding buffers
nnoremap <silent> <C-g> :Buffer<CR>

" Set behaviour of '<<' '>>' and '=='
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" While searching through a file incrementally highlight matching characters as you type.
set incsearch

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" remap yanking and pasting from/to system clipboard and vice-versa to
" 'easier' key combos 'ctrl+c' and 'ctrl+v'
vnoremap <C-c> "*y :let @+=@*<CR>
map <C-p> "+P

" remap sourcing vimrc for convenience
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set viminfo+=n~/.vim/viminfo

" automatically create header guards for c/c++ headers
function! s:insert_gates()
	let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
	execute "normal! i#ifndef " . gatename . "_"
 	execute "normal! o#define " . gatename . "_"
	execute "normal! Go#endif /* " . gatename . "_ */"
	normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

