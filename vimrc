"
" Sangdol's Vim Configuration
"

" Auto Commands {{{

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

"}}}

" Misc Settings {{{

" Use vim settings, rather then vi settings
" This must be first, because it changes other options as a side effect.
set nocompatible

" Folding Stuffs
set foldmethod=marker

" Needed for Syntax Highlighting and stuff
filetype plugin indent on
syntax enable

" Tab settings
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

set number " always show line numbers
set autoindent " always set autoindenting on

" Search settings
set ignorecase
set incsearch
set hlsearch

" Backspace on EOL, start, indent
set backspace=eol,start,indent

set history=1000
set undolevels=1000

" set <Leader>
let mapleader=","

" From Vim 7.3, it can yank to and paste from clipboard
set clipboard=unnamed

" You should make directories by yourself
set backup
set backupdir=~/.vim/backup
set directory=~/.vim/swap

" encoding and line ending settings
set encoding=utf8
set fileencodings=utf8,cp949,latin1
set fileformats="unix,dos"

"}}}
"
"{{{Look and Feel

set background=dark

if has("gui_running")
	colorscheme Tomorrow-Night
	set guioptions-=T " Remove Toolbar
	set guifont=Monaco:h16
else
	colorscheme Tomorrow-Night-Bright
	" Enable mouse support in terminal
	set mouse=a
endif

"Status line
set laststatus=2
set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

" }}}

"{{{ Functions

" Open URL in browser
function! Browser ()
	let line = getline (".")
	let line = matchstr (line, "http[^	]*")
	 if !empty(line)
		 " TODO: Add if statement for Windows and Cygwin
		 exec "!open ".line
	 else
		 echo "No URL found"
	 endif
endfunction

" Paste Toggle
let paste_mode = 0 " 0 = normal, 1 = paste
func! Paste_on_off()
	if g:paste_mode == 0
			set paste
		let g:paste_mode = 1
	else
		set nopaste
		let g:paste_mode = 0
	endif
	return
endfunc

"}}}

"{{{ Mappings

" Open browser
nnoremap <Leader>w :call Browser()<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" Next Tab
nnoremap <silent> <C-k> :tabnext<CR>

" Previous Tab
nnoremap <silent> <C-j> :tabprevious<CR>

" New Tab
nnoremap <silent> <C-t> :tabnew<CR>

" Paste Mode!
nnoremap <silent> <F10> :call Paste_on_off()<CR>
set pastetoggle=<F10>

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>
nnoremap <silent> zh i<Space><Right><Esc>
nnoremap <silent> zl a<Space><Left><Esc>

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a search will center on the line it's found in.
map N Nzz
map n nzz

" Turn off highlight
nnoremap <silent> <Leader>n :noh<CR>

" Easy escape
inoremap jk <Esc>

" Open help page about a word under cusor
nnoremap <leader>h :h <C-r><C-w><CR>

" Shift tab default action
inoremap <S-Tab> <Esc><<i

" Move between windows by <Leader>number
let i = 1
while i <= 9
	execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
	let i = i + 1
endwhile

cnoremap W<CR> w<CR>
cnoremap Q<CR> q<CR>
cnoremap Q!<CR> q!<CR>
cnoremap Wq<CR> wq<CR>

" Change cursor shape in different modes(In OSX)
" http://vim.wikia.com/wiki/Change_cursor_shape_in_different_modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Toggle show tabs and trailing spaces (,c)
set lcs=tab:›\ ,trail:·,eol:¬,nbsp:_
set fcs=fold:-
nnoremap <silent> <leader>c :set nolist!<CR>

"}}}

" OS Specific {{{

if has("win32unix")
	" Cygwin
	source ~/.cygvimrc
endif

" }}}
