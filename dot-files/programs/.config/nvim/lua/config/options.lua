-- ==================================================
-- TITLE: options
-- ABOUT: basic settings native to nvim
-- ==================================================

-- Basic Settings
vim.opt.number = true -- line nums
vim.opt.relativenumber = true -- relative line nums
vim.opt.cursorline = true  -- highlight current line
vim.opt.scrolloff = 20 -- keep 15 lines above and below cusor
vim.opt.sidescrolloff = 10 -- keep 10 columns left/right of cursor
vim.opt.wrap = false -- do not wrap lines
vim.opt.cmdheight = 1 -- command line height
vim.opt.spelllang = { "en", "de" } -- set language for spellchecking


-- tabbing and indentation
vim.opt.tabstop = 4 -- tab width
vim.opt.shiftwidth = 4 -- indent width
vim.opt.softtabstop = 4 -- soft tab sop
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.smartindent = true -- smart auto-indenting
vim.opt.autoindent = true -- copy indent from current line
vim.opt.grepprg = "rg --vimgrep" -- use ripgrep if available
vim.opt.grepformat = "%f:%1:%c:%m" -- filename, line number, column, content

-- search settings
vim.opt.ignorecase = true -- case-insensitive search
vim.opt.smartcase = true -- case-sensitive if uppercase in search
vim.opt.hlsearch = false -- do not highlight searc results
vim.opt.incsearch = true -- show matches as u type

-- visual settings
vim.opt.termguicolors = true -- enavle 24-bit colors
vim.opt.signcolumn = "yes" -- always show sign column
vim.opt.colorcolumn = "120" -- show column at 120 characters
vim.opt.showmatch = true -- highlight matching brackets
vim.opt.matchtime = 2 -- how long to show matching bracket
vim.opt.completeopt = "menuone,noinsert,noselect" -- completion options
vim.opt.showmode = false -- do not show mode in command line
vim.opt.pumheight = 10 -- popup menu height
vim.opt.pumblend = 10 -- popup menu transparency
vim.opt.winblend = 0 -- floating window transparency
vim.opt.conceallevel = 0 -- do not hide markup
vim.opt.lazyredraw = false -- redraw while executing macros
vim.opt.redrawtime = 10000 -- timeout for syntax highlight redraw
vim.opt.maxmempattern = 20000 -- max memory for pattern matching
vim.opt.synmaxcol = 300 -- syntax highlighting column limit

-- file handling 
vim.opt.backup = false -- do not create backup files
vim.opt.writebackup = false -- do not backup before overwriting
vim.opt.swapfile = false -- do not create swap files
vim.opt.undofile = true -- persistent undo
vim.opt.updatetime = 300 -- time in ms to trigger cursorhold
vim.opt.timeoutlen = 500 -- time in ms to wait for mapped sequence
vim.opt.ttimeoutlen = 0 -- no wait for key code sequences
vim.opt.autoread = true -- auto-reload file if changed outside
vim.opt.autowrite = false -- do not auto-save on some events
vim.opt.diffopt:append("vertical") -- vertical diff splits
vim.opt.diffopt:append("algorithm:patience") -- bettter diff algorithm
vim.opt.diffopt:append("linematch:60") -- better diff highlighting (smart line matching)

-- set undo directory and ensure it exists
local undodir = "~/.local/share/nvim/undodir" -- undo directory path
vim.opt.undodir = vim.fn.expand(undodir) -- expand to full path
local undodir_path = vim.fn.expand(undodir)
if vim.fn.isdirectory(undodir_path) == 0 then
    vim.fn.mkdir(undodir_path, "p") -- create if not exist
end

-- behavior settings
vim.opt.errorbells = false -- disable error sounds
vim.opt.backspace = "indent,eol,start" -- make backspace behave naturally
vim.opt.autochdir = false -- do not change directory automatically
-- vim.opt.iskeyword:append("-") -- treat dash as part of a word
vim.opt.path:append("**") -- search into subfolders with gf
vim.opt.selection = "inclusive" -- use inclusive select
vim.opt.mouse = "a" -- enable mouse support
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
vim.opt.modifiable = true -- allow editing buffers
vim.opt.encoding = "UTF-8" -- use utf 8 encoding
vim.opt.wildmenu = true -- enable comand-line completion menu
vim.opt.wildmode = "longest:full,full" -- completion mode for command line
vim.opt.wildignorecase = true -- case-insensitive tab completion in commands


-- folding settings
vim.opt.foldmethod = "expr" -- use expression for folding
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- use treesitter for folding
vim.opt.foldlevel = 99 -- keep all folds open by default

-- splie behavior
vim.opt.splitbelow = true -- horizontal splits open below
vim.opt.splitright = true -- vertical splits open to the right

