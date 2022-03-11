local plug = require("utils.plug")
local edit_mode = require("utils.mode")

local bind = {}

bind._leader_info = {}

function bind.register_plugins()
end

function bind.post_init()
    local leader = vim.api.nvim_get_var("mapleader")
    local local_leader = vim.api.nvim_get_var("maplocalleader")

    vim.g.c_keybind_leader_info = bind._leader_info
end

function bind.new(mode, keys, command, options)
    options = options or {}

    vim.api.nvim_set_keymap(mode.map_prefix, keys, command, options)
end


-- Binds a Vim command to a key sequence for the current buffer
function bind.buf_new(mode, keys, command, options)
    options = options or {}

    vim.api.nvim_buf_set_keymap(0, mode.map_prefix, keys, command, options)
end

bind._bound_funcs = {}


-- Binds a lua function to a key sequence
function bind.func(mode, keys, func, option)
    options = options or {}
    options.noremap = true 

    local func_name = "bind_" .. mode.map_prefix .. "-" .. keys

    local func_name_escaped = func_name
    -- Escape Lua things
    func_name_escaped = func_name_escaped:gsub("'", "\\'")
    func_name_escaped = func_name_escaped:gsub('"', '\\"')
    func_name_escaped = func_name_escaped:gsub("\\[", "\\[")
    func_name_escaped = func_name_escaped:gsub("\\]", "\\]")

    -- Escape VimScript things
    func_name_escaped = func_name_escaped:gsub("<", "<lt>")

    bind._bound_funcs[func_name] = func

    local lua_cmd = ":lua require('utils.bind')._bound_funcs['" .. func_name_escaped .. "']()<CR>"
    if mode.map_prefix == "i" then
        lua_cmd = "<C-o>" .. lua_cmd
    end
    
    vim.api.nvim_set_keymap(mode.map_prefix, keys, lua_cmd, options)
end

return bind
