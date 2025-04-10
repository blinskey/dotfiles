set nocompatible
set secure
set nomodeline

augroup vimrc
	autocmd!
augroup END

filetype plugin indent on

" Built-in plugins
silent! packadd! matchit
silent! packadd! editorconfig " Vim 9.1
silent! packadd! comment " Vim 9.1.?

silent! syntax enable
set background=dark
silent! colorscheme iceberg

set shortmess+=I  " No intro message on startup.
set encoding=utf-8

" Enable keymap but start in Latin keyboard mode.
silent! set keymap=armenian-western_utf-8
set iminsert=0
set imsearch=0

set nowrap
set textwidth=79
set colorcolumn=80

" See :h fo-table.
set formatoptions+=cqnl1j

set wildmode=longest,list
set wildignore=*.o,*.obj,*.pyc,*/node_modules/*,*/.git/*
set autoindent
set smarttab
set ignorecase
set smartcase
set autoread
set incsearch
set nohlsearch
set ttimeoutlen=100
set splitright
set splitbelow
set noshowmode

set foldmethod=syntax
setlocal foldlevelstart=99
setlocal foldlevel=99

" Store swapfiles in ~/tmp/vim.
if !isdirectory($HOME . "/tmp/vim")
	call mkdir($HOME . "/tmp/vim", "p")
endif
set directory=$HOME/tmp/vim

" Filetypes for file extensions
autocmd vimrc BufRead,BufNewFile .gitignore set filetype=conf
autocmd vimrc BufRead,BufNewFile Jenkinsfile set filetype=groovy

map <leader>e :Explore<cr>
map <leader>s :Sexplore<cr>
map <leader>v :Vexplore<cr>
let g:netrw_banner = 0  " Hide banner.

let g:ale_set_signs = 0
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_linters =
	\ {
	\ 'python': ['flake8', 'mypy'],
	\ 'c': ['cc']
	\ }

" Strip trailing whitespace on write, preserving window view.
function! s:StripTrailingWhitespace()
	let l:view = winsaveview()
	%s/\s\+$//e
	call winrestview(l:view)
endfun
autocmd vimrc BufWritePre * :call s:StripTrailingWhitespace()
command WritePreservingWhitespace noautocmd w

" Commands to switch indentation style in current buffer
command TwoSpaceTabs setlocal expandtab ts=2 sts=2 shiftwidth=2
command FourSpaceTabs setlocal expandtab ts=4 sts=4 shiftwidth=4

" Toggle paste mode.
noremap <leader>p :set paste! paste?<CR>

" In Insert mode, press Ctrl-F to make the word before the cursor uppercase.
inoremap <C-F> <Esc>gUiw`]a

if executable("rg")
	set grepprg=rg\ --vimgrep\ $*
else
	set grepprg=grep\ -rIn\ $*\ /dev/null
endif

" Treat .h files as C, not C++.
let g:c_syntax_for_h = 1

" CtrlP mapping
let g:ctrlp_map = '<leader>f'
let g:ctrlp_custom_ignore = '\v.+\.(gcda|gcno)$'
