local colors_name = "skelebones"
vim.g.colors_name = colors_name

local lush = require("lush")
local hsluv = lush.hsluv
local util = require("zenbones.util")

local bg = vim.o.background

local palette
if bg == "light" then
  palette = util.palette_extend({
    bg = hsluv "#FFEEFF",
    fg = hsluv "#555555",
    rose = hsluv "#F01D7F",
    leaf = hsluv "#F01D7F",
    wood = hsluv "#F01D7F",
    water = hsluv "#F01D7F",
    blossom = hsluv "#F01D7F",
    sky = hsluv "#F01D7F",
  }, bg)
else
  palette = util.palette_extend({
    bg = hsluv "#000000",
    fg = hsluv "#FFEEFF",
    rose = hsluv "#F01D7F",
    leaf = hsluv "#F01D7F",
    wood = hsluv "#F01D7F",
    water = hsluv "#F01D7F",
    blossom = hsluv "#F01D7F",
    sky = hsluv "#F01D7F",
  }, bg)
end

local generator = require("zenbones.specs")
local specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))
lush(specs)
require("zenbones.term").apply_colors(palette)
