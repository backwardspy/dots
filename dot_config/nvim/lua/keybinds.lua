-- standard neovim binds go here

if not vim.g.vscode then
    return
end

local act = function(key, cmd)
    vim.keymap.set("n", key, function()
        vim.api.nvim_call_function("VSCodeNotify", { cmd })
    end)
end

-- vscode-specific binds
act("<leader>ff", "find-it-faster.findFiles")
act("<leader>fg", "find-it-faster.findWithinFiles")
act("<leader>fG", "find-it-faster.findWithinFilesWithType")
