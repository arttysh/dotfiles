return {
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000, },

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		},
		keys = {
		{
		  "<leader>?",
		  function()
		    require("which-key").show({ global = false })
		  end,
		  desc = "Buffer Local Keymaps (which-key)",
		},
		},
	},

    { 'nanotee/sqls.nvim' },

	{
        "neovim/nvim-lspconfig",

        dependencies = {
            "williamboman/mason.nvim"
        },

        config = function()
            local lspconfig = require("lspconfig")
            local mason = require("mason")

            mason.setup()

            -- lua_ls begin
            lspconfig.lua_ls.setup{
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                        return
                    end
                    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                        runtime = { version = 'LuaJIT' },

                      -- Make the server aware of Neovim runtime files
                      workspace = {
                        checkThirdParty = false,
                        library = { vim.env.VIMRUNTIME }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                      }
                  })
              end,
              settings = {
                  Lua = {}
              }
          }
          -- lua_ls end

          lspconfig.gopls.setup{}

          lspconfig.pyright.setup{}

          lspconfig.tailwindcss.setup{}

              lspconfig.tsserver.setup{}

          lspconfig.sqls.setup{
              on_attach = function(client, bufnr)
                  require('sqls').on_attach(client, bufnr)
              end
          }

      end,
  },
}
