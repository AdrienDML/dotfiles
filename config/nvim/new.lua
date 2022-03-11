local plug = require("utils.plug")

local PLUG_DIR = "~/.local/share/nvim/plugged"

function register_pulgins()
    -- fzf for searching things
    plug.add_plugin("junegunn/fzf")
    plug.add_plugin("junegunn/fzf.vim")
end

function set_options() 
    vim.opt.undofile=true
    vim.opt.mouse='a'
    vim.opt.tabstop=4
    vim.opt.shiftwidth=4
    vim.opt.expandtab=true
    vim.opt.autoindent=true
    vim.opt.smartindent=true
    vim.opt.incsearch=true
    vim.opt.ignorecase=true
    vim.opt.smartcase=true
    vim.opt.gdefault=true
    vim.opt.number=true
    vim.opt.relativenumber=true
end
      
 function bindings()
        -- H/L to jump to the start/end of a line
        vim.keymap.set("n", "H", "^", { noremap = true })
        vim.keymap.set("v", "H", "^", { noremap = true })
        vim.keymap.set("n", "L", "$", { noremap = true })
        vim.keymap.set("v", "L", "$", { noremap = true })
    
        -- Remaps for my keyboard layout (workman-p)
        -- also move cursor in the column
        vim.keymap.set("n", "t", "gk", { noremap = true })
        vim.keymap.set("v", "t", "gk", { noremap = true })
        vim.keymap.set("n", "k", "gj", { noremap = true })
        vim.keymap.set("v", "k", "gj", { noremap = true })
    
        vim.keymap.set("n", "<leader>so", ":so ~/.config/nvim/init.lua", { noremap = true })
    
        vim.keymap.set("n", "<leader>b", ":Buffers<CR>", { noremap = true })
        vim.keymap.set("n", "<leader>f", ":Files<CR>", { noremap = true })
        vim.keymap.set("n", "<leader>fg", ":GFiles<CR>", { noremap = true })
    
        -- Buffer operations
        vim.keymap.set("n", "<leader><leader>", "<C-^>", { noremap = true })
        vim.keymap.set("n", "<leader>q", ":bd<CR>", { noremap = true })
        vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true })
        vim.keymap.set("n", "<leader>bp", ":bp<CR>", { noremap = true })
        vim.keymap.set("n", "<leader>bn", ":bn<CR>", { noremap = true })
        vim.keymap.set("n", "<Left>", ":bp<CR>", {noremap = true})
        vim.keymap.set("n", "<Right>", ":bn<CR>", {noremap = true})
    
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
 
