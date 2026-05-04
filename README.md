These config requires atleast NVIM v0.12 becuase i'm using vim.pack (Built-in Package Manager)

## vim.pack usage

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


**NOTE: If a plugin is active, it can't be uinstalled. So before uninstalling comment this line, so that plugins aren't loaded**
```lua
-- require("plugins")
```

and then delete the plugin from device:
```vim
:lua vim.pack.del({"nvim-treesitter"})
```

## References
- [Minimal Neovim Config](https://github.com/radleylewis/nvim-lite)
