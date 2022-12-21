local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
 if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
     "git",
     "clone",
     "--filter=blob:none",
     "--single-branch",
     "https://github.com/folke/lazy.nvim.git",
     lazypath,
   })
 end
 vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
    -- lsp support
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "simrat39/rust-tools.nvim",
    "HallerPatrick/py_lsp.nvim",
    "ray-x/lsp_signature.nvim",
    "SmiteshP/nvim-navic",
    "onsails/lspkind.nvim",
    "lukas-reineke/lsp-format.nvim",

    -- completion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "lukas-reineke/cmp-under-comparator",

    -- non-lsp tools in lsp
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- find stuff
    "nvim-telescope/telescope.nvim",

    -- escape with jk
    "max397574/better-escape.nvim",

    -- ez terminal splits
    "akinsho/toggleterm.nvim",

    -- f o c u s
    { "folke/zen-mode.nvim", requires = { "folke/twilight.nvim" } },

    -- aesthetics
    "stevearc/dressing.nvim",
    "lukas-reineke/indent-blankline.nvim",
    { "catppuccin/nvim", name = "catppuccin" },
    {
        "feline-nvim/feline.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    },
    "NvChad/nvim-colorizer.lua",
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
    "Eandrju/cellular-automaton.nvim",
    "tamton-aquib/duck.nvim",

    "andweeb/presence.nvim",

    {"glacambre/firenvim", build = function() vim.fn["firenvim#install"](0) end },
})
