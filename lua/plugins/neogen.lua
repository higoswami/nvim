-- ============== neogen =============================
local ok, neogen = pcall(require, "neogen")
if ok then
    neogen.setup()
    vim.keymap.set(
        "n",
        "<leader>cn",
        function()
            neogen.generate({ type = "func" })
        end,
        { desc = "Generate docstring/annotation for function" }
    )
end
