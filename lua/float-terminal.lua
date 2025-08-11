local terminal_state = {
    -- Invalid Initial states
    buf = -1,
    win = -1,
}

local function create_floating_window(opts)
    opts = opts or {}
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- listed : false, scratch: true
    end

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)

    -- Where should the top left corner of window be
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2);

    -- With relative=editor (row=0,col=0) refers to the top-left corner of the screen-grid 

    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        border = "rounded",
    }
    local win = vim.api.nvim_open_win(buf, true, win_config)
    return {buf = buf, win = win}
end

local toggle_terminal = function()
    if vim.api.nvim_win_is_valid(terminal_state.win) then
        vim.api.nvim_win_hide(terminal_state.win)
        return
    end

    terminal_state = create_floating_window( { buf = terminal_state.buf } )
    -- Call terminal in that buffer
    if vim.bo[terminal_state.buf].buftype ~= "terminal" then
        vim.cmd.terminal()
    end
end

-- vim.api.nvim_create_user_command( "Hterm", toggle_terminal , {})
vim.keymap.set('t', '<C-=>', '<C-\\><C-n>', { noremap = true, silent = true }) -- Use Ctrl =
vim.keymap.set("n", "<leader>tt", toggle_terminal, { noremap = true, silent = false })

