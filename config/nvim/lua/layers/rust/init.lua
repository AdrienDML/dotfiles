local file = require("utils.file")
local plug = require("utils.plug")
local var = require("utils.var")

local layer = {}

function layer.register_plugins()
    plug.add_plugin('cespare/vim-toml')
    plug.add_plugin('rust-lang/rust.vim')
    plug.add_plugin('arzg/vim-rust-syntax-ext')
    plug.add_plugin('simrat39/rust-tools.nvim')
    plug.add_plugin('saecki/crates.nvim')
end

function layer.init_config()

    var.set("rustfmt_autosave")
    local lsp = require("layers.lsp")
    local completion = require("completion")
    local config = require("lspconfig")
    local rust_tools = require("rust-tools")
    
    -- local opts = {
    --     tools = { -- rust-tools options
    --         autoSetHints = true,
    --         hover_with_actions = true,
    --         inlay_hints = {
    --             show_parameter_hints = false,
    --             parameter_hints_prefix = "",
    --             other_hints_prefix = "",
    --         },
    --     },
    lsp.register_server(
        config.rust_analyzer,
        {
            on_attach = completion.on_attach,
            settings = {
                ["rust_analyzer"] = {
                    procMacro = {
                        enable = true
                    },
                } 
            }
        }
    )
    rust_tools.setup(opts)
    file.add_to_wildignore("target")
end

return layer
