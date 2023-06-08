vim.g.mapleader = ","
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move code block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keeps cursor in the middle for search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- copy to clipboard selection
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- copy to clipboard entire line
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Disabling the evil
vim.keymap.set("n", "Q", "<nop>")

-- Quick replace -- GOD LEVEL
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- chmod +x <file>
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- easy navigations
vim.keymap.set({"n", "i"}, "<C-j>", "<C-w><C-j>")
vim.keymap.set({"n", "i"}, "<C-k>", "<C-w><C-k>")
vim.keymap.set({"n", "i"}, "<C-h>", "<C-w><C-h>")
vim.keymap.set({"n", "i"}, "<C-l>", "<C-w><C-l>")

vim.keymap.set("n", "gj", ":tabprevious<CR>")
vim.keymap.set("n", "gk", ":tabnext<CR>")

-- Aerial (Tags)
vim.keymap.set('n', '<leader>m', ':AerialToggle<CR>')

-- TODO: 
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
--
-- quickfix movements
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
