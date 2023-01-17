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
vim.opt.guifont = "Fantasque Sans Mono:h13"

if vim.g.neovide then
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    vim.g.neovide_cursor_vfx_particle_density = 50
end

-- https://github.com/CKolkey/config/blob/master/nvim/after/plugin/statuscolumn.lua
-- if _G.StatusColumn then
--     return
-- end
--
-- _G.StatusColumn = {
--     handler = {
--         fold = function()
--             local lnum = vim.fn.getmousepos().line
--
--             -- Only lines with a mark should be clickable
--             if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
--                 return
--             end
--
--             local state
--             if vim.fn.foldclosed(lnum) == -1 then
--                 state = "close"
--             else
--                 state = "open"
--             end
--
--             vim.cmd.execute("'" .. lnum .. "fold" .. state .. "'")
--         end,
--     },
--
--     display = {
--         fold = function()
--             if vim.v.wrap then
--                 return ""
--             end
--
--             local lnum = vim.v.lnum
--             local icon = "  "
--
--             -- Line isn't in folding range
--             if vim.fn.foldlevel(lnum) <= 0 then
--                 return icon
--             end
--
--             -- Not the first line of folding range
--             if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
--                 return icon
--             end
--
--             if vim.fn.foldclosed(lnum) == -1 then
--                 icon = " "
--             else
--                 icon = " "
--             end
--
--             return icon
--         end,
--     },
--
--     sections = {
--         sign_column = {
--             "%s",
--         },
--         line_number = {
--             "%=%{v:relnum?v:relnum:v:lnum}",
--         },
--         spacing = {
--             " ",
--         },
--         folds = {
--             "%@v:lua.StatusColumn.handler.fold@",
--             "%{v:lua.StatusColumn.display.fold()}",
--         },
--         border = {
--             "│"
--         },
--     },
--
--     build = function(tbl)
--         local statuscolumn = {}
--
--         for _, value in ipairs(tbl) do
--             if type(value) == "string" then
--                 table.insert(statuscolumn, value)
--             elseif type(value) == "table" then
--                 table.insert(statuscolumn, StatusColumn.build(value))
--             end
--         end
--
--         return table.concat(statuscolumn)
--     end,
--
--     set_window = function(value)
--         vim.defer_fn(function()
--             vim.api.nvim_win_set_option(vim.api.nvim_get_current_win(), "statuscolumn", value)
--         end, 1)
--     end,
-- }
--
-- vim.opt.statuscolumn = StatusColumn.build({
--     StatusColumn.sections.sign_column,
--     StatusColumn.sections.line_number,
--     StatusColumn.sections.spacing,
--     StatusColumn.sections.folds,
--     StatusColumn.sections.border,
-- })
