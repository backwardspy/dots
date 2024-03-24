local function bootstrap_lazynvim()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.uv.fs_stat(lazypath) then
        print("Installing lazy.nvim, this might take a few seconds...")
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
        print("lazy.nvim installed successfully!")
    end
    vim.opt.rtp:prepend(lazypath)
end

return {
    setup = function()
        bootstrap_lazynvim()
    end,
}
