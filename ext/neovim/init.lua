local opt, g = vim.opt, vim.g
local map = vim.keymap.set

g.mapleader = " "
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.number = true
opt.relativenumber = true
opt.scrolloff = 3
opt.colorcolumn = "80,88,120"
opt.completeopt = "menu,menuone,noinsert"

map("n", "<leader>tn", function() vim.wo.relativenumber = not vim.wo.relativenumber end,
    { desc = "Toggle relative line numbers" })

map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half a page" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half a page" })
map("n", "<leader>Y", '"+Y', { desc = "Yank rest of line to system clipboard" })
map("n", "J", "mzJ`z", { desc = "Join lines" })
map("n", "N", "Nzzzv", { desc = "Center on previous search result" })
map("n", "Q", "<nop>", { desc = "Disable Ex mode" })
map("n", "n", "nzzzv", { desc = "Center on next search result" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })
map("x", "p", '"_dP', { desc = "Replace without yank" })
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })

-- see :help clipboard-wsl
if vim.fn.has("wsl") ~= 0 then
    g.clipboard = {
        name = "WslClipboard",
        copy = {
            ["+"] = "clip.exe",
            ["*"] = "clip.exe",
        },
        paste = {
            ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
            ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        },
        cache_enabled = 0,
    }
end

vim.keymap.set("n", "<C-s>", "<CMD>w<CR>", { desc = "Save file" })

function PythonEnv()
    for _, client in pairs(vim.lsp.buf_get_clients()) do
        if client.name == "pyright" then
            return client.config.settings.python
        end
    end
    return nil
end

