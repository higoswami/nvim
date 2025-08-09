local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight on yank Autocmd --
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = augroup,
})

-- This disables automatic comments in all filetypes
-- r: Comment on Enter, o : using o or Shift O to insert line , c: Autowrap comments using textwidth
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
    group = augroup,
    desc = "Disable New Line Comment",
})

