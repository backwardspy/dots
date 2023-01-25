return {
    {
        "williamboman/mason.nvim",
        cond = not vim.g.vscode,
        opts = { ui = { border = "rounded" } },
    }
}
