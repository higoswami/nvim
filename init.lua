require("options")
require("autocmds")
require("usercmds")
require("ctags-symbols")

-- =================================== KEYMAPS ===================================
-- Note: Keep your keymaps at end if you want to override the plugins mappings
local opts = { noremap = true, silent = true }
-- silent=true won't show commands mapped to keybindings

--Remap space as leader key
vim.g.mapleader = vim.keycode("<space>")
vim.keymap.set("n", "gs", ":tag <C-R><C-W><CR>", { noremap = true, silent = false, desc = "Show symbol under cursor" })

-- Keep selection after indenting in visual mode
vim.keymap.set("x", "<", "<gv", opts)
vim.keymap.set("x", ">", ">gv", opts)

-- Center screen when page_up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)


-- Plugins need leader key, hence set it beforehand
require("plugins")
require("colorscheme")

-- If you want to override the plugin keymaps add those keymaps after that plugin is loaded
vim.keymap.set("n", "<leader>ct", ":lua ShowFileSymbols()<CR>", opts)

