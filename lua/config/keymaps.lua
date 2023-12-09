local keymap = vim.keymap

-- Directory Navigation
keymap.set("n","<leader>m", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
keymap.set("n","<leader>f", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Pane Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts) -- Left
keymap.set("n", "<C-j>", "<C-w>j", opts) -- Down
keymap.set("n", "<C-k>", "<C-w>k", opts) -- Up
keymap.set("n", "<C-l>", "<C-w>l", opts) -- Right

--  Window Management
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- Split vert
keymap.set("n", "<leader>sh", ":vsplit<CR>", opts) -- Split horiz
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- Toggle minimize

-- Indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Comments
vim.api.nvim_set_keymap("n", "<C-_>", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-_>", "gcc", { noremap = false })
