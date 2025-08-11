-- =================================== KEYMAPS ===================================
-- Note: If you want to override the plugins mappings, then put those keymaps in init.lua after require("plugins")

--Remap space as leader key
vim.g.mapleader = vim.keycode("<space>")

local opts = { noremap = true, silent = true }
-- silent=true won't show commands mapped to keybindings

vim.keymap.set("n", "gs", ":tag <C-R><C-W><CR>", { noremap = true, silent = false, desc = "Show symbol under cursor" })

-- Keep selection after indenting in visual mode
vim.keymap.set("x", "<", "<gv", opts)
vim.keymap.set("x", ">", ">gv", opts)

-- Center screen when page_up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

