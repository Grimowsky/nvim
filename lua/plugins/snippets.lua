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
  end,
}
