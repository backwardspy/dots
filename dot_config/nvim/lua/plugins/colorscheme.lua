return {
    {
        "LazyVim",
        opts = {
            colorscheme = "catppuccin",
        },
    },
    {
        "catppuccin",
        opts = {
            custom_highlights = function(colors)
              return {
                  -- telescope
                  TelescopeMatching = { fg = colors.yellow },
                  TelescopeSelection = { fg = colors.text, bg = colors.surface0 },
                  -- results
                  TelescopeResultsNormal = { bg = colors.mantle },
                  TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
                  TelescopeResultsTitle = { fg = colors.mantle },
                  -- prompt
                  TelescopePromptNormal = { bg = colors.surface0 },
                  TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
                  TelescopePromptTitle = { bg = colors.teal, fg = colors.mantle },
                  TelescopePromptPrefix = { bg = colors.surface0 },
                  -- preview
                  TelescopePreviewNormal = { bg = colors.crust },
                  TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
                  TelescopePreviewTitle = { bg = colors.pink, fg = colors.mantle },
                  --
                  -- neotree
                  --
                  NeotreeNormal = { bg = colors.mantle },
              }
            end
        }
    }
}
