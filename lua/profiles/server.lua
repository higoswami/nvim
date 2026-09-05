-- This contains all the other things that you need to call other than core
-- for my server profile

-- ========================== Plugins ====================
-- Plugins are downloaded at : /home/$USER/.local/share/nvim/site/pack/core/opt
vim.pack.add({
    {src = "https://github.com/scottmckendry/cyberdream.nvim.git"},
    {src = "https://github.com/folke/which-key.nvim.git"},
    {src = "https://github.com/folke/flash.nvim.git"},
    {src = "https://github.com/nvim-mini/mini.files.git"},
    {src = "https://github.com/nvim-mini/mini.pick.git"},
    {src = "https://github.com/lewis6991/gitsigns.nvim.git"},
    {src = "https://github.com/lukas-reineke/indent-blankline.nvim.git"},
})

-- +++++++ Load and Configure the Plugin  ++++++++++++++++++++++++++++ 
-- When you use setup(), you may override the defaults based on how setup() is written in Plugin

-- ==== flash.nvim ====
require("plugins.flash")

-- ===== gitsigns.nvim =========
require("plugins.gitsigns")

-- ==== mini.files ====
require("plugins.mini-files")

-- ==== mini.pick ====
require("plugins.mini-pick")

-- ==== indent-blankline.nvim ====
require("plugins.indent-blankline")


-- ============================= Utilities ============================
require("utils.float-terminal")
require("utils.clipboard-osc52")
