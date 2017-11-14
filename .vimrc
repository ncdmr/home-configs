" Nic De Muyer VIMRC

set nocompatible              " be iMproved, required
filetype off                  " required

let mapleader = ","
" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" Show whitespace
" " MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Useful settings
set history=700
set undolevels=700


" Real programmers don't use TABs but spaces
syntax on
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable stupid backup and swap files - they trigger too many events
" " for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Showing line numbers and length
set number  " show line numbers
set tw=240   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
"set colorcolumn=80
highlight CursorColumn ctermfg=black ctermbg=Yellow cterm=bold guifg=black guibg=yellow gui=bold

set background=dark

set nocompatible

" IMAP DEFINITIONS
imap ,ndag <c-r>=strftime("%Y-%m-%d")<cr><cr>{<cr>}<esc>ka<cr><tab>
imap ,sdate <c-r>=strftime("%Y-%m-%d")<cr>
imap ,stijd <c-r>=strftime("%H:%M")<cr>
" ToDo items
imap ,todo <c-r>=strftime("%Y-%m-%d")<cr> Task: <cr>{<cr>}<esc>ka<cr><tab>
imap ,stamp <c-r>=strftime("%d/%m-%H:%M")<cr>

" search stuff
set incsearch
set hlsearch " highlight searchstring
set ignorecase "ignore upper case
set smartcase 
set nowrap

" fold
set foldmethod=indent

" file, write, backup
set nobackup
set nowritebackup
set autoread " notify when file changed outside vim

" no recover alerts or sponsoring
set shortmess+=IA

"indent
set autoindent

" crosshair
set cursorline
set cursorcolumn

" layout & theme
set bg=dark
if has("gui_running")
	set guioptions=agiLe "comment to have full gui. 
	set guioptions-=T
    colo slate
else
	colo slate
endif

" handy statusline at the bottom
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


let perl_fold=1
let perl_fold_blocks=1

" Folding for notes
function! Notes_fold()
	if getline(v:lnum+1)[0] == '{'
		return '>1'
	endif
	if getline(v:lnum)[0] == '}'
		return '<1'
	endif
	return foldlevel(v:lnum-1)
endfunction
au BufNewFile,BufRead * set foldexpr=Notes_fold()

filetype plugin indent on
filetype plugin on

runtime ftplugin/man.vim
runtime ftplugin/perl.vim
runtime ftplugin/pod.vim
runtime ftplugin/asciidoc.vim

" auto interpreter lines
au BufEnter *.sh if getline(1) == "" | :call setline(1, "#!/bin/ksh") | endif
au BufEnter *.py if getline(1) == "" | :call setline(1, "#!/usr/bin/python") | endif 
au BufEnter *.pl if getline(1) == "" | :call setline(1, "#!/usr/bin/perl") | endif


" theme rotate
let themeindex=0
function! RotateColorTheme()
  let y = -1
  while y == -1
   	let colorstring = "#molokai.vim#google-prettify.vim#pyte.vim#slate.vim#professional.vim#adaryn.vim#desert.vim#ekvoli.vim#darktango.vim"
    let x = match(colorstring,"#",g:themeindex)
    let y = match(colorstring,"#",x+1)
    let g:themeindex = x+1
   " :echo x y g:themeindex
    if y == -1
      let g:themeindex = 0
    else
      let themestring = strpart(colorstring,x+1,y-x-1)
      echo("Setting Theme to-> ".themestring)
      "return ":so $VIMRUNTIME/colors/".themestring
      return ":so ~/.vim/colors/".themestring
    endif
  endwhile
endfunction

" KEYBINDINGS

" folding
nnoremap <F5> :set foldmethod=expr foldlevel=0 foldcolumn=0<CR> 

 " Key for theme rotate function
map <F7> :execute RotateColorTheme()<CR>

"remove all blank lines.  
map <S-F7> :g/^\s*$/d<CR>

" Change local directory to directory of current file.
nnoremap <F8> :lcd %:p:h<CR>

" Reduce a sequence of empty lines into a single line.
nnoremap <F9> GoZ<Esc>:g/^$/.,/./-j<CR>Gdd

" Toggle menu & toolbars
map <silent> <C-F2> :if &guioptions =~# 'T' <Bar>
    \set guioptions-=T <Bar>
    \set guioptions-=m <bar>
\else <Bar>
    \set guioptions+=T <Bar>
    \set guioptions+=m <Bar>
\endif<CR>
 
map <S-F2> :DIstart<cr>
map <S-F3> :DIstop<cr>
cmap <F3> %<C-R>=strftime("_%Y%m%d_%H%M")<CR>

"easier indenting code blocks
vnoremap < <gv 
vnoremap > >gv 

"list hidden characters
"set list
"set listchars=tab:▸\ ,eol:¬
