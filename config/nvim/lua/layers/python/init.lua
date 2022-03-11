local layer = {}

function layer.register_plugins()
end

function layer.init_config()
    local lsp = require("layers.lsp")
    local completion = require("completion")
    local config = require("lspconfig")

    lsp.register_server(
        config.pylsp,
        {
            on_attach = completion.on_attach,
            cmd = {"pyls"},
            filetypes = { "python" },
            -- root_dir = function(fname)
            --     local root_files = {
            --       'pyproject.toml',
            --       'setup.py',
            --       'setup.cfg',
            --       'requirements.txt',
            --       'Pipfile',
            --     }
            --     return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
            --   end
        }
    )
end

return layer