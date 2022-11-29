local ok, ca = pcall(require, "cellular-automaton")
if not ok then
    return
end

vim.api.nvim_create_user_command("Urgh", function()
    ca.start_animation("make_it_rain")
end, {})
vim.api.nvim_create_user_command("SendIt", function()
    ca.start_animation("game_of_life")
end, {})
