-- Trigger OSC 52 out through stdout specifically when text is yanked
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Sync yanked text to Windows Terminal host clipboard",
  callback = function()
    -- Only forward explicit yanks (avoids flooding clipboard during 'd', 'c', 'x')
    if vim.v.event.operator == "y" then
      require("vim.ui.clipboard.osc52").copy("+")(vim.v.event.regcontents)
    end
  end,
})
