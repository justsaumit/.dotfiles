local options = {
    number=true,			-- Shows absolute linenumber
    relativenumber=true,		-- Shows linenumber relative to cursor
    					--combination of both^ for hybrid linenumber
    showbreak="+++",			-- wrap broken line prefix
    textwidth=100,
    numberwidth=4,
    scrolloff=8,			-- keeps cursor in middle of screen/scrolls 8lines in advance
    mouse="a",                          -- enable mouse support
    splitbelow=true,
    splitright=true,
    clipboard="unnamedplus",		-- allows neovim to access system clipboard
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
    --git integration/lsp
    --signcolumn=true,
    --undo/backup
    backup=false,
    swapfile=false,
    undodir=os.getenv("HOME") .. "/.config/nvim/undodir",
    undofile=true
}
--forloop for table 'options'
for key, value in pairs(options)  do
    vim.opt[key] = value
end

--to 'cw/'dw' a word containing '-' in between
vim.cmd [[set iskeyword+=-]]
