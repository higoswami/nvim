-- =================================== KEYMAPS ===================================
-- Note: If you want to override the plugins mappings, then put those keymaps in init.lua after require("plugins")

--Remap space as leader key
vim.g.mapleader = vim.keycode("<space>")

local opts = { noremap = true, silent = true }
-- silent=true won't show commands mapped to keybindings

-- tjump will show the tags list (if there are multiple tags with the same name), while :tag jumps to the first matching tag
vim.keymap.set("n", "gs", ":tjump <C-R><C-W><CR>", { noremap = true, silent = false, desc = "Show symbol under cursor" })

-- Keep selection after indenting in visual mode
vim.keymap.set("x", "<", "<gv", opts)
vim.keymap.set("x", ">", ">gv", opts)

-- Center screen when page_up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- By default vim yanks the text over which we paste
vim.keymap.set("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

