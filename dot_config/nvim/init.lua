pcall(require, "impatient")

-- puts current line number on current line
-- relative line numbers on everything else
vim.opt.number = true
vim.opt.relativenumber = true

-- default to 4 spaces for indentation
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- global statusline
vim.opt.laststatus = 3

-- apparently this makes cmp work
vim.opt.completeopt = "menu,menuone,noselect"

-- gui/neovide stuff
vim.opt.guifont = "Fantasque Sans Mono:h13"

if vim.g.neovide then
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    vim.g.neovide_cursor_vfx_particle_density = 50
end

-- hotkey modes
local m = { "n", "t", "i" }

-- quicker window movement
vim.keymap.set(m, "<C-h>", [[<cmd>wincmd h<cr>]])
vim.keymap.set(m, "<C-j>", [[<cmd>wincmd j<cr>]])
vim.keymap.set(m, "<C-k>", [[<cmd>wincmd k<cr>]])
vim.keymap.set(m, "<C-l>", [[<cmd>wincmd l<cr>]])

-- highlight yank
vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = "highlight_yank",
    pattern = { "*" },
    callback = function()
        vim.highlight.on_yank({
            higroup = "Visual",
            timeout = 500,
        })
    end,
})

-- easier terminal escape
vim.keymap.set("t", "<c-esc>", [[<C-\><C-n>]])

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
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
        "j-hui/fidget.nvim",
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

    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    })

    -- escape with jk
    use("max397574/better-escape.nvim")

    -- ez terminal splits
    use({ "akinsho/toggleterm.nvim", tag = "*" })

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

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)

-- plugin hotkeys
-- ctrl+p       -> find files
-- ctrl+shift+o -> find symbols
-- ctrl+f       -> search
-- shift+alt+f  -> format file
-- ctrl+s       -> save
-- ctrl+b       -> file tree
-- ctrl+`       -> terminal
-- f2           -> rename
vim.keymap.set(m, "<C-P>", require("telescope.builtin").find_files)
vim.keymap.set(m, "<C-S-O>", require("telescope.builtin").lsp_document_symbols)
vim.keymap.set(m, "<C-F>", require("telescope.builtin").live_grep)
vim.keymap.set(m, "<M-F>", vim.lsp.buf.format)
vim.keymap.set(m, "<C-S>", function()
    vim.api.nvim_command("write")
end)
vim.keymap.set(m, "<C-B>", [[<cmd>Neotree toggle<cr>]])
vim.keymap.set(m, "<F2>", vim.lsp.buf.rename)
