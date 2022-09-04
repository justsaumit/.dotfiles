local options = {
    number=true,			-- Shows absolute linenumber
    relativenumber=true,		-- Shows linenumber relative to cursor
    					--combination of both^ for hybrid linenumber
    textwidth=100,
    numberwidth=4,
    scrolloff=8,			-- keeps cursor in middle of screen/scrolls 8lines in advance
    sidescroll=18,
    mouse="a",                          -- enable mouse support
    splitbelow=true,                    -- on horizontal split instead of opening window to left open it at right
    splitright=true,                    -- on vertical split instead of opening window to left open it at right
    termguicolors=true,
    showmode=false,                     -- lualine does the job
    cmdheight=1,
    wrap=false,
    whichwrap='b,s,<,>,[,],h,l',
    clipboard="unnamedplus",		-- allows neovim to access system clipboard using yank
    fileencoding="UTF-8",
    --spaces/tabs/indents
    softtabstop=4,			-- No. of spaces per tab
    shiftwidth=4,			-- No. of auto-indent space
    expandtab=true,			-- spaces inplace of tabs
    autoindent=true,			-- New line copies indentation from past line
    smartindent=true,			-- Indents in accordance to the syntax/style of the code extension
    --searches
    ignorecase=true,			-- Ignore case-sensitivity during search
    smartcase=true,			-- If searching capital search only capital
    hlsearch=false,			-- no perma highlight post search
    incsearch=true,			-- searches for strings incrementally
    showmatch=true,                     -- Highlight matching braces
    --git integration/lsp/diagnostic
    signcolumn="yes",
    --undo/backup
    backup=false,
    swapfile=false,
    undodir=os.getenv("HOME") .. "/.local/state/nvim/undodir",
    undofile=true
--    showbreak="+++",			-- wrap broken line prefix
}
--forloop for table 'options'
for key, value in pairs(options)  do
    vim.opt[key] = value
end

--to 'cw/'dw' a word containing '-' in between
vim.cmd [[set iskeyword+=-]]
