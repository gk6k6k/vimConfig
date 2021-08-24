set number                     " print line number
set listchars=tab:Â»\ ,trail:Â·  " map some white chars
set list                       " print white characters
set autoindent                 " use same tab size in new next line
set smartindent
set cino=g0N-s
set expandtab                  " use space instead of tab
set shiftwidth=4
set softtabstop=4
set nowrap                     " don't wrap lines
set cursorline                 " make line in current line

" navigation
nnoremap <C-Right>   :tabnext<CR>
nnoremap <C-Left>   ::tabprevious<CR>

nnoremap <C-h>   ::tabprevious<CR>
nnoremap <C-l>   :tabnext<CR>

nnoremap <A-Down> <C-W><C-J>
nnoremap <A-Up> <C-W><C-K>
nnoremap <A-Right> <C-W><C-L>
nnoremap <A-Left> <C-W><C-H>

nnoremap <A-j> <C-W><C-J>
nnoremap <A-k> <C-W><C-K>
nnoremap <A-l> <C-W><C-L>
nnoremap <A-h> <C-W><C-H>

call plug#begin('~/.config/nvim/plugged')
  Plug 'preservim/nerdtree'
  Plug 'b4winckler/vim-angry'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'overcache/NeoSolarized'
call plug#end()

let g:coc_global_extensions = ['coc-spell-checker']

set background=dark
"colorscheme NeoSolarized

vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
