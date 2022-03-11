local file = require("c.file")

local layer = {}
--- Returns plugins required for this layer
function layer.register_plugins()
end

--- Configures vim and plugins for this layer
function layer.init_config()
  local lsp = require("l.lsp")
  local lspconfig = require("lspconfig")

  -- TODO: Make this configurable per-project
  lsp.register_server(
    lspconfig.sumneko_lua,
    {
      cmd = {file.make_full("~/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/bin/Linux/lua-language-server")},
      settings = {
        Lua = {
          -- For fucks sake
          telemetry = {
            enable = false,
          },
          runtime = {
            -- Get the language server to recognize LuaJIT globals like `jit` and `bit`
            version = "LuaJIT",
            -- Add nvim paths to the lua path
            path = vim.split(package.path, ";"),
          },
          diagnostics = {
            globals = {
              "vim",
            },
          },
          workspace = {
            -- Make the server aware of nvim runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
            },
          },
        },
      },
    }
    )
end

return layer