local plug = require("utils.plug")
local log = require("utils.log")
local reload = require("utils.reload")
local layer ={}

layer.layers = {}


function layer.add_layer(name)
    table.insert(
        layer.layers,
        {
            name = name,
            module = require(name),
        }
    )
end

local function err_handler(err)
    return {
        err = err,
        traceback = debug.traceback(),
    }
end 

local function call_on_layers(func_name)
    for _, l in ipairs(layer.layers) do
        local ok, err = xpcall(l.module[func_name], err_handler)
        if not ok then
            log.set_highlight("WarningMsg")
            log("Error while loading layer " .. l.name .. " / " .. func_name)
            log.set_highlight("None")
            log(err.err)
	    log(" ")
            log.set_highlight("WarningMsg")
	    log("Traceback")
            log.set_highlight("None")
	    log(err.traceback)
	    log(" ")
        end
    end
end

function layer.finish_layer_registration()
    call_on_layers("register_plugins")
    plug.finish_plugins_registration()
    reload.update_package_path()
    call_on_layers("init_config")
end

return layer
