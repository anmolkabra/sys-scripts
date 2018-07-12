" Compatibility
set nocompatible

" Color and Style
syntax enable				" enable syntax highlighting

" Display Line Numbers
set number				" display line numbers
set ruler				" display cursor position

" Searching Criteria
set ignorecase				" ifnore case in search patterns
set smartcase				" override ignorecase if search pattern has capital letters
set wildmode=longest,list		" list all matches
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
autocmd BufRead,BufNewFile *.json,*.sublime-settings setfiletype javascript
