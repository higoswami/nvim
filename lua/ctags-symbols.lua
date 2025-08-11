-- Reuse the buffer instead of creating a new one each time
local ctags_buffer = nil
local ctags_window = nil

local function OnLineEnter(buffer_symbols, parent_window)
    local symbols = buffer_symbols
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

    -- No need to close we'll jump to parent window
    -- vim.cmd.q() -- :q

    vim.api.nvim_set_current_win(parent_window)

    -- Jump to the symbol using tag
    vim.cmd.tag(symbols[index]) -- :tag symbol_name
end

function ShowFileSymbols()
    local curr_file = vim.fn.shellescape(vim.fn.expand("%:p"))
    local cmd = "ctags -x --c-kinds=fst --sort=no " .. curr_file -- f: function, s: struct, t: typedef
    local cmd_output = vim.fn.system(cmd)

    if cmd_output == "" then
        vim.api.nvim_echo({{"No symbols found", "ErrorMsg"}}, false, {})
        return
    end

    local lines = vim.split(cmd_output, "\n")
    local symbol_names = {}
    local display_lines = {}

    for idx, line in ipairs(lines) do
        local cols = vim.split(line, "%s+")
        if cols[1] and cols[2] then
            symbol_names[idx] = cols[1]
            display_lines[idx] = string.format("%-40s : %15s", cols[1], cols[2])
        end
    end

    if #display_lines == 0 then
        vim.api.nvim_echo({{"No valid symbols parsed", "ErrorMsg"}}, false, {})
        return
    end

    local parent_window = vim.api.nvim_get_current_win()

    local width = math.floor(vim.api.nvim_win_get_width(parent_window) / 3)

    -- If buffer is not present already -> Create a new buffer, otherwise reuse
    if not (ctags_buffer and vim.api.nvim_buf_is_valid(ctags_buffer)) then
        ctags_buffer = vim.api.nvim_create_buf(true, true)
    else
        vim.bo[ctags_buffer].modifiable = true -- If reusing, allow modify
    end

    -- If window is not present already -> Create a new window, otherwise reuse
    if not (ctags_window and vim.api.nvim_win_is_valid(ctags_window)) then
        vim.cmd.vsplit()
        ctags_window = vim.api.nvim_get_current_win()
        vim.cmd("vertical resize " .. width) -- Resize only when new window is created
    end

    vim.api.nvim_win_set_buf(ctags_window, ctags_buffer)   -- set buffer in the new vertical window

    -- Set buffer options for this particular buffer
    -- vim.bo[ctags_buffer].buftype = "nofile"
    vim.bo[ctags_buffer].swapfile = false
    vim.bo[ctags_buffer].filetype = "symbols"
    vim.bo[ctags_buffer].bufhidden = "wipe"

    -- vim.bo.number = false 
    -- Doesn't work: Why ? Because number option is window local, not buffer local (you can replace the content of the window with any buffer, it won't impact number)

    vim.api.nvim_set_option_value("number", false, { win = ctags_window }) -- Pure API call, Works in Lua configs and also from external RPC clients (e.g., Neovide, VSCode Neovim).
    vim.wo[ctags_window].relativenumber = false    -- Simpler way to change window options

    -- Set lines
    vim.api.nvim_buf_set_lines(ctags_buffer, 0, -1, false, display_lines)
    -- First argument is buf_num, 0 means current buffer
    vim.bo[ctags_buffer].modifiable = false

    -- Bind <CR> to symbol jump but only in this buffer, so even if someone changes buffer then this keybind shouldn't impact it
    vim.keymap.set("n", "<CR>", function()
        OnLineEnter(symbol_names, parent_window)
    end, { buffer = ctags_buffer, silent = true })
end
