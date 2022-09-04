--protected call
local colorscheme = "tokyonight"
local pywal = require('pywal')

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found! :(")
    pywal.setup()
    return
end

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