require("lazy").setup({
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.opt.background = "dark"
            vim.cmd.colorscheme("oxocarbon")
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { { "linrongbin16/lsp-progress.nvim", opts = {} } },
        opts = {
            options = {
                icons_enabled = false,
                theme = "auto",
                component_separators = { left = " ", right = " " },
                section_separators = { left = "", right = "" },
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "filename" },
                lualine_c = { "require('lsp-progress').progress()" },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "HallerPatrick/py_lsp.nvim",
            "simrat39/rust-tools.nvim",
            "LnL7/vim-nix",
            "jose-elias-alvarez/null-ls.nvim",
        },
        lazy = false,
        keys = {
            { "<leader>la", vim.lsp.buf.code_action,    desc = "Code action" },
            { "<leader>lf", vim.lsp.buf.format,         desc = "Format document" },
            { "<leader>lk", vim.lsp.buf.signature_help, desc = "Signature help" },
            { "<leader>ll", vim.lsp.codelens.run,       desc = "Code lens" },
            { "<leader>lr", vim.lsp.buf.rename,         desc = "Rename symbol" },
            { "K",          vim.lsp.buf.hover,          desc = "Hover" },
        },
        config = function()
            local lsp = require("lspconfig")

            local maybe_setup_codelens = function(client, bufnr)
                if not client.server_capabilities.codeLensProvider then
                    return
                end

                -- as per :help vim.lsp.codelens.refresh
                vim.api.nvim_create_autocmd(
                    { "BufEnter", "BufWritePost", "CursorHold" },
                    {
                        group = vim.api.nvim_create_augroup("LSPCodeLens", {}),
                        callback = vim.lsp.codelens.refresh,
                        buffer = bufnr,
                    })
            end

            local on_attach = function(client, bufnr)
                maybe_setup_codelens(client, bufnr)

                vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.lsp.formatexpr()")
                vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.lsp.omnifunc")
                vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.lsp.tagfunc")
            end

            local setup = function(server, opts)
                opts = opts or {}
                opts.on_attach = on_attach
                server.setup(opts)
            end

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- python
            -- pyright emits a ton of "hint" diagnostics which are very noisy.
            -- this disables those.
            local py_capabilities = vim.tbl_extend("force", capabilities, {
                textDocument = { publishDiagnostics = { tagsSupport = { valueSet = { 2 } } } }
            })
            require("py_lsp").setup({ capabilities = py_capabilities })
            setup(lsp.ruff_lsp)

            -- rust
            require("rust-tools").setup({ capabilities = capabilities })

            -- lua
            setup(lsp.lua_ls, {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } },
                        telemetry = { enable = false },
                        format = {
                            enable = true,
                            defaultConfig = {
                                indent_style = "space",
                                indent_size = "4",
                            }
                        }
                    },
                },
            })

            -- nix
            setup(lsp.nil_ls, {
                capabilities = capabilities,
                settings = {
                    ["nil"] = {
                        formatting = {
                            command = { "alejandra" }
                        }
                    }
                }
            })

            -- progress listener
            require("lsp-progress").setup({ decay = 3000 })

            -- non-lsp tools
            local nls = require("null-ls")
            nls.setup({
                sources = {
                    nls.builtins.formatting.black,
                }
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "RRethy/nvim-treesitter-endwise",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        event = "VeryLazy",
        config = function()
            require("nvim-treesitter.configs").setup({
                auto_install = false,
                highlight = {
                    enable = true,
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        node_decremental = "<BS>",
                    },
                },
                indent = {
                    enable = true,
                },
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                },
                endwise = { enable = true },
            })

            opt.foldmethod = "expr"
            opt.foldexpr = "nvim_treesitter#foldexpr()"
            opt.foldenable = false

            require("treesitter-context").setup({
                max_lines = 3,
                min_window_height = 20,
                mode = "topline",
            })
        end
    },
    {
        "echasnovski/mini.nvim",
        version = false,
        lazy = false,
        config = function()
            require("mini.ai").setup()
            require("mini.basics").setup({ mappings = { windows = true } })
            require("mini.bracketed").setup()
            local miniclue = require("mini.clue")
            miniclue.setup({
                triggers = {
                    -- Leader triggers
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },

                    -- Built-in completion
                    { mode = 'i', keys = '<C-x>' },

                    -- `g` key
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },

                    -- Marks
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },

                    -- Registers
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },
                },

                clues = {
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                },

                window = {
                    delay = 0,
                },
            })
            require("mini.comment").setup()
            require("mini.indentscope").setup({ symbol = "│" })
            require("mini.surround").setup({
                mappings = {
                    add = "ys",
                    delete = "ds",
                    find = "",
                    find_left = "",
                    highlight = "",
                    replace = "cs",
                    update_n_lines = "",
                }
            })
            require("mini.trailspace").setup()
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = { "VeryLazy" },
        dependencies = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "lukas-reineke/cmp-under-comparator",
            "neovim/nvim-lspconfig",
            "onsails/lspkind.nvim",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            local kind_width = 0
            for kind, _ in pairs(lspkind.symbol_map) do
                local len = string.len(kind)
                if len > kind_width then
                    kind_width = len
                end
            end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        require("cmp-under-comparator").under,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    }
                },
                window = {
                    completion = { scrollbar = false },
                },
                formatting = {
                    format = function(entry, vim_item)
                        local kind = lspkind.cmp_format({
                            mode = "symbol_text",
                            maxwidth = 32,
                        })(entry, vim_item)

                        local strings = vim.split(kind.kind, "%s", { trimempty = true })
                        strings[1] = " " .. strings[1]
                        strings[2] = string.upper(strings[2])

                        local pad_len = kind_width - string.len(strings[2])

                        if pad_len > 0 then
                            local spaces = string.rep(" ", pad_len)
                            strings[2] = strings[2] .. spaces
                        end
                        kind.kind = table.concat(strings, " ")
                        return kind
                    end
                },
            })

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    { name = "git" },
                }, {
                    { name = "buffer" },
                })
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" }
                }
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" }
                }, {
                    { name = "cmdline" }
                })
            })

            local luasnip = require("luasnip")
            vim.keymap.set("i", "<C-j>", function() luasnip.expand_or_jump() end, { desc = "Jump to next placeholder" })
            vim.keymap.set("i", "<C-k>", function() luasnip.jump(-1) end, { desc = "Jump to previous placeholder" })
        end
    },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "mfussenegger/nvim-dap-python",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
        },
        keys = {
            { "<leader>xb",  function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
            { "<leader>xr",  function() require("dap").repl.open() end,         desc = "Open REPL" },
            { "<leader>xsi", function() require("dap").step_into() end,         desc = "Step into" },
            { "<leader>xso", function() require("dap").step_over() end,         desc = "Step over" },
            { "<leader>xx",  function() require("dap").continue() end,          desc = "Start/Continue" },
        },
        config = function()
            -- python
            local dap_py = require("dap-python")
            dap_py.resolve_python = function()
                local env = PythonEnv()
                if env then
                    return env.pythonPath
                else
                    return vim.fn.expand("~/.nix-profile/bin/python")
                end
            end
            dap_py.setup()

            -- ui
            local dap, dapui = require("dap"), require("dapui")

            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            require("nvim-dap-virtual-text").setup()
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "debugloop/telescope-undo.nvim",
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-ui-select.nvim",
        },
        cmd = "Telescope",
        keys = {
            { "<leader><leader>", "<CMD>Telescope find_files<CR>",            desc = "Find Files" },
            { "<leader>fb",       "<CMD>Telescope buffers<CR>",               desc = "Buffers" },
            { "<leader>fr",       "<CMD>Telescope resume<CR>",                desc = "Resume previous picker" },
            { "<leader>hH",       "<CMD>Telescope highlights<CR>",            desc = "Highlights" },
            { "<leader>hh",       "<CMD>Telescope help_tags<CR>",             desc = "Help tags" },
            { "<leader>hk",       "<CMD>Telescope keymaps<CR>",               desc = "Keymaps" },
            { "<leader>lS",       "<CMD>Telescope lsp_workspace_symbols<CR>", desc = "Workspace symbols" },
            { "<leader>ld",       "<CMD>Telescope diagnostics<CR>",           desc = "Diagnostics" },
            { "<leader>ls",       "<CMD>Telescope lsp_document_symbols<CR>",  desc = "Document symbols" },
            { "<leader>sg",       "<CMD>Telescope live_grep<CR>",             desc = "Live grep" },
            { "<leader>u",        "<CMD>Telescope undo<CR>",                  desc = "File history" },
            { "gd",               "<CMD>Telescope lsp_definitions<CR>",       desc = "Definitions" },
            { "gi",               "<CMD>Telescope lsp_implementations<CR>",   desc = "Implementations" },
            { "go",               "<CMD>Telescope lsp_type_definitions<CR>",  desc = "Type definitions" },
            { "gr",               "<CMD>Telescope lsp_references<CR>",        desc = "References" },
        },
        config = function()
            local ts = require("telescope")
            local layouts = require("telescope.pickers.layout_strategies")

            local adaptive_layout = function(picker, columns, lines, layout_config)
                if columns < 200 then
                    return layouts.vertical(picker, columns, lines, layout_config)
                else
                    return layouts.horizontal(picker, columns, lines, layout_config)
                end
            end

            layouts.adaptive = adaptive_layout

            ts.setup({
                defaults = vim.tbl_extend("force", require("telescope.themes").get_ivy(), {
                    path_display = { shorten = { len = 5, exclude = { 1, -1 } } },
                    layout_config = {
                        height = 0.6,
                    },
                }),
                extensions = {
                    ["ui-select"] = { require("telescope.themes").get_cursor() },
                    undo = { layout_strategy = "adaptive" },
                },
            })

            ts.load_extension("fzf")       -- native sorter
            ts.load_extension("ui-select") -- use telescope for code actions etc
            ts.load_extension("undo")      -- undo tree
        end
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    {
        "utilyre/sentiment.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        opts = { suggestion = { auto_trigger = true } },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "GBrowse" },
        keys = {
            { "<leader>g", vim.cmd.G, desc = "Git" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-tree/nvim-web-devicons",
            "tpope/vim-rhubarb",
        },
    },
    {
        "stevearc/oil.nvim",
        event = "VeryLazy",
        opts = {},
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function() require("flash").jump() end,
                desc = "Flash"
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function() require("flash").treesitter() end,
                desc =
                "Flash treesitter"
            },
            {
                "r",
                mode = "o",
                function() require("flash").remote() end,
                desc =
                "Remote flash"
            },
            {
                "R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc =
                "Flash treesitter search"
            },
            {
                "<C-s>",
                mode = { "c" },
                function() require("flash").toggle() end,
                desc =
                "Toggle flash search"
            },
        },
    },
    {
        "mvaldes14/terraform.nvim",
        cmd = {
            "TerraformPlan",
            "TerraformExplore",
        },
    },
}, {
    defaults = {
        lazy = true,
    },
    dev = {
        path = "~/src/backwardspy",
        patterns = { "backwardspy" },
        fallback = true,
    },
    install = {
        colorscheme = { "oxocarbon" },
    },
    ui = {
        title = "PLUGIN MANAGER",
        title_pos = "left",
    },
    checker = {
        notify = false,
    },
    change_detection = {
        notify = false,
    },
    performance = {
        disabled_plugins = {
            "gzip",
            "matchparen",
            "netrw",
            "netrwPlugin",
            "tar",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zip",
            "zipPlugin",
        },
    },
})
