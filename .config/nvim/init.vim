" General options
nnoremap ; :
set shell=/bin/bash
let mapleader = "\<Space>"
" UI options
set nu relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set nowrap
" Remaps for the basic movements
"   jumps to begining of the line
map H ^
"   jumps to end of the line
map L $
" Move by line for workman layout
nnoremap t gk
nnoremap k gj
vnoremap t gk
vnoremap k gj
" disable arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" Buffer operations
" 	source vimrc
nmap <Leader>so :source $MYVIMRC<CR>
"	edit vimrc
nmap <Leader>ve :e $MYVIMRC<CR>
"	save file
nmap <Leader>w :w<CR>
" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>
" <leader><leader> toggles between buffers
nnoremap <leader><leader> <c-^>
" Keymap for replacing up to next _ or -
noremap <leader>m ct_
" Keymap for commenting in block visual
vnoremap <C-n> :norm

" Plugin options
call plug#begin()
" Theme
Plug 'sainnhe/sonokai'
" Workspace enhancement
Plug 'airblade/vim-rooter'
" Lsp plugins

" Syntactic language support
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'rust-lang/rust.vim'
Plug 'rhysd/vim-clang-format'
call plug#end()

" Theme plugin config
if has('termguicolors')
	set termguicolors
end
let g:sonokai_style = 'shusia'
let g:sonokai_enable_italic = 0
let g:sonokai_disable_italic_comment = 1
colorscheme sonokai

