-- ========================== Plugins ====================
-- Plugins are downloaded at : /home/hgoswami/.local/share/nvim/site/pack/core/opt
vim.pack.add({
    {src = "https://github.com/scottmckendry/cyberdream.nvim.git"},
    {src = "https://github.com/folke/which-key.nvim.git"},
    {src = "https://github.com/folke/flash.nvim.git"},
    {src = "https://github.com/echasnovski/mini.files.git"},
    {src = "https://github.com/echasnovski/mini.pick.git"},
    {src = "https://github.com/lewis6991/gitsigns.nvim.git"},
    {src = "https://github.com/dhananjaylatkar/cscope_maps.nvim.git", version = "main"},

    {src = "https://github.com/nvim-treesitter/nvim-treesitter.git", version = "master"}, -- All future updates will be on main branch
    {src = "https://github.com/nvim-treesitter/nvim-treesitter-context.git"},
})

-- Notes:
-- In Lua, require() is cached, so even if you call it multiple times (in the same Neovim session), it won’t reload or run the module again.

-- ================== Load and Configure the Plugin  ============================ 
-- When you use setup(), you may override the defaults based on how setup() is written in Plugin



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
    preview_config = {
        -- Options passed to nvim_open_win
        style = 'minimal',
        border = 'rounded',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    -- on_attach : runs only where the plugin is active (i.e. buffers inside a Git Repo)
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr -- Keymaps are buffer local
            vim.keymap.set(mode, l, r, opts)
        end

        -- Keymaps ---
        map(
            'n', 
            '<leader>gb', 
            function()
                gitsigns.blame_line({ full = true })
            end,
            { desc = "Git blame of the current line" }
        )

        map(
            'n', 
            '<leader>gB', 
            function()
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

-- ==== mini.pick ====
local ok, mini_pick = pcall(require, "mini.pick")
if ok then
    mini_pick.setup()

    -- mini_pick = require("mini.pick") from pcall(..) so no need to rewrite it
    vim.keymap.set("n", "<leader>sb", function() mini_pick.builtin.buffers() end, { noremap = true, desc = "Search Buffers" })
    vim.keymap.set("n", "<leader>sf", function() mini_pick.builtin.files({ tool = "fd" }) end, { noremap = true, desc = "Search Files" }) -- Use fd for file picker
end

-- ==== Treesitter =====
require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = { "cpp" }, --NOTE: If you get an error run :TSUpdate
    -- We don't need to install parsers which are pre-installed with neovim. 
    -- For e.g.: 
    -- c, lua (Check what is pre-installed using :checkhealth vim.treesitter)

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,

    highlight = {
        enable = true,

        -- Disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
})

-- When upgrading the nvim-treesitter plugin, you must make sure that all installed parsers are updated to the latest version via :TSUpdate
-- In Lazyvim we can automate this using :  build = ":TSUpdate", but vim.pack provides us events to hooks into
--  Available events to hook into
--  • PackChangedPre - before trying to change plugin's state.
--  • PackChanged - after plugin's state has changed. (We can use this for this Automation)



-- ==== Treesitter-context ====
require("treesitter-context")
