-- ==== vim-easy-align ====
-- This is a pure Vimscript plugin => you can't use pcall for checking if it exists
vim.g.easy_align_delimiters = {
    -- Add (|) as align delimeter for C header files
    [")"] = {
        pattern = "[()]",
        left_margin = 0,
        right_margin = 0,
        stick_to_left = 0,
    },
}

-- Visual mode: select lines and press ga to start EasyAlign
vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', {silent = true}) -- group align the selected lines
