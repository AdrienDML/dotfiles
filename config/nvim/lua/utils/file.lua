
local autocmd = require("utils.autocmd")
local opt = require("utils.opt")
local file = {}


--- Set up auto-detection for filetypes by a name pattern (Eg: `*.cpp` -> `cpp`)
function file.set_filetype_for(pattern, filetype)
    autocmd.bind(
        "BufNewFile, BufRead" .. pattern,
        function()
            require("utils.opt").bset("filetype", filetype)
        end
    )
end

--- Add a pattern to the wildignore setting
function file.add_to_wildignore(pattern)
    local var = opt.get("wildignore")
    if  var == "" then
        opt.set("wildignore", pattern)
    else
        opt.set("wildignore", var .. "," .. pattern)
    end
end

--- Check if a file is readable
function file.is_readable(path)
    local f = io.open(path, "r")
    if f ~= nil then
        io.close()
        return true
    else
        return false
    end
end

--- Make a directory
function file.mkdir(path, make_parents)
    local opts 
    if make_parents then
        opts = "p"
    else
        opts = ""
    end
    vim.cmd(
        "call mkdir('" .. vim.fn.escape(vim.fn.fnameescape(path), '"') ..
        "', '" .. opts .. "')"
    )
end

function file.parent(path)
    return vim.fn.fnamemodify(path, ":h")
end

function file.make_full(path)
    return vim.fn.fnamemodify(path, ":p")
end

function file.make_relative_to_home(path)
    return vim.fn.fnamemodify(path, ":~")
end

-- function file.cp(path1, path2)
--     if file.exists(path1) && !file.exists(path2) then
--         local opts 
--         if make_parents then
--             opts = "p"
--         else
--             opts = ""
--         end
--         vim.cmd(
--             "call cp('" .. vim.fn.escape(vim.fn.fnameescape(path), '"') ..
--         )
--     end
-- end


function file.exists(path)
  local ok, _, code = os.rename(path, path)
  if not ok then
    if code == 13 then
      -- Permission denied, but it exists
      return true
    end
  end

  return ok
end

--- Check if a directory exists in this path
--
-- @tparam string path The file path
function file.is_dir(path)
  -- "/" works on both Unix and Windows
  return file.exists(path .. "/")
end

file.path_sep = package.config:sub(1, 1)

local function is_windows()
  return file.path_sep == "\\"
end

--- Returns the path to the home directory
function file.get_home_dir()
  local home = os.getenv("HOME")
  if home ~= nil then return home end

  if is_windows() then
    local userprofile = os.getenv("USERPROFILE")
    if userprofile ~= nil then return userprofile end
  end

  error("Failed to get home directory")
end

return file
