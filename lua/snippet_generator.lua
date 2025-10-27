local M = {}

-- Get visual selection
local function get_visual_selection()
  local _, start_row, start_col, _ = unpack(vim.fn.getpos("'<"))
  local _, end_row, end_col, _ = unpack(vim.fn.getpos("'>"))

  local lines = vim.fn.getline(start_row, end_row)
  if not lines or #lines == 0 then
    return {}
  end

  lines[#lines] = string.sub(lines[#lines], 1, end_col)
  lines[1] = string.sub(lines[1], start_col)
  return lines
end

-- Load existing snippets safely
local function load_snippets(filepath)
  local f = io.open(filepath, "r")
  if not f then
    f = io.open(filepath, "w")
    f:write("{}")
    f:close()
    f = io.open(filepath, "r")
  end

  local content = f:read("*a")
  f:close()

  local ok, decoded = pcall(vim.fn.json_decode, content)
  if not ok or type(decoded) ~= "table" then
    return {}
  end
  return decoded
end

-- Save snippets JSON (pretty-printed)
local function save_snippets(filepath, data)
  local f = assert(io.open(filepath, "w"))
  local json = vim.fn.json_encode(data)
  json = json:gsub("},", "},\n"):gsub("{", "{\n"):gsub("}", "\n}")
  f:write(json)
  f:close()
end

-- Choose snippet file based on domain
local function get_snippet_file(domain)
  local folder = vim.fn.stdpath("config") .. "/snippets"
  if domain == "frontend" then
    return folder .. "/typescriptreact.json"
  elseif domain == "backend" then
    return folder .. "/typescript.json"
  else
    return folder .. "/global.json"
  end
end

-- Reload snippets after adding new snippet
local function reload_luasnip()
  local ok, luasnip = pcall(require, "luasnip")
  if not ok then
    return
  end
  require("luasnip.loaders.from_vscode").lazy_load({
    paths = { vim.fn.stdpath("config") .. "/snippets" },
  })
end

-- Main function
function M.create_vscode_snippet()
  local function get_input(prompt, callback)
    vim.ui.input({ prompt = prompt }, function(input)
      if not input or input == "" then
        vim.notify("Cancelled: missing input", vim.log.levels.WARN)
        return
      end
      callback(input)
    end)
  end

  get_input("Snippet Name: ", function(name)
    get_input("Snippet Prefix: ", function(prefix)
      get_input("Snippet Description: ", function(desc)
        get_input("Snippet Domain (frontend/backend/global): ", function(domain)
          domain = domain:lower()
          if domain ~= "frontend" and domain ~= "backend" and domain ~= "global" then
            vim.notify("Invalid domain! Use frontend, backend, or global.", vim.log.levels.ERROR)
            return
          end

          local selection = get_visual_selection()
          if #selection == 0 then
            vim.notify("No visual selection!", vim.log.levels.ERROR)
            return
          end

          local snippet_file = get_snippet_file(domain)
          local snippets = load_snippets(snippet_file)

          snippets[name] = {
            prefix = prefix,
            body = selection,
            description = desc,
          }

          save_snippets(snippet_file, snippets)
          reload_luasnip()
          vim.notify("✅ Snippet saved and LuaSnip reloaded: " .. snippet_file, vim.log.levels.INFO)
        end)
      end)
    end)
  end)
end

return M
