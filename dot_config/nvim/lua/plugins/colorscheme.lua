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
      integrations = {
        gitsigns = true,
        indent_blankline = { enabled = true },
        leap = true,
        mason = true,
        mini = true,
        neotree = true,
        neogit = true,
        neotest = true,
        noice = true,
        cmp = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        notify = true,
        treesitter = true,
        telescope = true,
        lsp_trouble = true,
        which_key = true,
      },
      custom_highlights = function(colors)
        return {
          --
          -- notify
          --
          NotifyBackground = { bg = colors.mantle },
          --
          -- noice
          --
          NoiceCmdlinePopup = { bg = colors.mantle },
          NoiceCmdlinePopupBorder = { bg = colors.mantle, fg = colors.mantle },
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
          NeoTreeNormal = { bg = colors.mantle },
          NeoTreeNormalNC = { bg = colors.mantle },
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
  {
    "bufferline.nvim",
    dependencies = { "catppuccin" },
    opts = function(_, opts)
      opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
    end,
  },
  {
    "lualine.nvim",
    dependencies = { "catppuccin" },
    opts = {
      options = {
        section_separators = { left = "▓▒░", right = "░▒▓" },
      },
    },
  },
}
