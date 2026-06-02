return {
    {
        "fabius/molokai.nvim",
        dependencies = "rktjmp/lush.nvim",
        lazy = false,
        priority = 1000,
    },

    {
        "rose-pine/neovim",
        name = "rose-pine",
    },
    {
        'projekt0n/github-nvim-theme',
        name = 'github-theme',
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
    },

    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && npm install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
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
            local mason = require("mason")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            mason.setup()

            local opts = { silent = true, noremap = true }
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)


            -- lua_ls begin
            vim.lsp.config('lua_ls', {
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
            })
            vim.lsp.enable('lua_ls')
            -- lua_ls end

            local jdtls_dir = '/home/artty/.jdtls'
            local jdtls_workspace = '/home/artty/.jdtls-workspace' .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            vim.lsp.config('jdtls', {
                cmd = {
                    -- '/usr/bin/java',
                    -- '/usr/lib/jvm/java-25-openjdk/bin/java',
                    '/usr/lib/jvm/java-latest-openjdk/bin/java',
                    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                    '-Dosgi.bundles.defaultStartLevel=4',
                    '-Declipse.product=org.eclipse.jdt.ls.core.product',
                    '-Dlog.level=ALL',
                    '-Xmx1G',
                    '--add-modules=ALL-SYSTEM',
                    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
                    '-jar', jdtls_dir .. '/plugins/org.eclipse.equinox.launcher_1.7.100.v20251111-0406.jar',
                    '-configuration', jdtls_dir .. '/config_linux',
                    '-data', jdtls_workspace,

                }
            })
            vim.lsp.enable('jdtls')

            vim.lsp.config('gopls', {
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

            })
            vim.lsp.enable('gopls')

            local json_capabilities = vim.lsp.protocol.make_client_capabilities()
            json_capabilities.textDocument.completion.completionItem.snippetSupport = true
            vim.lsp.config('jsonls', {
                capabilities = json_capabilities,
            })
            vim.lsp.enable('jsonls')

            vim.lsp.config('emmet_language_server', {
                settings = {
                    filetypes = {
                        "js", "css", "eruby", "html", "htmldjango", "javascriptreact",
                        "less", "pug", "sass", "scss", "typescriptreact", "htmlangular",
                    }
                }
            })
            vim.lsp.enable('emmet_language_server')

            vim.lsp.config('ts_ls', {
                capabilities = capabilities,
                settings = {
                    ts_ls = {
                        includeInlayParameterNameHints = 'all',
                    }
                },
                init_options = {
                    usePlaceholders = true,
                }
            })
            vim.lsp.enable('ts_ls')

            -- tofu-ls lsp setup
            vim.lsp.config['tofu_ls'] = {
                cmd = { 'tofu-ls', 'serve' },
                -- Base filetypes
                filetypes = { 'terraform', 'terraform-vars' },
                root_markers = { '.terraform', '.git' },
            }

            vim.lsp.enable('tofu_ls')


            vim.lsp.config('rust_analyzer', {
                settings = {
                    ['rust-analyzer'] = {
                        diagnostics = {
                            enable = false,
                        }
                    }
                }
            })
            vim.lsp.enable('rust_analyzer')

            local servers = {
                'sqls', 'pyright', 'tailwindcss', 'clangd', 'bashls', 'cssls',
                'docker_compose_language_service', 'docker_language_server', 'dockerls',
                -- "terraformls",
            }
            for _, lsp in ipairs(servers) do
                vim.lsp.config(lsp, {
                    capabilities = capabilities,
                    init_options = {
                        usePlaceholders = true,
                    }
                })
                vim.lsp.enable(lsp)
            end
        end,
    },

    --[[
       [ {
       [     "pmizio/typescript-tools.nvim",
       [     dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
       [     opts = {},
       [ },
       ]]

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
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate'
    },

    {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        config = function()
            local ls = require("luasnip")
            vim.keymap.set({ "i", "s" }, "<C-S>", function() ls.jump(1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-A>", function() ls.jump(-1) end, { silent = true })
            require("luasnip.loaders.from_snipmate").lazy_load({})
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
            vim.keymap.set("n", "<leader>m", ":Vista!!<cr>", { silent = true })
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
            vim.keymap.set(
                'n', '<leader>fs',
                function()
                    builtin.live_grep({ disable_coordinates = true })
                end,
                {}
            )
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
            vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, {})

            vim.keymap.set('n', '<leader>fm', builtin.marks, {})

            vim.keymap.set(
                'n', '<leader>fd',
                function()
                    builtin.diagnostics({ bufnr = 0, no_sign = true })
                end,
                {}
            )
            t.load_extension('fzf')

            local _defaults = require('telescope.themes').get_ivy()
            _defaults['file_ignore_patterns'] = {
                'node_modules/',
            }

            _defaults['preview'] = {
                treesitter = {
                    enable = false
                }
            }

            t.setup {
                defaults = _defaults,
                pickers = {
                    diagnostics = {
                        theme         = "dropdown",
                        layout_config = { width = 0.95 },
                    },
                    live_grep = {
                        theme = "dropdown",
                    }
                }
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
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },

    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup({})
        end
    },

    { 'mfussenegger/nvim-jdtls' },

    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            local lsp_lines = require("lsp_lines")
            lsp_lines.setup()
            vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
            vim.keymap.set("n", "<leader>l", lsp_lines.toggle, { desc = "Toggle lsp_lines" })
        end,
    },


}
