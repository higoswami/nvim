-- ===== gitsigns.nvim =========
local ok, gitsigns_nvim = pcall(require, "gitsigns")
if not ok then
    return
end

gitsigns_nvim.setup( {
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
