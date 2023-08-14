local colors_name = "catbones"
vim.g.colors_name = colors_name -- Required when defining a colorscheme

local lush = require "lush"
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require "zenbones.util"

local bg = vim.o.background

-- Define a palette. Use `palette_extend` to fill unspecified colors
-- Based on https://github.com/gruvbox-community/gruvbox#palette
local palette
if bg == "light" then
    palette = util.palette_extend({
        bg = hsluv "#eff1f5",
        fg = hsluv "#4c4f69",
        rose = hsluv "#d20f39",
        leaf = hsluv "#40a02b",
        wood = hsluv "#fe640b",
        water = hsluv "#1e66f5",
        blossom = hsluv "#ea76cb",
        sky = hsluv "#04a5e5",
    }, bg)
else
    palette = util.palette_extend({
        bg = hsluv "#080808",
        fg = hsluv "#cdd6f4",
        rose = hsluv "#f38ba8",
        leaf = hsluv "#a6e3a1",
        wood = hsluv "#fab387",
        water = hsluv "#89b4fa",
        blossom = hsluv "#f5c2e7",
        sky = hsluv "#89dceb",
    }, bg)
end

-- Generate the lush specs using the generator util
local generator = require "zenbones.specs"
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
    return {
        Statement { base_specs.Statement, fg = palette.rose },
        Special { fg = palette.water },
        Type { fg = palette.sky, gui = "italic" },
    }
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
require("zenbones.term").apply_colors(palette)
