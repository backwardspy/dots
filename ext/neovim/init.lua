local opt, g = vim.opt, vim.g

g.mapleader = " "
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.number = true
opt.relativenumber = true
opt.scrolloff = 3
opt.colorcolumn = "80,88,120"
opt.cmdheight = 0

vim.keymap.set("n", "<C-s>", "<CMD>w<CR>", { desc = "Save file" })

local ascii_border = { "+", "-", "+", "|", "+", "-", "+", "|" }
local ascii_border_telescope = { "-", "|", "-", "|", "+", "+", "+", "+" }

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
        "mcchrish/zenbones.nvim",
        dependencies = { "rktjmp/lush.nvim" },
        config = function()
            vim.cmd.colorscheme("skelebones")
        end
    },
    {
        "nvim-lualine/lualine.nvim",
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
        lazy = false,
        dependencies = {
            "HallerPatrick/py_lsp.nvim",
            "simrat39/rust-tools.nvim",
            "LnL7/vim-nix",
        },
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

            local setup = function(server, opts)
                opts = opts or {}
                opts.on_attach = maybe_setup_codelens
                server.setup(opts)
            end

            -- python
            -- pyright emits a ton of "hint" diagnostics which are very noisy.
            -- this disables those.
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
            require("py_lsp").setup({ capabilities = capabilities })
            setup(lsp.ruff_lsp)

            -- rust
            require("rust-tools").setup()

            -- lua
            setup(lsp.lua_ls, {
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
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "RRethy/nvim-treesitter-endwise",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
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
        config = function()
            require("mini.ai").setup()
            require("mini.basics").setup({
                mappings = { windows = true },
                autocommands = { basic = false }, -- breaks dap (nvim-dap/issues/439 )
            })
            require("mini.bracketed").setup()
            require("mini.comment").setup()
            require("mini.completion").setup()
            require("mini.indentscope").setup({ symbol = "│" })
            require("mini.pairs").setup()
            require("mini.sessions").setup()
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

            -- i like C-y to accept completions. CR should *always* just insert a newline.
            local keys = {
                ["C-y"] = vim.api.nvim_replace_termcodes("<C-y>", true, true, true),
                ["C-y_CR"] = vim.api.nvim_replace_termcodes("<C-y><CR>", true, true, true),
            }

            _G.cr_action = function()
                if vim.fn.pumvisible() ~= 0 then
                    -- if popup is visible, confirm selected item or add new line otherwise
                    local item_selected = vim.fn.complete_info()["selected"] ~= -1
                    return item_selected and keys["C-y"] or keys["C-y_CR"]
                else
                    -- if popup is not visible, use plain `<cr>`.
                    return require("mini.pairs").cr()
                end
            end

            vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })
        end,
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
                if columns < 120 then
                    return layouts.vertical(picker, columns, lines, layout_config)
                else
                    return layouts.horizontal(picker, columns, lines, layout_config)
                end
            end

            layouts.adaptive = adaptive_layout

            ts.setup({
                defaults = vim.tbl_extend("force", require("telescope.themes").get_ivy(), {
                    path_display = { shorten = { len = 3, exclude = { 1, -1 } } },
                    layout_config = {
                        height = 0.6,
                    },
                    borderchars = ascii_border_telescope,
                }),
                pickers = {
                    live_grep = {
                        layout_strategy = "adaptive",
                    }
                },
                extensions = {
                    ["ui-select"] = { require("telescope.themes").get_cursor() },
                    undo = { layout_strategy = "adaptive" }
                },
            })

            ts.load_extension("fzf")       -- native sorter
            ts.load_extension("ui-select") -- use telescope for code actions etc
            ts.load_extension("undo")      -- undo tree
        end
    },
    {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        opts = { suggestion = { auto_trigger = true } }
    },
    { "lewis6991/gitsigns.nvim", opts = {} },
    {
        "tpope/vim-fugitive",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-tree/nvim-web-devicons",
            "pwntester/octo.nvim",
            "tpope/vim-rhubarb",
        },
        config = function()
            require("octo").setup()
        end
    },
    { "stevearc/oil.nvim",       opts = {} },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {}
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            search = {
                mode = function(str)
                    return "\\<" .. str
                end
            }
        },
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
                "<c-s>",
                mode = { "c" },
                function() require("flash").toggle() end,
                desc =
                "Toggle flash search"
            },
        },
    },
}, {
    dev = {
        path = "~/src/backwardspy",
        patterns = { "backwardspy" },
        fallback = true,
    },
    install = {
        colorscheme = { "256_noir" },
    },
    ui = {
        border = ascii_border,
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
