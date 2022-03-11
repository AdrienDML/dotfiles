local layer_man = require("layers.editor.layer_man")
local plug = require("utils.plug")
local bind = require("utils.bind")
local mode = require("utils.mode")
local cmd = require("utils.cmd")
local opt = require("utils.opt")
local var= require("utils.var")

local layer = {}

function layer.register_plugins()
    -- fzf for searching things
    plug.add_plugin("junegunn/fzf")
    plug.add_plugin("junegunn/fzf.vim")
end

--- All the varibles
local function set_vars() 
    var.set_leader(" ")
    var.set_local_leader("\\")
    
    -- I'm not a grandpa yet thx
    var.set("timeoutlen", 100)
end

--- All the options
local function set_options()
    opt.bset("undofile", true)
    
    -- The mouse is nice sometimes
    opt.set("mouse", 'a')

    -- Default indentation rules
    opt.bset("tabstop", 4)
    opt.bset("softtabstop", 4)
    opt.bset("shiftwidth", 4)
    opt.bset("expandtab", true) -- Use spaces instead of tabs
    opt.bset("autoindent", true)
    opt.bset("smartindent", true)

    -- Nicer Search
    opt.set("incsearch", true)
    opt.set("ignorecase", true)
    opt.set("smartcase", true)
    opt.set("gdefault", true)

    -- Relative line Numbers
    opt.wset("number", true)
    opt.wset("relativenumber", true)
end

--- All my default keybindings
local function create_bindings()
        -- H/L to jump to the start/end of a line
        bind.new(mode.NORMAL, "H", "^", { noremap = true })
        bind.new(mode.VISUAL_SELECT, "H", "^", { noremap = true })
        bind.new(mode.NORMAL, "L", "$", { noremap = true })
        bind.new(mode.VISUAL_SELECT, "L", "$", { noremap = true })
    
        -- Remaps for my keyboard layout (workman-p)
        -- also move cursor in the column
        bind.new(mode.NORMAL, "t", "gk", { noremap = true })
        bind.new(mode.VISUAL_SELECT, "t", "gk", { noremap = true })
        bind.new(mode.NORMAL, "k", "gj", { noremap = true })
        bind.new(mode.VISUAL_SELECT, "k", "gj", { noremap = true })
    
        bind.new(mode.NORMAL, "<leader>so", ":so ~/.config/nvim/init.lua", { noremap = true })
    
        bind.new(mode.NORMAL, "<leader>b", ":Buffers<CR>", { noremap = true })
        bind.new(mode.NORMAL, "<leader>f", ":Files<CR>", { noremap = true })
        bind.new(mode.NORMAL, "<leader>fg", ":GFiles<CR>", { noremap = true })
    
        -- Buffer operations
        bind.new(mode.NORMAL, "<leader><leader>", "<C-^>", { noremap = true })
        bind.new(mode.NORMAL, "<leader>q", ":bd<CR>", { noremap = true })
        bind.new(mode.NORMAL, "<leader>w", ":w<CR>", { noremap = true })
        bind.new(mode.NORMAL, "<leader>bp", ":bp<CR>", { noremap = true })
        bind.new(mode.NORMAL, "<leader>bn", ":bn<CR>", { noremap = true })
        bind.new(mode.NORMAL, "<Left>", ":bp<CR>", {noremap = true})
        bind.new(mode.NORMAL, "<Right>", ":bn<CR>", {noremap = true})
    
        -- Manage splits
        bind.new(mode.NORMAL, "<leader>sv", ":vsplit<CR>", { noremap = true })
        bind.new(mode.NORMAL, "<leader>sh", ":split<CR>", { noremap = true })
        bind.new(mode.NORMAL, "<leader>sq", ":q<CR>", { noremap = true })
        -- Resize splits
        bind.new(mode.NORMAL, "<leader>srv+", ":vertical resize +1<CR>", { noremap = true })
        bind.new(mode.NORMAL, "<leader>srh+", ":resize +1<CR>", { noremap = true })
        bind.new(mode.NORMAL, "<leader>srv-", ":vertical resize -1<CR>", { noremap = true })
        bind.new(mode.NORMAL, "<leader>srh-", ":resize -1<CR>", { noremap = true })
    
    
        -- Nice feature to have for blocks languages
        bind.new(mode.INSERT, "{<CR>", "{<CR>}<ESC>O", { noremap = true })
        bind.new(mode.INSERT, "[<CR>", "[<CR>]<ESC>O", { noremap = true })
        bind.new(mode.INSERT, "(<CR>", "(<CR>)<ESC>O", { noremap = true })
    
        -- Magic
        bind.new(mode.NORMAL, "/", "/\v", { noremap = true })
        bind.new(mode.NORMAL, "?", "?\v", { noremap = true })
    
    
        -- Moving lines of text
        -- Insert mode with the ctrl key
        bind.new(mode.INSERT, "<C-k>", "<ESC>:m .+1<CR>==", { noremap = true })
        bind.new(mode.INSERT, "<C-t>", "<ESC>:m .-2<CR>==", { noremap = true })
        -- Normal mode with the leader key
        bind.new(mode.NORMAL, "<C-k>", ":m .+1<CR>==", { noremap = true })
        bind.new(mode.NORMAL, "<C-t>", ":m .-2<CR>==", { noremap = true })
        -- In visual mode with maj key
        bind.new(mode.VISUAL_SELECT, "<C-k>", "'>+1<CR>gv=gv", { noremap = true })
        bind.new(mode.VISUAL_SELECT, "<C-t>", "'<-2<CR>gv=gv", { noremap = true })
    
    
        -- Nice clipboard integration
        bind.new(mode.NORMAL, "<leader>y", "\"+y", { noremap = true })
        bind.new(mode.VISUAL_SELECT, "<leader>y", "\"+y", { noremap = true })
        bind.new(mode.NORMAL, "<leader>p", "\"+p", { noremap = true })

end

function layer.init_config()
    set_vars() 
    set_options()
    create_bindings()

    -- Init commands for editing layer config files
    layer_man.init_config()
end
return layer
