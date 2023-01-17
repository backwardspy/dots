-- puts current line number on current line
-- relative line numbers on everything else
vim.opt.number = true
vim.opt.relativenumber = true

-- default to 4 spaces for indentation
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- fold on treesitter objects
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99

-- keep some lines at the top/bottom of the window
vim.opt.scrolloff = 8

-- smarter smartindent
vim.opt.cindent = true

-- global statusline
vim.opt.laststatus = 3

-- apparently this makes cmp work
vim.opt.completeopt = "menu,menuone,noselect"

-- live life dangerously
vim.opt.swapfile = false
vim.opt.backup = false

-- no more noh and incremental search highlighting
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- it's free real estate
vim.opt.cmdheight = 0

-- no more jumping around when signs arrive
vim.opt.signcolumn = "yes"

-- make cursorhold happen faster
vim.opt.updatetime = 100

-- make which key show up faster
vim.opt.timeoutlen = 500

-- netrw nicety
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- 24bit tui colours
vim.opt.termguicolors = true

-- gui/neovide stuff
vim.opt.guifont = vim.fn.has("mac") and "Rec Mono Duotone:h15" or "Rec Mono Duotone:h13"

if vim.g.neovide then
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    vim.g.neovide_cursor_vfx_particle_density = 50
end
