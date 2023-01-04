local wk = require("which-key")

-- normal binds
wk.register({
    ["<C-s>"] = { "<cmd>write<cr>", "Save" },
    ["<C-d>"] = { "<C-d>zz", "Half page down" },
    ["<C-u>"] = { "<C-u>zz", "Half page up" },
    n = { "nzzzv", "Next result (centered)" },
    N = { "Nzzzv", "Previous result (centered)" },
    J = { "mzJ`z", "Join lines (stable)" },
    ["<C-`>"] = { "<cmd>ToggleTerm<cr>", "ToggleTerm" },
})

-- visual binds
wk.register({
    J = { ":m '>+1<CR>gv=gv", "Move line down" },
    K = { ":m '<-2<CR>gv=gv", "Move line up" },
}, { mode = "v" })

-- terminal binds
wk.register({
    ["<C-Esc>"] = { [[<C-\><C-n>]], "Normal mode" },
}, { mode = "t" })

-- leader binds
wk.register({
    g = { "<cmd>Git<cr>", "lazygit" },
    f = {
        name = "Find",
        g = { "<cmd>Telescope git_files<cr>", "Git files" },
        f = { "<cmd>Telescope find_files<cr>", "Find files" },
        s = { "<cmd>Telescope live_grep<cr>", "Live grep" },
    },
}, { prefix = "<leader>" })

-- nv leader binds
wk.register({
    d = { [["_d]], "Delete w/o yank" },
    y = { [["+y]], "Yank to clipboard" },
}, { prefix = "<leader>", mode = { "n", "v" } })

-- x leader binds
wk.register({
    p = { [["_dP"]], "Put w/o yank" },
}, { prefix = "<leader>", mode = "x" })
