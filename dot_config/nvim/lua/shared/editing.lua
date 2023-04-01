return {
    {
        "echasnovski/mini.surround",
        -- default keybinds with no lazy loading for vscode usage
        lazy = false,
        opts = {
            mappings = {
                add = "sa",
                delete = "sd",
                find = "sf",
                find_left = "sF",
                highlight = "sh",
                replace = "sr",
                update_n_lines = "sn",
            },
        },
        config = function(_, opts)
            require("mini.surround").setup(opts)
        end
    }
}
