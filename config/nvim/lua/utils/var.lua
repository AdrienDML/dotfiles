

local var = {}

function var.set_leader(key) 
    vim.g.mapleader = key
end


function var.set_local_leader(key)
    vim.g.maplocalleader = key
end

function var.set(variable, value)
    vim.g[variable] = value
end
function var.get(variable)
    return vim.g[variable]
end

function var.set_buffer(variable, value)
    vim.b[variable] = value
end
function var.get_buffer(variable)
    return vim.b[variable]
end

function var.set_widow(varible, value)
    vim.w[varible] = value
end


function var.get_widow(varible, value)
    return vim.w[varible]
end


return var