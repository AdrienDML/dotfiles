--- Layer management
-- @module l.editor.layer_man

local cmd = require("utils.cmd")
local file = require("utils.file")

local layer_man = {}

-- The function to edit a certain layer
local function edit_layer(layer_name)
  -- TODO: Support $XDG_CONFIG_HOME?
  local layer_dir = "~/.config/nvim/lua/layers/" .. layer_name
  if not file.is_dir(layer_dir) then
    file.mkdir(layer_dir, false)
  end
  vim.cmd("edit " .. layer_dir)
end

function layer_man.init_config()
  cmd.new("CEditLayer", edit_layer, 1)
end

return layer_man
