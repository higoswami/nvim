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

## References
- [Minimal Neovim Config](https://github.com/radleylewis/nvim-lite)
