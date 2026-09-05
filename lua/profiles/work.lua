-- ===================== Options ====================
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard

-- ========================== Plugins ====================
-- Plugins are downloaded at : /home/$USER/.local/share/nvim/site/pack/core/opt
vim.pack.add({
    {src = "https://github.com/scottmckendry/cyberdream.nvim.git"},
    {src = "https://github.com/folke/which-key.nvim.git"},
    {src = "https://github.com/folke/flash.nvim.git"},
    {src = "https://github.com/nvim-mini/mini.files.git"},
    {src = "https://github.com/nvim-mini/mini.pick.git"},
    {src = "https://github.com/lewis6991/gitsigns.nvim.git"},
    {src = "https://github.com/dhananjaylatkar/cscope_maps.nvim.git", version = "main"},
    {src = "https://github.com/nvim-treesitter/nvim-treesitter.git", version = "main"}, -- All future updates will be on main branch (for nvim v0.12 and later)
    {src = "https://github.com/nvim-treesitter/nvim-treesitter-context.git"},
    {src = "https://github.com/junegunn/vim-easy-align.git"},
    {src = "https://github.com/lukas-reineke/indent-blankline.nvim.git"},
    {src = "https://github.com/danymat/neogen.git"},
})

-- Notes:
-- In Lua, require() is cached, so even if you call it multiple times (in the same Neovim session), it won’t reload or run the module again.

-- ++++++++++++++++++ Load and Configure the Plugin  ++++++++++++++++++++++++++++ 
-- When you use setup(), you may override the defaults based on how setup() is written in Plugin


-- ==== cscope_maps.nvim ====
require("plugins.cscope-maps")

-- ==== flash.nvim ====
require("plugins.flash")

-- ===== gitsigns.nvim =========
require("plugins.gitsigns")

-- ==== mini.files ====
require("plugins.mini-files")

-- ==== mini.pick ====
require("plugins.mini-pick")

-- ==== Treesitter =====
require("plugins.nvim-treesitter")

-- ==== Treesitter-context ====
require("treesitter-context")  -- Not from plugins directory

-- ==== vim-easy-align ====
require("plugins.vim-easy-align")

-- ==== indent-blankline.nvim ====
require("plugins.indent-blankline")

-- ==== neogen ====
require("plugins.neogen")


-- ============================= Utilities ============================
require("utils.float-terminal")
require("utils.ctags-symbols")
require("utils.git-helper")


-- If you want to override the plugin keymaps add those keymaps after that plugin is loaded
vim.keymap.set("n", "<leader>ct", ":lua ShowFileSymbols()<CR>", { noremap = true, silent = true, desc = "Show ctags symbols for current file" })
