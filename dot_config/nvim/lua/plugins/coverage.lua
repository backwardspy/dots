return {
    {
        "andythigpen/nvim-coverage",
        cond = not vim.g.vscode,
        config = true,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
}
