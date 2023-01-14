local transform = function(state)
    return function(filename)
        if filename:find("toggleterm") ~= nil then
            return "Hacking"
        elseif filename ~= nil then
            return state .. " " .. filename
        end
    end
end

return {
    {
        "andweeb/presence.nvim",
        config = function()
            require("presence"):setup({
                client_id = "1063527388253798441",
                neovim_image_text = "Copyright © Electronic Arts 1997",
                main_image = "file",
                editing_text = transform("Editing"),
                reading_text = transform("Reading"),
            })
        end,
    },
}
