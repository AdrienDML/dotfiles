
opt = {}

local autocmd = require("utils.autocmd")

function opt.register_plugins()
end

function opt.set(option, value)
	local val = value or true
	vim.o[option] = value
end

function opt.get(option)
	return vim.o[option]
end


function opt.bset(option, value)
	local val = value or true
	opt.set(option, value)
	autocmd.bind_vim_enter(function ()
		vim.bo[option] = value
	end)
end

function opt.bget(option)
	return vim.bo[option]
end

function opt.wset(option, value)
	local val = value or true
	opt.set(option, value)
	autocmd.bind_vim_enter(function ()
		vim.wo[option] = value
	end)
end

function opt.wget(option)
	return vim.wo[option]
end

return opt
