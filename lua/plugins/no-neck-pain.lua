return {
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    config = function()
      require("no-neck-pain").setup({
        width = 120, -- optional, adjust content width
        autocmd = true, -- automatically apply to buffers
        buffers = {
          left = {
            enabled = true,
            scratchPad = { enabled = true },
          },
          right = {
            enabled = true,
            scratchPad = { enabled = true },
          },
        },
      })

      vim.keymap.set("n", "<leader>nnp", function()
        require("no-neck-pain").toggle()
      end, { desc = "Toggle No Neck Pain" })
    end,
  },
}
