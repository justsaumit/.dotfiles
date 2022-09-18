local wk = require("which-key")
local mappings = {
    q = {":q<CR>", "Quit"},
    Z = {":wq<CR>", "Save and Quit"},
    w = {":w<CR>", "Save"},
    x ={":bdelete<CR>", "Close"},
    f = { ":Telescope find_files<cr>", "Telescope Find Files" },
    g = { ":Telescope live_grep<cr>", "Telescope Live Grep" }
}
local opts = {prefix = '<leader>'}
wk.register(mappings, opts)
