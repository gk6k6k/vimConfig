-- Install packer
local install_path = vim.fn.stdpath 'data' ..
                         '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system {'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path}
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[packadd packer.nvim]]

require('packer').startup(function(use)
  use({'wbthomason/packer.nvim'})

  use({'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        requires = { {'nvim-lua/plenary.nvim'} }
  })

  use({'princejoogie/dir-telescope.nvim',
        requires = {'nvim-telescope/telescope.nvim'},
        config = function()
          require('dir-telescope').setup({
            hidden = true,
            no_ignore = false,
            show_preview = true,
            follow_symlinks = false,
          })
        end,
  })

  use({'b4winckler/vim-angry'})

  use({'sbdchd/neoformat'}) -- For cmake -> pip install --user cmake-format

  use({'navarasu/onedark.nvim',
        config = function()
          vim.cmd('colorscheme onedark')
        end
  })

  use({'klen/nvim-config-local',
        config = function()
          require('config-local').setup {config_files = {".init.lua"}}
        end
  })

  use{('preservim/nerdtree')}
  use{('kdheepak/lazygit.nvim')}






    use({
    "stevearc/aerial.nvim",
    config = function()
      require("aerial").setup({
        on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
  end,

      })
    end,
  })

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('nvim-treesitter/playground')

    use('mbbill/undotree')
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- Uncomment the two plugins below if you want to manage the language servers from neovim
            {'williamboman/mason.nvim'}, {'williamboman/mason-lspconfig.nvim'},

            -- LSP Support
            {'neovim/nvim-lspconfig'}, -- Autocompletion
            {'hrsh7th/nvim-cmp'}, {'hrsh7th/cmp-nvim-lsp'},
            {'L3MON4D3/LuaSnip'}, {'hrsh7th/cmp-buffer'}
        }
    }

    use {
        "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    }


    use 'tpope/vim-rhubarb'
--    use {
--        'lewis6991/gitsigns.nvim', require('gitsigns').setup {
--            signs = {
--                add = {text = '+'},
--                change = {text = '~'},
--                delete = {text = '_'},
--                topdelete = {text = '‾'},
--                changedelete = {text = '~'}
--            }
--        }
--    }

    use('github/copilot.vim')

end)

vim.g.mapleader = " "

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

vim.keymap.set('n', '<A-Down>', '<C-W><C-J>')
vim.keymap.set('n', '<A-Up>', '<C-W><C-K>')
vim.keymap.set('n', '<A-Right>', '<C-W><C-L>')
vim.keymap.set('n', '<A-Left>', '<C-W><C-H>')

vim.keymap.set('n', '<C-Right>', ':tabnext<CR>')
vim.keymap.set('n', '<C-Left>', '::tabprevious<CR>')
vim.keymap.set('n', '<F2>', ':NERDTreeToggle<CR>')
vim.keymap.set('n', '<F3>', ':LazyGit<CR>')
vim.keymap.set('n', '<F4>', ':Neoformat<CR>')

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, {desc = '[S]earch [F]iles'})
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, {desc = '[S]earch [H]elp'})
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, {desc = '[S]earch current [W]ord'})
vim.keymap.set('n', '<leader>ss', function()
    require('telescope.builtin').find_files({
        default_text = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t:r")
    })
end, {desc = '[S]earch current [W]ord'})
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep,
               {desc = '[S]earch by [G]rep'})
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics,
               {desc = '[S]earch [D]iagnostics'})

vim.o.guicursor = ""

vim.o.autoindent = true
vim.o.smartindent = true
vim.o.cino = 'g0N-s'
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.wrap = false
vim.o.spell = true
vim.o.cursorline = true
--vim.o.relativenumber = true
vim.wo.number = true
vim.opt.scrolloff = 8
vim.o.list = true
vim.o.laststatus = 3
vim.o.mouse = ''
vim.opt.listchars = {tab = "» ", trail = '·'}
vim.opt.colorcolumn = "160"

require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = {"javascript", "c", "lua", "vim", "vimdoc", "query"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false
    }
}

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
    sources = {{name = 'nvim_lsp'}, {name = 'buffer'}, {name = 'luasnip'}},
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-j>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-k>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-l>'] = cmp.mapping.confirm({select = true})
    })
})

local lsp = require("lsp-zero")
-- local cmp = require('cmp')
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--  ['<C-j>'] = cmp.mapping.select_prev_item(cmp_select),
--  ['<C-k>'] = cmp.mapping.select_next_item(cmp_select),
--  ['<C-l>'] = cmp.mapping.confirm({ select = true }),
--  ["<C-Space>"] = cmp.mapping.complete(),
-- })
--
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil
--
-- lsp.setup_nvim_cmp({
--  mapping = cmp_mappings
-- })

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {error = 'E', warn = 'W', hint = 'H', info = 'I'}
})

lsp.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws",
                   function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd",
                   function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
                   opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
                   opts)
    vim.keymap
        .set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
                   opts)
end)

lsp.setup()

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {lsp.default_setup}
})

return

