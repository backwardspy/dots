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
          --
          -- telescope
          --
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
          --
          -- alpha
          --
          DashboardHeader1 = { fg = "#94E2D5" },
          DashboardHeader2 = { fg = "#A2DDD8" },
          DashboardHeader3 = { fg = "#B0D9DA" },
          DashboardHeader4 = { fg = "#BED4DD" },
          DashboardHeader5 = { fg = "#CBD0DF" },
          DashboardHeader6 = { fg = "#D9CBE2" },
          DashboardHeader7 = { fg = "#E7C7E4" },
          DashboardHeader8 = { fg = "#F5C2E7" },
        }
      end,
    },
  },
}
