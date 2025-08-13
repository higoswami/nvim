-- ========================== Plugins ====================
-- Plugins are downloaded at : /home/hgoswami/.local/share/nvim/site/pack/core/opt
vim.pack.add({
    {src = "https://github.com/scottmckendry/cyberdream.nvim.git"},
    {src = "https://github.com/folke/which-key.nvim.git"},
    {src = "https://github.com/folke/flash.nvim.git"},
    {src = "https://github.com/echasnovski/mini.files.git"},
    {src = "https://github.com/lewis6991/gitsigns.nvim.git"},
    {src = 'https://github.com/dhananjaylatkar/cscope_maps.nvim.git', version = 'main'},
})

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

-- ================== Load and Configure the Plugin at Startup (not Lazy loaded) ============================ 
-- When you use setup(), you may override the defaults based on how setup() is written in Plugin

-- ==== cscope_maps.nvim ====
require("cscope_maps").setup({
    cscope = {
        db_file = { "./cscope.out", find_workspace_cscope_out() },
        -- "true" does not open picker for single result, just JUMP
        skip_picker_for_single_result = true,
    }
})

-- ==== flash.nvim ====
require("flash").setup()
vim.keymap.set(
    { "n", "x", "o" },
    "f",
    function()
        require("flash").jump()
    end,
    { desc = "Flash" }
)
vim.keymap.set(
    { "n", "x", "o" },
    "F",
    function()
	require("flash").treesitter()
    end,
    { desc = "Flash Treesitter" }
)

-- ===== gitsigns.nvim =========
require("gitsigns").setup( {
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Keymap ---
        map(
            'n', 
            '<leader>gb', 
            function()
                -- gitsigns.blame_line({ full = true })
                gitsigns.blame()
            end,
            { desc = "Git blame of the File" }
        )
    end
})

-- ==== mini.files ====
local ok, mini_files = pcall(require, "mini.files")
if ok then
    mini_files.setup({
        mappings = {
            go_in = '<CR>',
            go_out = '-'
        },
        windows = {
            preview = true,
            width_preview = 60,
        }
    })

    vim.keymap.set(
        "n",
        "<leader>e",
        function()
            require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        { desc = "Open mini.files (Directory of Current File)", }
    )

    -- Copy Absolute Path of the File
    local yank_absolute_path = function()
        local path = require("mini.files").get_fs_entry().path
        vim.fn.setreg("+", path)
        print(path)
    end
    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate", -- Read :help MiniFiles-events
        callback = function(args)
            local buf_id = args.data.buf_id

            -- We can use <Shift + y> to copy the file name and this for Absolute path
            vim.keymap.set(
                "n",
                "gy",
                yank_absolute_path,
                { buffer = args.data.buf_id, desc = "Copy absolute path of file" }
            )
        end,
    })
end
