set background=dark
colorscheme solarized

" Display line numbers
set number
set ruler

" Remappings
set timeoutlen=1000 ttimeoutlen=-1

" Searching criteria
set ignorecase				" ignore case in search patterns
set smartcase				" override ignorecase if search pattern has capital letters
set wildmode=longest,list	" list all matches
set showmatch				" highlight matching parentheses/brackets
set hlsearch				" highlight search results
set incsearch				" show matches while typing pattern

" Code folding
set foldmethod=indent
set foldlevel=99
"
" Hard-wrap text at 80 when editing file
set textwidth=80

" Whitespace Handling
function! StripTrailingWhitespaces()
	let l = line(".")
	let c = col(".")
	%s/\s\+$//e			" delete trailing whitespaces
	call cursor(l, c)		" return cursor to previous position
endfunction
autocmd FileType perl,sh,python,vi, autocmd BufWrite <buffer> :call StripTrailingWhitespaces()

" Use JavaScript syntax highlighting for JSON files
autocmd BufRead,BufNewFile *.json setfiletype javascript

"" Plugin settings

" vim-airline settings
let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1

" vim-syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" other python plugins?

