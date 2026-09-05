-- ~/.config/nvim/
-- ├── init.lua
-- └── lua/
--     └── profiles/
--         ├── minimal.lua      # Fail-safe / fallback (core only, no plugins, zero overhead)
--         ├── server.lua       # Headless Arch Linux server (no LSP/Treesitter, OSC 52 clipboard)
--         ├── endeavouros.lua  # Personal desktop dev setup (LSPs, Treesitter, Cscope, full UI)
--         └── work.lua         # Work setup (inherits endeavouros + enterprise/work configs)

-- ==========================================================================
-- 1. Core Configuration (Runs on all machines)
-- Set <leader> inside keymaps or options BEFORE loading any plugins
-- ==========================================================================
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.usercmds")

-- ==========================================================================
-- 2. Profile Detection & Loading
-- ==========================================================================
-- Reads NVIM_PROFILE from shell ("server", "endeavouros", or "work")
-- Set in ~/.bashrc or ~/.zshrc using : export NVIM_PROFILE="server"
local profile = os.getenv("NVIM_PROFILE")

-- Automatic fallback if NVIM_PROFILE is not explicitly set:
-- If connected via SSH -> defaults to "server", otherwise -> "endeavouros"
if not profile or profile == "" then
    profile = "minimal"
end

-- Safely load the detected profile : profiles.<profile_name>.lua
local ok, err = pcall(require, "profiles." .. profile)
if not ok then
  vim.notify("Could not load profile 'profiles." .. profile .. "': " .. err, vim.log.levels.WARN)
end

-- ==========================================================================
-- 3. Colorscheme
-- Loaded last so colorscheme plugins added via vim.pack are on runtimepath
-- ==========================================================================
require("colorscheme")
