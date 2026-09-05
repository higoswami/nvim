local ok, _ = pcall(require, "cscope_maps")
if not ok then
    return
end

local function find_workspace_cscope_out()
    local fullpath = vim.fn.expand("%:p")
    local workspace_path = nil

    if fullpath:match("/waverouter/") then
        workspace_path = fullpath:match("(.*/waverouter)")
    elseif fullpath:match("/waverouter%-2/") then
        workspace_path = fullpath:match("(.*/waverouter%-2)")
    else
        vim.api.nvim_echo(
            { { "No matching Workspace found in path for cscope: " .. fullpath, "ErrorMsg" } }, 

            true, {})
        return
    end

    workspace_cscope_out = workspace_path .. "/ciena/cscope.out"
    vim.notify("cscope.out in use : " .. workspace_cscope_out)
    return workspace_cscope_out
end

-- ==== cscope_maps.nvim ====
-- We don't want to load it automatically for all the files
vim.api.nvim_create_user_command(
    "CscopeLoad",
    function()
        require("cscope_maps").setup({
            cscope = {
                db_file = { "./cscope.out", find_workspace_cscope_out() },
                -- "true" does not open picker for single result, just JUMP
                skip_picker_for_single_result = true,
            }
        })
        vim.keymap.set("n", "<leader>ct", ":lua ShowFileSymbols()<CR>", opts) -- To override cscope keymap (NOTE: Need a better solution)
    end,
    { desc = "Start Cscope" }
)
