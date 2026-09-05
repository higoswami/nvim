-- ==== mini.files ====
local ok, mini_files = pcall(require, "mini.files")
if ok then
    mini_files.setup({
        mappings = {
            go_in = '<CR>',
            go_out = '-'
        },
        windows = {
            preview = true,
            width_preview = 60,
        }
    })

    vim.keymap.set(
        "n",
        "<leader>e",
        function()
            require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
        end,
        { desc = "Open mini.files (Directory of Current File)", }
    )

    -- Copy Absolute Path of the File
    local yank_absolute_path = function()
        local path = require("mini.files").get_fs_entry().path
        vim.fn.setreg("+", path)
        print(path)
    end
    vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesBufferCreate", -- Read :help MiniFiles-events
        callback = function(args)
            local buf_id = args.data.buf_id

            -- We can use <Shift + y> to copy the file name and this for Absolute path
            vim.keymap.set(
                "n",
                "gy",
                yank_absolute_path,
                { buffer = args.data.buf_id, desc = "Copy absolute path of file" }
            )
        end,
    })
end
