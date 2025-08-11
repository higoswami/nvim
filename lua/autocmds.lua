local user_group = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight on yank Autocmd --
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = user_group,
})

-- This disables automatic comments in all filetypes
-- r: Comment on Enter, o : using o or Shift O to insert line , c: Autowrap comments using textwidth
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
    group = user_group,
    desc = "Disable New Line Comment",
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')   -- " is the last cursor position mark in vim/neovim
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
    group = user_group,
})

-- Change Indentation based on fileType
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "typescript", "json", "html", "css" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
    group = user_group,
})

