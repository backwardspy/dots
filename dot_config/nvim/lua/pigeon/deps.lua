return {
    bootstrap = function()
        local sitepath = vim.fn.stdpath("data").."/site"
        local minipath = sitepath.."/pack/deps/start/mini.nvim"
        if not vim.loop.fs_stat(minipath) then
            vim.cmd('echo "installing mini.nvim" | redraw')
            local cmd = {
                "git", "clone", "--filter=blob:none",
                "https://github.com/echasnovski/mini.nvim.git",
                minipath,
            }
            vim.fn.system(cmd)
            vim.cmd("packadd mini.nvim | helptags ALL")
            vim.cmd('echo "installed mini.nvim" | redraw')
        end
        return sitepath
    end
}
