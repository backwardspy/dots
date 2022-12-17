local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd.packadd("packer.nvim")
        return true
    end
    return false
end

-- packer setup
local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    -- faster startup
    use("lewis6991/impatient.nvim")

    -- lsp support
    use({
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "simrat39/rust-tools.nvim",
        "HallerPatrick/py_lsp.nvim",
        "ray-x/lsp_signature.nvim",
        "SmiteshP/nvim-navic",
        "onsails/lspkind.nvim",
    })

    -- completion
    use({
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip",
        "lukas-reineke/cmp-under-comparator",
    })

    -- non-lsp tools in lsp
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })

    -- find stuff
    use({ "nvim-telescope/telescope.nvim" })

    -- escape with jk
    use("max397574/better-escape.nvim")

    -- ez terminal splits
    use({ "akinsho/toggleterm.nvim", tag = "*" })

    -- background task runner
    use({
        "google/executor.nvim",
        requires = {
            "MunifTanjim/nui.nvim",
        },
    })

    -- f o c u s
    use({ "folke/zen-mode.nvim", requires = { "folke/twilight.nvim" } })

    -- aesthetics
    use({
        "stevearc/dressing.nvim",
        "lukas-reineke/indent-blankline.nvim",
        { "catppuccin/nvim", as = "catppuccin" },
        {
            "feline-nvim/feline.nvim",
            requires = { "nvim-tree/nvim-web-devicons" },
        },
        {
            "nvim-treesitter/nvim-treesitter",
            run = function()
                local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
                ts_update()
            end,
        },
        "NvChad/nvim-colorizer.lua",
        {
            "folke/noice.nvim",
            requires = {
                "MunifTanjim/nui.nvim",
                "rcarriga/nvim-notify",
            },
        },
        "Eandrju/cellular-automaton.nvim",
        "tamton-aquib/duck.nvim",
    })

    use("andweeb/presence.nvim")

    -- automatically set up your configuration after cloning packer.nvim
    -- put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
