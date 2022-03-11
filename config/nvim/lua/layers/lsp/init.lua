
local bind = require("utils.bind")
local var = require("utils.var")
local plug = require("utils.plug")
local mode = require("utils.mode")
local class = require("utils.class")
local autocmd = require("utils.autocmd")
local Signal = require("utils.signal").Signal

local layer = {}

local ClientProgress = class.strict {
    title = "...",
    message = class.NULL,
    percentage = class.NULL,
}

layer.client_progress = {}
layer.signal_progress_update = Signal()

layer.filetype_servers = {}

local builtin_capabilities = vim.lsp.protocol.make_client_capabilities()
builtin_capabilities.window = builtin_capabilities.window or {}
builtin_capabilities.window.workDoneProgress = true


local function user_stop_all_clients()
    local clients = vim.lsp.get_active_clients()

    if #clients > 0 then
        vim.lsp.stop_client(clients)
        for _, v in pairs(clients) do
        print("Stopped LSP client " .. v.name)
        end
    else
        print("No LSP clients are running")
    end
end

local function user_attach_client()
    local filetype = vim.bo[0].filetype

    local server = layer.filetype_servers[filetype]
    if server ~= nil then
        print("Attaching LSP client " .. server.name .. " to buffer")
        server.manager.try_add()
    else
        print("No LSP client registered for filetype " .. filetype)
    end
end

local function list_clients()
    local clients = vim.lsp.get_active_clients()
    if #clients > 0 then
        for _, v in pairs(clients) do
            print("LSP client : " .. v.name)
        end
    else
        print("No active LSP client.")
    end
end

local function on_progress(err, result, ctx, config)
    if err ~= nil then return end

    if result.value ~= nil and result.value.kind == "end" then
        layer.client_progress[ctx.client_id] = nil
    else
        local prog = layer.client_progress[ctx.client_id]
        if prog == nil then
        prog = ClientProgress()
        layer.client_progress[ctx.client_id] = prog
        end

        prog.title = result.value.title or prog.title
        prog.message = result.value.message or prog.message

        -- So the LSP spec says percentage should be a value between 0 - 100
        -- but some clients (like ccls) give a value between 0 - 1
        -- so here's a kludgey workaround
        if result.value.percentage ~= nil then
        local percent = result.value.percentage
        if percent <= 1 then
            prog.percentage = percent
        else
            prog.percentage = percent / 100
        end
        end
    end


    layer.signal_progress_update:emit()
end

function layer.register_plugins()
    plug.add_plugin("neovim/nvim-lspconfig")
    plug.add_plugin("nvim-lua/lsp_extensions.nvim")
    plug.add_plugin("nvim-lua/completion-nvim")
    plug.add_plugin("nvim-lua/lsp-status.nvim")
    plug.add_plugin("h-michael/lsp-ext.nvim")
end

function layer.init_config()
    -- vim.lsp.handlers['$/progress'] = on_progress
    bind.func(mode.NORMAL, "<leader>lq", user_stop_all_clients, nil)
    bind.func(mode.NORMAL, "<leader>la", user_attach_client, nil)
    bind.func(mode.NORMAL, "<leader>ll", list_clients, nil)

    -- bind.new(mode.INSERT, "<tab>", "<Plug>(completion_smart_tab)", {silent = true})
    -- bind.new(mode.INSERT, "<S-tab>", "<Plug>(completion_smart_s_tab)", {silent = true})
    autocmd.bind_complete_done(
        function()
            if vim.fn.pumvisible() == 0 then
                vim.cmd("pclose")
            end
        end
    )

    opt.set("completeopt", "menu,menuone,noinsert,noselect")
    var.set("completion_sorting", "alphabet")
    var.set("completion_matching_smart_case", true)

    -- Gotos for if lsp is activated
    bind.new(mode.NORMAL, "<leader>a", ":lua vim.lsp.buf.code_action()<CR>")
    bind.new(mode.NORMAL, "<leader>r", ":lua vim.lsp.buf.references()<CR>", { noremap = true })
    bind.new(mode.NORMAL, "<leader>rn", ":lua vim.lsp.buf.rename()<CR>", { noremap = true })
    bind.new(mode.NORMAL, "<leader>d", ":lua vim.lsp.buf.document_symbol()<CR>", { noremap = true })

    bind.buf_new(mode.NORMAL, "<leader>gd", ":lua vim.lsp.buf.definition()<CR>", { noremap = true })
    bind.buf_new(mode.NORMAL, "<leader>gi", ":lua vim.lsp.buf.implementation()<CR>", { noremap = true })
    bind.buf_new(mode.NORMAL, "<leader>K", ":lua vim.lsp.buf.hover()<CR>", { noremap = true })
    
    -- Autocompletion
    autocmd.bind_buf_enter(
        function()
            local completion = require("completion") -- From completion-nvim
            completion.on_attach()
        end
    )

end

--- Maps filetypes to their server definitions
--
-- <br>
-- Eg: `["rust"] = lspconfig.rls`
--
-- <br>
-- See `lspconfig` for what a server definition looks like




--- Register an LSP server
--
-- @param server An LSP server definition (in the format expected by `lspconfig`)
-- @param config The config for the server (in the format expected by `lspconfig`)
function layer.register_server(server, config)
  config = config or {}
  config = vim.tbl_extend("keep", config, server.document_config.default_config)

  -- We want to recieve progress messages
  config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, builtin_capabilities)

  server.setup(config)

  for _, v in pairs(config.filetypes) do
    layer.filetype_servers[v] = server
  end
end


--- Register an LSP server
--
-- @param server An LSP server definition 
-- @param launch_function The function to call to start the server 
-- @param config The config for the server (in the format expected by the server)\
function layer.register_custom_server(server, launch_function, config)
    config = config or {}
    -- We want to recieve progress messages
    config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, builtin_capabilities)
    xpcall(server[launch_function], function() end, config)
    for _, v in pairs(config.filetypes) do
      layer.filetype_servers[v] = server
    end
end


function layer.get_status()
    local clients = vim.lsp.buf_get_clients()
    local client_names = {}
    for _, v in pairs(clients) do
    table.insert(client_names, v.name)
    end

    if #client_names > 0 then
    local sections = { "LSP:", table.concat(client_names, ", ") }

    local error_count = vim.lsp.diagnostic.get_count(nil, "Error")
    if error_count ~= nil and error_count > 0 then table.insert(sections, "E: " .. error_count) end

    local warn_count = vim.lsp.diagnostic.get_count(nil, "Warning")
    if error_count ~= nil and warn_count > 0 then table.insert(sections, "W: " .. warn_count) end

    local info_count = vim.lsp.diagnostic.get_count(nil, "Information")
    if error_count ~= nil and info_count > 0 then table.insert(secuser_attach_clienttions, "I: " .. info_count) end

    local hint_count = vim.lsp.diagnostic.get_count(nil, "Hint")
    if error_count ~= nil and hint_count > 0 then table.insert(sections, "H: " .. hint_count) end

    return table.concat(sections, " ")
    else
    return ""
    end
end

return layer