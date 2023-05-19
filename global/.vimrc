set nocompatible
set secure
set nomodeline

augroup vimrc
	autocmd!
augroup END

if !empty(glob('~/.vim/autoload/plug.vim'))
	silent! call plug#begin('~/.vim/plugged')
	" Use the local development copy of my colorscheme if present.
	if !empty(glob('~/src/btl.vim'))
		Plug '~/src/btl.vim'
	else
		Plug 'blinskey/btl.vim'
	endif

	Plug 'dense-analysis/ale'
	Plug 'editorconfig/editorconfig-vim'

	if executable('fzf')
		Plug 'junegunn/fzf'

		" This plugin provides additional fuzzy-finder commands for
		" searching things like buffers and tags.
		"Plug 'junegunn/fzf.vim'
	endif
	call plug#end()
endif

filetype plugin indent on
silent! packadd! matchit

silent! syntax enable
set background=dark
silent! colorscheme btl

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

map <leader><leader> :FZF<cr>
map <leader>f :FZF<cr>

" Set fzf colors to match color scheme. From :h fzf.
let g:fzf_colors =
	\ {
	\ 'fg':		['fg', 'Normal'],
	\ 'bg':		['bg', 'Normal'],
	\ 'hl':		['fg', 'Comment'],
	\ 'fg+':	['fg', 'CursorLine', 'CursorColumn', 'Normal'],
	\ 'bg+':	['bg', 'CursorLine', 'CursorColumn'],
	\ 'hl+':	['fg', 'Statement'],
	\ 'info':	['fg', 'PreProc'],
	\ 'border':	['fg', 'Ignore'],
	\ 'prompt':	['fg', 'Conditional'],
	\ 'pointer':	['fg', 'Exception'],
	\ 'marker':	['fg', 'Keyword'],
	\ 'spinner':	['fg', 'Label'],
	\ 'header':	['fg', 'Comment']
	\ }

let g:ale_set_signs = 0
let g:ale_virtualtext_cursor = 'disabled'
let g:ale_linters = {'python': ['flake8', 'mypy']}

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
