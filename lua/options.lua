-- vim.o can also used instead of vim.opt
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard

vim.opt.wrap = false                            -- display lines as one long line
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = true                   -- set relative numbered lines
vim.opt.cursorline = true                       -- highlight the current line

vim.opt.tabstop = 4                             -- insert 4 spaces for a tab
vim.opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.smartindent = false                     -- this causes indentation in files that shouldn't have indentation like in .txt

-- =============== Search =============
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.smartcase = true                        -- smart case

-- ============== Better Split ===========
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window


-- ============ File Handling =================
vim.opt.backup = false                          -- creates a backup file (this is not used for undo)
vim.opt.undofile = true                         -- enable persistent undo
-- Do i need to set vim.opt.undodir ? 
--      No, It is set by default, check your already set location using :=vim.o.undodir (I prefer default location)

-- ============== Behaviour ===================
vim.opt.hidden = true                           -- Allows buffers to be hidden (default = true)
vim.opt.autochdir = false                       -- Change vim directory on change file, buffer, window (default = false)
vim.opt.path:append("**")                       -- include subdirectories in file search (affects :find)

vim.opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.mouse = ""                              -- Don't allow the mouse to be used in any mode, you'll still be able to scroll
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8

-- ================= UI ===============
vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
vim.opt.showmode = true                         -- we don't need to see things like -- INSERT -- anymore (set to false)
vim.opt.showtabline = 1                         -- (1: show only when there are atleast 2 tabs)
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
-- vim.opt.colorcolumn = "120"                     -- Show column at <value> character (Useful to limit the width of code)
-- vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.list = true                             -- Enable special characters
vim.opt.listchars = {
    -- space = '·',                                 -- Display spaces as middle dots
    tab = '▶ ',                                 -- Display tabs as a right-pointing triangle followed by a space
    eol = '↲',                                  -- Display end-of-line characters as a return arrow
    trail = '-',                                -- Display trailing spaces as middle dots
    nbsp = '␣'
}
