-- ==== mini.pick ====
local ok, mini_pick = pcall(require, "mini.pick")
if ok then
    mini_pick.setup()

    -- mini_pick = require("mini.pick") from pcall(..) so no need to rewrite it
    vim.keymap.set("n", "<leader>sb", function() mini_pick.builtin.buffers() end, { noremap = true, desc = "Search Buffers" })
    vim.keymap.set("n", "<leader>sf", function() mini_pick.builtin.files({ tool = "fd" }) end, { noremap = true, desc = "Search Files" }) -- Use fd for file picker
end
