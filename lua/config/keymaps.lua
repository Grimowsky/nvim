-- keymaps
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Easier exit from insert mode
keymap.set("i", "jj", "<Esc>", opts)

-- Save file and quit
keymap.set("n", "<D-s>", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- Buffers
keymap.set("n", "<C-j>", ":bprevious<CR>", opts)
keymap.set("n", "<C-k>", ":bnext<CR>", opts)
