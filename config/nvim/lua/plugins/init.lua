return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme "catppuccin-mocha"
        end
    },

    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        end
    },

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
    },

    {
        "neovim/nvim-lspconfig",

        dependencies = {
            "williamboman/mason.nvim",
        },

        config = function()
            local lspconfig = require("lspconfig")
            local mason = require("mason")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            mason.setup()

            local opts = { silent = true, noremap = true }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
            vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)


            -- lua_ls begin
            lspconfig.lua_ls.setup {
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                        return
                    end
                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = { version = 'LuaJIT' },

                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = { vim.env.VIMRUNTIME }
                        }
                    })
                end,
                settings = {
                    Lua = {}
                }
            }
            -- lua_ls end

            lspconfig.gopls.setup {
                capabilities = capabilities,
                settings = {
                    gopls = {
                        experimentalPostfixCompletions = true,
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                    },
                },
                init_options = {
                    usePlaceholders = true,
                }

            }

            local servers = { 'sqls', 'pyright', 'tsserver', 'tailwindcss' }
            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup {
                    capabilities = capabilities,
                    init_options = {
                        usePlaceholders = true,
                    }
                }
            end
        end,
    },

    { "Bilal2453/luvit-meta",                     lazy = true },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
            library = {
                -- Load luvit types when the `vim.uv` word is found
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "go" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                ignore_install = {},
                auto_install = true,
                modules = {},
            })
        end
    },

    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        config = function()
            local ls = require("luasnip")
            vim.keymap.set({ "i", "s" }, "<C-S>", function() ls.jump(1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-A>", function() ls.jump(-1) end, { silent = true })
        end
    },

    {
        "hrsh7th/nvim-cmp",

        -- load cmp on InsertEnter
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            vim.opt.completeopt = { "menu", "menuone", "noselect" }

            local cmp = require("cmp")
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')

            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )

            cmp.setup({
                snippet = {
                    expand = function(args)
                        -- snippet engine
                        require('luasnip').lsp_expand(args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),

                sources = cmp.config.sources(
                    {
                        { name = "nvim_lsp" },
                        { name = "luasnip" },
                    },
                    {
                        { name = "buffer" },
                    }
                )

            })

            cmp.setup.filetype({ 'sql' }, {
                sources = {
                    { name = "nvim_lsp",             priority = 1000 },
                    { name = "vim-dadbod-completion" },
                    { name = "buffer" }
                }
            })
        end
    },

    {
        "liuchengxu/vista.vim",
        config = function()
            vim.keymap.set("n", "<leader>m", ":Vista!!<cr>")
        end,
    },

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local t = require("telescope")
            local builtin = require("telescope.builtin")

            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>fs', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            t.load_extension('fzf')

            t.setup {
                defaults = require('telescope.themes').get_ivy(),
            }
        end
    },

    {
        "preservim/nerdcommenter",
        dependencies = { 'nvim-telescope/telescope-fzf-native.nvim' },
        config = function()
            vim.g.NERDSpaceDelims = 1
        end
    },

    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    { 'tpope/vim-fugitive' },

    {
        "folke/todo-comments.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        opts = {},
    },

    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        config = function()
            require('glow').setup({
                width_ratio = 1,
                height_ratio = 1,
            })
        end
    },

    {
        'kristijanhusak/vim-dadbod-ui',
        dependencies = {
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql', '' }, lazy = true },
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
}
