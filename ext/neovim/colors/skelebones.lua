local name = "skelebones"
vim.g.colors_name = name

local lush = require("lush")
local hsluv = lush.hsluv
local util = require("zenbones.util")
local specs = require("zenbones.specs")
local term = require("zenbones.term")

local bg = vim.o.background

local palette
if bg == "light" then
    palette = util.palette_extend({
        bg = hsluv("#EBEBEB"),
        fg = hsluv("#4C3836"),
        rose = hsluv("#EB4B9E"),
        leaf = hsluv("#D6EB4B"),
        wood = hsluv("#EB934B"),
        water = hsluv("#704BEB"),
        blossom = hsluv("#A34BEB"),
        sky = hsluv("#4BEBC8"),
    }, bg)
else
    palette = util.palette_extend({
        bg = hsluv("#131313"),
        fg = hsluv("#EB4B60"),
        rose = hsluv("#EB4B9E"),
        leaf = hsluv("#D6EB4B"),
        wood = hsluv("#EB934B"),
        water = hsluv("#704BEB"),
        blossom = hsluv("#A34BEB"),
        sky = hsluv("#4BEBC8"),
    }, bg)
end

local base_specs = specs.generate(palette, bg, specs.get_global_config(name, bg))
local final_specs = lush.extends({ base_specs }).with(function()
    return {
        ColorColumn({ base_specs.CursorLine }),
        LazyNormal({ base_specs.Normal }),
    }
end)
lush(final_specs)

term.apply_colors(palette)
