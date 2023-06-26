-- inspiration: https://u.peppe.rs/bF.png
local down2 = "#0B0510"
local down1 = "#150A1F"
local base = "#200F2F"
local up1 = "#3A224F"
local up2 = "#452D5B"

local text0 = "#F2ECF7"
local text1 = "#C3B1D3"
local text2 = "#AD96C1"
local text3 = "#9980AF"
local text4 = "#88709E"

local passive = "#9AF2E9"
local active = "#EEB683"
local error = "#E57D8B"

-- highlights
local hl = {
    -- ui
    Normal = { bg = base, fg = text0 },
    EndOfBuffer = { link = "Normal" },
    SignColumn = { link = "Normal" },
    LineNr = { fg = text4 },
    CursorLineNr = { fg = text1 },
    Search = { bg = up2 },
    CurSearch = { fg = active, bg = up2 },
    CursorColumn = { bg = up1 },
    CursorLine = { bg = up1 },
    Visual = { bg = up2 },
    StatusLine = { link = "Normal" },
    StatusLineNC = { bg = base, fg = text4 },
    WinBar = { link = "Normal" },
    WinBarNC = { link = "Normal" },
    Pmenu = { bg = down1 },
    PmenuSel = { bg = up1 },
    PmenuKind = { bg = down1 },
    PmenuKindSel = { bg = up1, fg = passive },
    PmenuSbar = { bg = down2 },
    PmenuThumb = { bg = up1 },
    Title = { fg = passive },
    DiagnosticError = { fg = error },
    DiagnosticWarn = { fg = active },
    DiagnosticInfo = { fg = passive },
    DiagnosticHint = { fg = text0 },
    DiagnosticOk = { link = "DiagnosticHint" },

    -- names
    Identifier = { fg = text0 },
    Function = { link = "Identifier" },
    PreProc = { link = "Identifier" },
    Type = { link = "Identifier" },

    -- values
    Constant = { fg = passive },
    Underlined = { link = "Constant" },

    -- syntax
    Statement = { fg = text0, bold = true },
    Comment = { fg = text4 },

    -- punctuation
    Special = { fg = text3 },

    -- informational
    Error = { fg = error },
    ErrorMsg = { link = "Error" },
    Todo = { fg = passive },
    WarningMsg = { fg = active },
}

for group, args in pairs(hl) do
    vim.api.nvim_set_hl(0, group, args)
end

-- statusline
local set_statusline = function()
    vim.opt.statusline = "%#StatusLineNC#%f%#StatusLine# %= %n %= %l,%c   %#StatusLineNC#%{mode()}   %y"
end
set_statusline()
vim.api.nvim_create_autocmd(
    { "BufEnter", "WinEnter" },
    {
        group = vim.api.nvim_create_augroup("pigeon_statusline", {}),
        callback = set_statusline
    }
)
