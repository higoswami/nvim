-- ==== Treesitter =====
local ok, nvim_treesitter = pcall(require, "nvim-treesitter")
if not ok then
    return
end

nvim_treesitter.setup({
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

-- NOTE: When upgrading the nvim-treesitter plugin, you must make sure that all installed parsers are updated to the latest version via :TSUpdate
-- In Lazyvim we can automate this using :  build = ":TSUpdate", but vim.pack provides us events to hooks into
--  Available events to hook into
--  • PackChangedPre - before trying to change plugin's state.
--  • PackChanged - after plugin's state has changed. (We can use this for this Automation)

