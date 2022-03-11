local opt = require("utils.opt")
local var = require("utils.var")
local plug = require("utils.plug")


local status_line = {}



local function theme() 
    local colors = vim.fn['sonokai#get_palette'](var.get("sonokai_style"))
    return {
        normal = {
                a = {fg = colors.black[1],  bg = colors.green[1]},
                b = {fg = colors.black[1], bg = colors.purple[1]},
                c = {fg = colors.fg[1], bg = colors.bg1[1]}
          },
          insert = {a = {fg = colors.black[1], bg = colors.green[1]}},
          visual = {a = {fg = colors.black[1], bg = colors.yellow[1]}},
          replace = {a = {fg = colors.black[1], bg = colors.red[1]}},
          inactive = {
                a = {fg = colors.purple[1], bg = colors.black[1]},
                b = {fg = colors.fg[1], bg = colors.purple[1]},
                c = {fg = colors.grey[1], bg = colors.black[1]}
          }
    }
end


function status_line.register_plugins()
    plug.add_plugin('hoob3rt/lualine.nvim')
end


function status_line.init_config()
    local lsp = require("layers.lsp")

    local lualinetheme = theme()
    require'lualine'.setup {
        options = {
          icons_enabled = true,
          theme = lualinetheme,
          component_separators = {'', ''},
          section_separators = {'', ''},
          disabled_filetypes = {}
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', require'lsp-status'.status},
          lualine_c = {'filename', 'diagnostics'},
          lualine_x = {'encoding', 'filetype'},
          lualine_y = {},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
    }
end




return status_line