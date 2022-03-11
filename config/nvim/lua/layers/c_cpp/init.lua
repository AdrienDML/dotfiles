local file = require("utils.file")
local plug = require("utils.plug")
local var = require("utils.var")

local layer = {}

function layer.register_plugins()
    plug.add_plugin('bfrg/vim-cpp-modern')
    if not plug.has_plugin('rhysd/vim-clang-format') then
        plug.add_plugin('rhysd/vim-clang-format')
    end
end

function layer.init_config()

    local lsp = require("layers.lsp")
    local completion = require("completion")
    local config = require("lspconfig")
    var.set('cpp_function_highlight', true)
    var.set('cpp_attributes_highlight', true)
    var.set('cpp_member_highlight', true)
    var.set('cpp_simple_highlight', true)
    lsp.register_server(
        config.clangd,
        {
            on_attach = completion.on_attach,
        }
    )

    file.add_to_wildignore("build")
end

return layer