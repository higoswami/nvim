-- ======= Set colorscheme ===============
local colorscheme = "cyberdream"

-- Check if colorsheme is even available
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.api.nvim_echo({{"colorscheme " .. colorscheme .. " not found!", "ErrorMsg"}}, true, {})
  return
end
