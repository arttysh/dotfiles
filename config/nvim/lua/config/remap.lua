vim.keymap.set('n', '<leader>q', ':q<cr>')
vim.keymap.set('n', '<leader>x', ':Ex<cr>')


-- easy split navigation
vim.keymap.set('n', '<C-j>', '<C-W><C-j>')
vim.keymap.set('n', '<C-k>', '<C-W><C-k>')
vim.keymap.set('n', '<C-h>', '<C-W><C-h>')
vim.keymap.set('n', '<C-l>', '<C-W><C-l>')


-- easy tab navigation
vim.keymap.set("n", "gj", ":tabprevious<CR>")
vim.keymap.set("n", "gk", ":tabnext<CR>")
vim.keymap.set("n", "gJ", ":-tabmove<CR>")
vim.keymap.set("n", "gK", ":+tabmove<CR>")


-- Move code block
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")


-- keeps cursor in the middle for search
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])  -- entire line


-- Quick replace -- GOD LEVEL
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- resize split
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<C-Down>", ":resize +2<CR>")
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>")
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>")


-- resize split faster
vim.keymap.set("n", "<C-S-Down>", ":resize +10<CR>")
vim.keymap.set("n", "<C-S-Up>", ":resize -10<CR>")
vim.keymap.set("n", "<C-S-Left>", ":vertical resize -10<CR>")
vim.keymap.set("n", "<C-S-Right>", ":vertical resize +10<CR>")


-- diagnostics
vim.keymap.set("n", "<leader>d", ":lua vim.diagnostic.setqflist()<cr>")
