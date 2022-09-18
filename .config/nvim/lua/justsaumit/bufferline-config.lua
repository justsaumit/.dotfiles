--vim.opt.termguicolors = true

local status, bufferline = pcall(require, "bufferline")
if not status then
  return
end

require('bufferline').setup {
     options = {
            mode = "buffers",
            numbers = "none",
            close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
            right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
            left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
            middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
            indicator = {
                icon = '▎', 
                style = 'icon',
            },
            buffer_close_icon = '',
            modified_icon = '●',
            close_icon = '',
            -- close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',
            max_name_length = 30,
            max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
            tab_size = 22,
            diagnostics = false,
            diagnostics_update_in_insert = false,
            offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
            color_icons = true,
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            persist_buffer_sort = true,
            separator_style = "thin", -- | "thick" | "thin" | slant,
            enforce_regular_tabs = true,
            always_show_bufferline = true,
            name_formatter = function(buf)  -- buf contains a "name", "path" and "bufnr"
                -- remove extension from markdown files for example
                if buf.name:match('%.md') then
                    return vim.fn.fnamemodify(buf.name, ':t:r')
                end
            end
        }
}

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Leader+number -> tab change
for i = 1, 9 do
  keymap("n", "<leader>" .. i, function()
    require("bufferline").go_to_buffer(i, true)
  end, opts)
end

--Ctrl+W to close a buffer
keymap("n", "W", ":bdelete!<CR>", opts)


--Tab or Ctrl+Tab for Forward Cycle  //terminals don't see a difference between <Tab> and <C-Tab>
--Shift+Tab for Backward Cycle
keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)

