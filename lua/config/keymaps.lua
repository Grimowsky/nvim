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

-- Snacks.nvim Explorer
keymap.set("n", "<Leader>e", function()
  local Snacks = require("snacks")

  -- Get all explorer pickers
  local explorer_pickers = Snacks.picker.get({ source = "explorer" })

  if #explorer_pickers == 0 then
    -- No explorer open, open a new one
    Snacks.picker.explorer()
  else
    -- Explorer exists, focus the first one
    explorer_pickers[1]:focus()
  end
end, vim.tbl_extend("force", opts, { desc = "File Explorer" }))

-- Create snippet from vuisual selection
vim.keymap.set("v", "<leader>sn", function()
  require("snippet_generator").create_vscode_snippet()
end, { desc = "Generate VSCode snippet from visual selection" })
