" TODO auto download and install Noto Sans Mono font OR Hack
":autocmd BufWritePost * silent! !echo "p" > ~/pipe &

set number                     " print line number
set colorcolumn=120
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
set clipboard+=unnamedplus


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

  Plug 'Pocco81/Catppuccino.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'google/vim-searchindex'

  Plug 'neovim/nvim-lspconfig'

  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lsp'

  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'

  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'

"  Plug 'nvim-treesitter/nvim-treesitter'
"  Plug 'antoinemadec/FixCursorHold.nvim'
"  Plug 'nvim-neotest/neotest'
"  Plug 'szw/vim-tags'
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
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer', keyword_length = 3 },
  })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.clangd.setup {
  capabilities = capabilities,
}

local ls = require "luasnip"
--local types = require "luasnip.util.types"
--
ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true
}

vim.keymap.set({"i", "s"}, "<c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, {silent = true }
)

vim.keymap.set({"i", "s"}, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, {silent = true }
)

EOF

