local function OnLineEnter()
    local symbols = vim.b.buffer_symbols
    if not symbols then
        vim.api.nvim_echo({{"Symbol list is not available in this buffer", "ErrorMsg"}}, false, {})
        return
    end

    local index = vim.fn.line(".")
    -- local index = line_num - 1  -- Lua is 1-indexed, so no need for -1

    if index <= 0 or index > #symbols then
        vim.api.nvim_echo({{"Invalid number", "ErrorMsg"}}, false, {})
        return
    end

    -- Close the symbol buffer
    vim.cmd.q() -- :q

    -- Jump to the symbol using tag
    vim.cmd.tag(symbols[index]) -- :tag symbol_name
end

function ShowFileSymbols()
    local curr_file = vim.fn.shellescape(vim.fn.expand("%:p"))
    local cmd = "ctags -x --sort=no " .. curr_file
    local cmd_output = vim.fn.system(cmd)

    if cmd_output == "" then
        vim.api.nvim_echo({{"No symbols found", "ErrorMsg"}}, false, {})
        return
    end

    local lines = vim.split(cmd_output, "\n")
    local symbol_names = {}
    local display_lines = {}

    for _, line in ipairs(lines) do
        local cols = vim.split(line, "%s+")
        if #cols >= 2 then
            table.insert(symbol_names, cols[1])
            table.insert(display_lines, string.format("%-40s : %15s", cols[1], cols[2]))
        end
    end

    if #display_lines == 0 then
        vim.api.nvim_echo({{"No valid symbols parsed", "ErrorMsg"}}, false, {})
        return
    end

    -- Open vertical split
    local width = math.floor(vim.api.nvim_win_get_width(0) / 3)
    vim.cmd.vnew() -- :vnew
    vim.cmd("vertical resize " .. width)

    -- Set buffer-local options
    vim.bo.buftype = "nofile"
    vim.bo.swapfile = false
    vim.bo.filetype = "symbols"
    vim.bo.bufhidden = "wipe"
    vim.bo.modifiable = true
    -- vim.bo.number = false

    -- Set lines
    vim.api.nvim_buf_set_lines(0, 0, -1, false, display_lines)
    -- First argument is buf_num, 0 means current buffer
    vim.bo.modifiable = false

    -- Store symbols in buffer variable
    vim.b.buffer_symbols = symbol_names

    -- Bind <CR> to symbol jump
    vim.keymap.set("n", "<CR>", function()
        OnLineEnter()
    end, { buffer = buf, silent = true })
end
