These config requires atleast NVIM v0.12 becuase i'm using vim.pack (Built-in Package Manager)

## Profiles

This config runs on multiple machines (personal desktop, work laptop, headless
Arch Linux server), each with a different set of plugins/behaviour. The
correct one is picked at startup based on the `NVIM_PROFILE` environment
variable — see `init.lua` for the up to date list of available profiles
(`minimal`, `server`, `endeavouros`, `work`).

### Setting NVIM_PROFILE

Export it in your shell's rc file (`~/.zshrc`, `~/.bashrc`, etc.) so it's
available in every new shell/session:

```sh
export NVIM_PROFILE="work"   # or "endeavouros", "server", "minimal"
```

If `NVIM_PROFILE` isn't set (e.g. a shell that never sourced your rc file,
a cron job, a systemd unit), it silently falls back to `"minimal"` — core
config only, no plugins. This also acts as a visible signal (a colorscheme
"not found" notification on startup) that you forgot to set it, rather than
failing silently.

## vim.pack usage

### Why is nvim-pack-lock.json gitignored?

`nvim-pack-lock.json` pins the exact installed revision of every plugin ever
added via `vim.pack.add()` **on that machine**. Since each machine runs a
different profile with a different plugin set (e.g. the server profile never
installs `nvim-treesitter`/`cscope_maps.nvim`/etc.), a single shared, committed
lockfile would cause plugins irrelevant to a given machine's profile to get
installed there too — because on `:restart`, Neovim installs *every* plugin
listed in the lockfile, not just the ones the active profile's
`vim.pack.add()` calls request (see `:help vim.pack-lockfile`). To keep each
machine's installed plugins scoped to only what its profile actually declares,
the lockfile is kept local/untracked instead.

### Update the Plugins

```vim
:lua vim.pack.update()
```

Execute `:write` to confirm update, execute `:quit` to discard the update.

```vim
:write
```

### Delete a Plugin

```vim
:lua vim.pack.del({'mini.files'})
```


**NOTE: If a plugin is active, it can't be uinstalled. So before uninstalling comment out the plugin's `require(...)` line in the relevant `lua/profiles/<profile>.lua`, so that it isn't loaded**
```lua
-- require("plugins.nvim-treesitter")
```

and then delete the plugin from device:
```vim
:lua vim.pack.del({"nvim-treesitter"})
```

## References
- [Minimal Neovim Config](https://github.com/radleylewis/nvim-lite)
