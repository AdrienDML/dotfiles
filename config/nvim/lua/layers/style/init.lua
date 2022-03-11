local plug = require("utils.plug")
local var = require("utils.var")
local opt = require("utils.opt")

local layer = {}

function layer.register_plugins()
    -- My fav theme
    plug.add_plugin("sainnhe/sonokai")
    require("layers.style.status_line").register_plugins()

end



function layer.init_config()
    -- Color scheme
    opt.set("termguicolors", true)
    var.set("sonokai_style", 'andromeda')
    var.set("sonokai_enable_italic", 0)
    var.set("sonokai_disable_italic_comment", 1)
    var.set("sonokai_transparent_background", 0)

    vim.api.nvim_command("colorscheme sonokai")

    -- Status line
    require("layers.style.status_line").init_config()
end


return layer
