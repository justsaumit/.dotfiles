local wk = require("which-key")
local mappings = {
    q = {":q<CR>", "Quit"},
    Z = {":wq<CR>", "Save and Quit"},
    w = {":w<CR>", "Save"},
    x ={":bdelete<CR>", "Close"}
}
local opts = {prefix = '<leader>'}
wk.register(mappings, opts)
