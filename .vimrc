set nocompatible

filetype off
filetype plugin indent on

set ttyfast

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [POS=%04l,%04v]\ [LEN=%L]\ [%p%%]\
set scrolloff=2 " keep 2 lines above scrolloff
set showmatch " highlight bracketted string
set backspace=indent,eol,start
set textwidth=120 " textwidth
set formatoptions=croqt
set ruler
set number
set visualbell
set encoding=utf-8
set autoread
set autoindent
set backspace=indent,eol,start
set incsearch
set hlsearch

" crosshair
set cursorline
set cursorcolumn
hi cursorline guibg=yellow
hi cursorcolumn guibg=yellow

" Basic vim settings
set hidden
set visualbell
set number
set nobackup
set noswapfile
set noshowmode

" Set the terminal's title
set title

" Global tab width.
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Set to show invisibles (tabs & trailing spaces) & their highlight color
set list listchars=tab:»\ ,trail:·

" Configure spell checking
nmap <silent> <leader>p :set spell!<CR>
set spelllang=en_us

" Set leader to comma
let mapleader = ","

" Default to magic mode when using substitution
cnoremap %s/ %s/\v
cnoremap \>s/ \>s/\v

" Capture current file path into clipboard
function! CaptureFile()
  let @+ = expand('%')
endfunction
map <leader>f :call CaptureFile()<cr>

" Rename current file
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

" Strip whitespace on save
fun! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfun

command -nargs=0 Stripwhitespace :call <SID>StripTrailingWhitespaces()

" Fix indentation in file
map <leader>i mmgg=G`m<CR>

" Toggle highlighting of search results
nnoremap <leader><space> :nohlsearch<cr>

" Unsmart Quotes
nnoremap guq :%s/\v[“”]/"/g<cr>

if has("autocmd")
  " StripTrailingWhitespaces
  autocmd BufWritePre * Stripwhitespace

" To spell check all git commit messages
  au BufNewFile,BufRead COMMIT_EDITMSG set spell nonumber nolist wrap linebreak

  " Set filetype tab settings
  autocmd FileType python,doctest set ai ts=4 sw=4 sts=4 et

  autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
endif

set bg=dark
if has("gui_running")
	set guioptions=agiLe "comment to have full gui.
	set guioptions-=T
    colo github
else
	colo slate
endif
" colo slate

" usefull keys
"remove all blank lines.
map <S-F7> :g/^\s*$/d<CR>
" Change local directory to directory of current file.
nnoremap <F8> :lcd %:p:h<CR>
" Reduce a sequence of empty lines into a single line.
nnoremap <F9> GoZ<Esc>:g/^$/.,/./-j<CR>Gdd
nnoremap <F10> lli:l
" Toggle menu & toolbars
map <silent> <C-F2> :if &guioptions =~# 'T' <Bar>
    \set guioptions-=T <Bar>
    \set guioptions-=m <bar>
\else <Bar>
    \set guioptions+=T <Bar>
    \set guioptions+=m <Bar>
\endif<CR>
cmap <F3> %<C-R>=strftime("_%Y%m%d_%H%M")<CR>
map <S-F8> :set guifont=consolas:h10<cr>
map <S-F9> :set guifont=consolas:h12<cr>
map <S-F10> lli:llli:llli:llli:llli:llli:llli:

" final font size
set guifont=consolas:h10
