" TODO auto download and install Noto Sans Mono font

set number                     " print line number
set colorcolumn=96
set listchars=tab:»\ ,trail:·
set list                       " print white characters
set autoindent                 " use same tab size in new next line
set smartindent
set cino=g0N-s
set expandtab                  " use space instead of tab
set shiftwidth=4
set softtabstop=4
set nowrap                     " don't wrap lines
set cursorline                 " make line in current line
set spell
set path+=**

":autocmd BufWritePost * silent! !echo "p" > ~/pipe &

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

nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :LazyGit<CR>
nnoremap <F4> :Neoformat<CR>
":%s/\([a-z]\)) :\n\( \+\)/\1)\r\2:\r\2
nnoremap <F5> :ClangdSwitchSourceHeader<CR>
nnoremap <C-f> :Telescope find_files<CR>

"sh -c 'curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.config/nvim/plugged')
  Plug 'b4winckler/vim-angry'
  Plug 'sbdchd/neoformat' " For cmake -> pip install --user cmake-format
  Plug 'preservim/nerdtree'
  Plug 'kdheepak/lazygit.nvim' " dnf copr enable atim/lazygit -y && dnf install lazygit

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim' "dnf install ripgrep #https://github.com/BurntSushi/ripgrep

"  Plug 'nvim-treesitter/nvim-treesitter'
"  Plug 'antoinemadec/FixCursorHold.nvim'
"  Plug 'nvim-neotest/neotest'

  Plug 'Pocco81/Catppuccino.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'google/vim-searchindex'

  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'



"  Plug 'szw/vim-tags'

"  Plug 'neovim/nvim-lspconfig'
"  Plug 'hrsh7th/nvim-cmp'
"  Plug 'hrsh7th/cmp-nvim-lsp'
"  Plug 'saadparwaiz1/cmp_luasnip'
"  Plug 'L3MON4D3/LuaSnip'
"  Plug 'simrat39/symbols-outline.nvim'
"  Plug 'nvie/vim-flake8'
"  Plug 'MattesGroeger/vim-bookmarks'
call plug#end()

colorscheme catppuccin

set completeopt=menu,menuone,noselect

lua << EOF

require('gitsigns').setup()

  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }

EOF

