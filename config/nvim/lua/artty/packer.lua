-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        'folke/todo-comments.nvim',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }


    --[[
     [use({
	 [    'rose-pine/neovim',
	 [    as = 'rose-pine',
	 [    config = function()
	 [        vim.cmd('colorscheme rose-pine')
	 [    end
     [})
     ]]


    --[[
       [ use {
       [     "ellisonleao/gruvbox.nvim",
       [     as = "gruvbox",
       [     config = function()
       [         vim.cmd('colorscheme gruvbox')
       [     end
       [ }
       ]]
    --[[
       [ use {
       [     "loctvl842/monokai-pro.nvim",
       [     config = function()
       [         require("monokai-pro").load()
       [     end
       [ }
       ]]

    --[[
       [ use {
       [     "fabius/molokai.nvim",
       [     requires = {
       [         "rktjmp/lush.nvim"
       [     },
       [     config = function()
       [         vim.cmd('colorscheme molokai')
       [     end
       [ }
       ]]

    --[[
       [ use {
       [     "cpea2506/one_monokai.nvim",
       [     as = "one_monokai",
       [     config = function()
       [         vim.cmd('colorscheme one_monokai')
       [     end
       [ }
       ]]
    use {
        "catppuccin/nvim",
        as = "catppuccin",
        config = function()
            -- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
            vim.cmd('colorscheme catppuccin-mocha')
        end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use {
        "tpope/vim-dadbod",
        opt = true,
        requires = {
            "kristijanhusak/vim-dadbod-ui",
            "kristijanhusak/vim-dadbod-completion",
        },
        cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
    }

    use('ThePrimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('brenoprata10/nvim-highlight-colors')

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    }

    use('hrsh7th/cmp-nvim-lsp-signature-help')

    use('m4xshen/autoclose.nvim')

    use('preservim/nerdcommenter')

    use {
        'stevearc/aerial.nvim',
        config = function() require('aerial').setup() end
    }

    use("lukas-reineke/indent-blankline.nvim")

    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = {
            "markdown" } end, ft = { "markdown" }, })

    use("sebdah/vim-delve")

    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })
end)
