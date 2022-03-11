local reload = require("utils.reload")
reload.unload_user_modules()
local log = require("utils.log")
log.init()

local layer = require("utils.layer")
local bind = require("utils.bind")
local autocmd = require("utils.autocmd")


bind.register_plugins()
autocmd.init()

layer.add_layer("layers.editor")
layer.add_layer("layers.lsp")
--layer.add_layer("layers.c_cpp")
--layer.add_layer("layers.python")
-- layer.add_layer("layers.java")
layer.add_layer("layers.rust")
layer.add_layer("layers.style")
layer.finish_layer_registration()

bind.post_init()
