" Compatibility
set nocompatible
filetype off
set encoding=utf-8

let mapleader=","

" set the runtime path to include Vundle and set path where Vundle should install plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" """"""""""""""""""""""
" more plugins go here...
" """"""""""""""""""""""

" Python code folding compatible with PEP 8
Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1    " enable docstring view when code folded

" Python indentation compatible with PEP 8
Plugin 'vim-scripts/indentpython.vim'

" Python code completion
Plugin 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1   " close autocomplete win
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR> " goto def
let g:ycm_python_binary_path = 'python'     " search for first python exec and attach the file to that env

" Syntax checking on exit
Plugin 'vim-syntastic/syntastic'

" Python PEP 8 checking
Plugin 'nvie/vim-flake8'

" Git
Plugin 'tpope/vim-fugitive'

" Solarized theme
Plugin 'altercation/vim-colors-solarized'

" File directory
Plugin 'scrooloose/nerdtree'
let NERDTreeIgnore=['\.pyc$', '\~$'] " ignore files in NERDTree
map <C-n> :NERDTreeToggle<CR>   " Ctrl-n toggles NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif   " only NERDTree open in vim, close
let NERDTreeShowHidden=1

" Git support for nerdtree
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Powerline in vim
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1

" Git information
Plugin 'airblade/vim-gitgutter'

" Focus works correctly when vim in tmux
Plugin 'tmux-plugins/vim-tmux-focus-events'

" Coffeescript highlighting
Plugin 'kchmck/vim-coffee-script'

" """"""""""""""""""""""
" ...until here
" """"""""""""""""""""""
call vundle#end()
filetype plugin indent on

" Color and Style
let python_highlight_all=1
syntax enable				" enable syntax highlighting

set background=dark
colorscheme solarized

" Display Line Numbers
set number				" display line numbers
set ruler				" display cursor position

" Searching Criteria
set ignorecase				" ifnore case in search patterns
set smartcase				" override ignorecase if search pattern has capital letters
set wildmode=longest,list	" list all matches
set showmatch				" highlight matching parentheses/brackets
set hlsearch				" highlight search results
set incsearch				" show matches while typing pattern

" Indentation
set autoindent				" copy indentation from current line when starting new line
set copyindent				" copy structure of indentation from previous line, e.g. comment symbols
set expandtab				" spaces instead of tabs, use C-V <tab> to get real tab
autocmd FileType make set noexpandtab	" don't convert tabs to spaces for Makefiles
set tabstop=4				" 1 tab == 4 spaces
set shiftwidth=4			" number of spaces to use for each auto-indent, e.g. >>, << commands
set softtabstop=4

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Remappings
set timeout timeoutlen=100
imap jk <Esc>

" Code folding
set foldmethod=indent
set foldlevel=99

set backspace=indent,eol,start
" Jump to last known position in a file just after opening it
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Whitespace Handling
function! StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e			" delete trailing whitespaces
	call cursor(l, c)		" return cursor to previous position
endfunction
autocmd FileType perl,sh,python,vi autocmd BufWrite <buffer> :call StripTrailingWhitespaces()

" Clear searches when opening file
autocmd BufReadPre <buffer> :let @/ = ""

" Use JavaScript syntax highlighting for JSON files
autocmd BufRead,BufNewFile *.json setfiletype javascript
