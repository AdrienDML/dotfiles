
--- Edit modes
-- @module c.mode

local mode = {}

--- Normal mode
mode.NORMAL = {
  map_prefix = "n",
}

--- Visual mode
mode.VISUAL = {
  map_prefix = "x",
}

--- Select mode
mode.SELECT = {
  map_prefix = "s",
}

--- Not a real mode, just for the vmap/vnoremap commands
mode.VISUAL_SELECT = {
  map_prefix = "v",
}

--- Insert mode
mode.INSERT = {
  map_prefix = "i",
}

--- Command mode
mode.COMMAND = {
  map_prefix = "c",
}

--- Operator pending mode
mode.OPERATOR_PENDING = {
  map_prefix = "o",
}

--- Terminal mode
mode.TERMINAL = {
  map_prefix = "t",
}

--- @return start_row, start_col, end_row, end_col
function mode.visual_range()
  local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
  local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))

  if csrow < cerow or (csrow == cerow and cscol <= cecol) then
    return csrow - 1, cscol - 1, cerow - 1, cecol
  else
    return cerow - 1, cecol - 1, csrow - 1, cscol
  end
end

return mode
