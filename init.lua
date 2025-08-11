require("options")
require("keymaps")
require("autocmds")
require("usercmds")
require("ctags-symbols")

-- Plugins need leader key, hence set it beforehand
require("plugins")
require("colorscheme")

-- If you want to override the plugin keymaps add those keymaps after that plugin is loaded
vim.keymap.set("n", "<leader>ct", ":lua ShowFileSymbols()<CR>", opts)

