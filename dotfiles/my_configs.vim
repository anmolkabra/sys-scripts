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

" vim-latex settings
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Disable auto-pairs completion in latex
autocmd FileType tex,cls     let b:AutoPairs = {}

" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:"}"

let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_ViewRule_pdf='xdg-open'

function CompileXeTex()
    let oldCompileRule=g:Tex_CompileRule_pdf
    let g:Tex_CompileRule_pdf = 'xelatex -interaction=nonstopmode $*'
    call Tex_RunLaTeX()
    let g:Tex_CompileRule_pdf=oldCompileRule
endfunction
map <Leader>lx :<C-U>call CompileXeTex()<CR>
