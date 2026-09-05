-- =============== indent-blankline.nvim ====================
local ok, indent_blankline = pcall(require, "ibl")
if ok then
    -- Neovim resets many highlight groups when you switch or reload colorschemes
    -- Use hooks so your highlight is reapplied even if colorscheme changes
    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IndentScopeColor", { fg = "#FF00FF" }) -- Created a highlight group for use in indent-blankline
    end)
    indent_blankline.setup({
        -- Note: Scope is slightly different from indent
        scope = {
            highlight = "IndentScopeColor"
        }
    })
end
