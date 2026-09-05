-- Print the git branch for the project that contains the current file
vim.api.nvim_create_user_command(
    "GitBranch", 
    function()
        local dir_path = vim.fn.expand("%:p:h")
        local cmd = "git -C " .. dir_path .. " branch"
        local output = vim.fn.system(cmd)
        vim.notify(output)
    end, 
    { desc = "Show Project git branch" }
)

-- Print the current file Path and Copy it in the clipboard --
vim.api.nvim_create_user_command(
    "CopyFilePath",
    function()
        local path = vim.fn.expand("%:p")
        vim.fn.setreg("+", path) -- Save path in register
        print("file:", path)
    end,
    { desc = "Copy Current File Path" }
)
