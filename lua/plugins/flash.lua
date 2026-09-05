-- ==== flash.nvim ====
-- require("flash").setup()
local ok, flash_nvim = pcall(require, "flash")
if ok then
    flash_nvim.setup()
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
end
