local wk = require("which-key")

-- normal binds
wk.register({
    ["<C-s>"] = { "<cmd>write<cr>", "Save" },
    ["<C-d>"] = { "<C-d>zz", "Half page down" },
    ["<C-u>"] = { "<C-u>zz", "Half page up" },
    n = { "nzzzv", "Next result (centered)" },
    N = { "Nzzzv", "Previous result (centered)" },
    J = { "mzJ`z", "Join lines (stable)" },
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

-- normal + terminal binds
wk.register({
    ["<C-h>"] = { "<cmd>wincmd h<cr>", "Go to the left window" },
    ["<C-j>"] = { "<cmd>wincmd j<cr>", "Go to the down window" },
    ["<C-k>"] = { "<cmd>wincmd k<cr>", "Go to the up window" },
    ["<C-l>"] = { "<cmd>wincmd l<cr>", "Go to the right window" },
}, { mode = { "n", "t" } })

-- leader binds
wk.register({
    p = { [["+p]], "Put from clipboard" },
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
