-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader        = ","
vim.g.maplocalleader   = " "

vim.opt.tabstop        = 4
vim.opt.softtabstop    = 4
vim.opt.shiftwidth     = 4
vim.opt.expandtab      = true
vim.opt.wrap           = false

vim.opt.nu             = true
vim.opt.relativenumber = true
vim.opt.smartindent    = true

vim.opt.swapfile       = false
vim.opt.backup         = false
vim.opt.undofile       = true
vim.opt.undodir        = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.scrolloff      = 8
vim.opt.colorcolumn    = "80"

vim.opt.foldmethod     = "indent"
vim.opt.foldlevel      = 12

vim.opt.incsearch      = true


-- Remove trailing spaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    callback = function()
        local curr_cursor_pos = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", curr_cursor_pos)
    end,

})

-- auto format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go", "*.py", "*.lua" },
    callback = function()
        vim.lsp.buf.format()
    end
})



-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
})
