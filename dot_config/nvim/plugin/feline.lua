local ok, feline = pcall(require, "feline")
if not ok then
    return
end

local navic_ok, navic = pcall(require, "nvim-navic")
if navic_ok then
    print("setting navic winbar")
    local winbar = {
        active = {},
        inactive = {},
    }

    table.insert(winbar.active, {{
        provider = function()
            return navic.get_location()
        end,
        enabled = function()
            return navic.is_available()
        end,
    }})

    feline.winbar.setup({ components = winbar })
end

local ctp_ok, ctp_feline = pcall(require, "catppuccin.groups.integrations.feline")
if ctp_ok then
    ctp_feline.setup({})
    feline.setup({ components = ctp_feline.get() })
end
