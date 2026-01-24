return {
  "L3MON4D3/LuaSnip",
  config = function(_, opts)
    local luasnip = require("luasnip")

    -- Load default friendly-snippets
    --  require("luasnip.loaders.from_vscode").lazy_load()

    -- Load your custom snippets (JSON-style)
    require("luasnip.loaders.from_vscode").lazy_load({
      paths = { "~/.config/nvim/snippets" },
    })

    -- (Optional) Load Lua-style snippets
    -- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })

    -- Example: extend snippets to other filetypes
    -- luasnip.filetype_extend("typescriptreact", { "javascript" })

    -- Keymaps for jumping between snippet fields (using Tab and Shift-Tab)
    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
      end
    end, { desc = "Jump to next snippet field" })

    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true), "n", true)
      end
    end, { desc = "Jump to previous snippet field" })
  end,
}
