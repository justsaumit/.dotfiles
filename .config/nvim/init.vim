set number
set relativenumber
set tabstop=4 softtabstop=4
set smarttab
set smartindent
set ignorecase
set mouse=a
set smartcase
set undodir=~/.nvim/undodir
set undofile
set incsearch
set nohlsearch
"set clipboard+=unamedplus
set splitbelow splitright

call plug#begin()

Plug 'https://github.com/vim-airline/vim-airline' " Vim-Airline 
Plug 'https://github.com/preservim/nerdtree' " NerdTree
Plug 'https://github.com/ryanoasis/vim-devicons' " Developer Icons
Plug 'https://github.com/preservim/tagbar' " Tagbar for code navigation
Plug 'https://github.com/joshdick/onedark.vim' " One Dark theme
Plug 'https://github.com/morhetz/gruvbox' " gruvbox theme
Plug 'https://github.com/prettier/vim-prettier' " 
Plug 'https://github.com/jiangmiao/auto-pairs' " Autodoublebrackets like vscode
Plug 'https://github.com/alvan/vim-closetag' " Auto close HTML tags
Plug 'https://github.com/akinsho/bufferline.nvim' " Upper Bufferline
Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
Plug 'https://github.com/tc50cal/vim-terminal' " Vim Terminal
Plug 'https://github.com/norcalli/nvim-colorizer.lua' " hexcode bgcolor
Plug 'https://github.com/neoclide/coc.nvim'  " Auto Completion
call plug#end()


"colorscheme onedark
"colorscheme gruvbox

nnoremap <C-f> :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
