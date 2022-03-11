local file = require("utils.file")
local plug = require("utils.plug")
local bind = require("utils.bind")
local mode = require("utils.mode")
local autocmd = require("utils.autocmd")
-- local var = require("utils.var")

local layer = {}

function layer.register_plugins()
    plug.add_plugin('uiiaoo/java-syntax.vim')
    plug.add_plugin('mfussenegger/nvim-jdtls') 
end

function layer.init_config()
    local lsp = require("vim.lsp")
    local capabilities = require("lspconfig").capabilities
    local jdtls = require("jdtls")
    -- Ignore patterns for java
    file.add_to_wildignore("build")
    file.add_to_wildignore("gradle")

    -- create a folder for all the workspaces.
    local workspace_dir = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local home = os.getenv('HOME')
    if not file.exists(home .. "/.local/share/jdtls") then
        file.mkdir(home .. "/.local/share/jdtls", true)
    end
    local workspace_folder = home .. "/.local/share/jdtls" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

    -- create the config
    local config =  {
        flags = {
          allow_incremental_sync = true,
        };
        handlers = {
          ["textDocument/publishDiagnostics"] = lsp_diag.publishDiagnostics,
        };
        capabilities = capabilities;
        on_init = on_init;
        on_attach = on_attach;
      }

    local extendedClientCapabilities = jdtls.extendedClientCapabilities

    config = {
        capabilities = capabilities,
        flags = { debounce_text_changes = 500 },
        -- The command that starts the language server
        cmd = {
            "/usr/bin/java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-noverify",
            "-Xms1G",
            "-jar",
            "/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.300.v20210813-1054.jar",
            "-data",
            "/home/" .. workspace_dir,
        },
      
        -- This is the default if not provided, you can remove it. Or adjust as needed.
        -- One dedicated LSP server & client will be started per unique root_dir
        root_dir = jdtls.setup.find_root({'mvnw', 'gradlew', 'pom.xml'}),

    }
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
    config.init_options = {
      -- bundles = bundles;
      extendedClientCapabilities = extendedClientCapabilities;
    }
    jdtls.start_or_attach(config)
end

return layer