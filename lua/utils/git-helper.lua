-- Helper function to run git command and open floating window
local function show_git_history(cmd)
    local result = vim.fn.systemlist(cmd)

    if vim.v.shell_error ~= 0 then
        vim.notify("Git command failed:\n" .. table.concat(result, "\n"), vim.log.levels.ERROR)
        return
    end

    -- Open floating window
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, result)

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local win_opts = {
        relative = "editor",
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2),
        style = "minimal",
        border = "rounded",
    }

    vim.api.nvim_open_win(buf, true, win_opts)
    vim.bo[buf].filetype = "git"  -- gives colored text
end

-- Command: GitLineHistory
vim.api.nvim_create_user_command("GitLineHistory", function()
    local curr_line_no = vim.fn.line('.')
    local filename = vim.fn.expand("%:t") -- filename only, e.g. main.cpp

    if filename == "" then
        vim.notify("No file name — save the buffer first.", vim.log.levels.ERROR)
        return
    end

    -- Build the git command to show the history of the current line
    local file_dir = vim.fn.expand("%:p:h") -- Directory of the current file
    local cmd = { "git", "-C", file_dir, "log", "-L", string.format("%d,+1:%s", curr_line_no, filename) }
    show_git_history(cmd)
end, { desc = "Show git log history for the current line" })

-- Command: GitFileHistory
vim.api.nvim_create_user_command("GitFileHistory", function()
    local filename = vim.fn.expand("%:t")

    if filename == "" then
        vim.notify("No file name — save the buffer first.", vim.log.levels.ERROR)
        return
    end

    -- Build the git command to show the history of the current file
    local file_dir = vim.fn.expand("%:p:h")
    local cmd = { "git", "-C", file_dir, "log", "--pretty=format:%h : %s [%an]", "--", filename }
    show_git_history(cmd)
end, { desc = "Show git log history for the current file" })
