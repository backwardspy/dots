local M = {}

local setup_tab_bar = function(config, wez)
    wez.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
        -- limit text to max_width-2
        local title = tab.active_pane.title
        if #title > max_width - 4 then
            title = string.sub(title, 1, max_width - 4)
        end

        local palette = config.resolved_palette
        local bg = palette.tab_bar.background
        local fg = tab.is_active and palette.background or palette.tab_bar.inactive_tab.bg_color
        local text = palette.foreground

        return {
            { Background = { Color = bg } },
            { Foreground = { Color = fg } },
            { Text = "" },
            { Background = { Color = fg } },
            { Foreground = { Color = text } },
            { Text = " " .. title .. " " },
            { Background = { Color = bg } },
            { Foreground = { Color = fg } },
            { Text = "" },
        }
    end)

    config.use_fancy_tab_bar = false
    config.hide_tab_bar_if_only_one_tab = true
    config.tab_bar_at_bottom = true
end

local americano = function()
    local americano = require("wezterm").color.get_builtin_schemes()["Catppuccin Mocha"]
    americano.background = "#000000"
    americano.tab_bar.background = "#101010"
    americano.tab_bar.inactive_tab.bg_color = "#202020"
    americano.tab_bar.new_tab.bg_color = "#202020"
    return americano
end

M.apply = function(config, wez)
    setup_tab_bar(config, wez)

    local colours = function(appearance)
        if appearance:find("Dark") then
            return "Catppuccin Americano"
        else
            return "Catppuccin Latte"
        end
    end

    config.color_schemes = {
        ["Catppuccin Americano"] = americano(),
    }
    config.color_scheme = colours(wez.gui.get_appearance())

    config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
    config.font = wez.font("JetBrains Mono")
    config.font_size = string.match(wez.target_triple, "darwin") and 17 or 11

    config.window_padding = { top = 0, bottom = 0, left = 0, right = 0 }
    config.use_resize_increments = true
end

return M
