local ok, duck = pcall(require, "duck")
if not ok then
    return
end

local creatures = {
    python = "🐍",
    rust = "🦀",
    go = "🐹",
}

local get_creature = function()
    local creature = creatures[vim.bo.filetype]
    if creature == nil then
        creature = "🪿"
    end
    return creature
end

vim.api.nvim_create_user_command("Goose", function() duck.hatch(get_creature()) end, {})
vim.api.nvim_create_user_command("GooseCook", function() duck.cook() end, {})

