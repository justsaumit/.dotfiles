--configuration needs to be set BEFORE loading the color scheme with colorscheme tokyonight
vim.g.tokyonight_style = "night"
tokyonight_terminal_colors=true
tokyonight_italic_comments=true
tokyonight_italic_keywords=true
tokyonight_italic_functions=false
tokyonight_italic_variables=false
tokyonight_transparent=false
tokyonight_hide_inactive_statusline=false
tokyonight_sidebars={}
tokyonight_transparent_sidebar=false
tokyonight_dark_sidebar=true
tokyonight_dark_float=true
tokyonight_colors={}
tokyonight_lualine_bold=false

--protected call
local colorscheme = "tokyonight"
local pywal = require('pywal')

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found! :(")
    pywal.setup()
    return
end

-- init.lua
vim.g.tokyodark_transparent_background = false
vim.g.tokyodark_enable_italic_comment = true
vim.g.tokyodark_enable_italic = true
vim.g.tokyodark_color_gamma = "1.0"
vim.cmd("colorscheme tokyodark")
