local ok, feline = pcall(require, "feline")
if not ok then
    return
end

local require_then = require("utils").require_then

require_then("nvim-navic", function(navic)
    local winbar = {
        active = {},
        inactive = {},
    }

    table.insert(winbar.active, {
        {
            provider = function()
                return navic.get_location()
            end,
            enabled = function()
                return navic.is_available()
            end,
        },
    })

    feline.winbar.setup({ components = winbar })
end)

require_then("catppuccin.groups.integrations.feline", function(ctp_feline)
    ctp_feline.setup({})
    feline.setup({ components = ctp_feline.get() })
end)
