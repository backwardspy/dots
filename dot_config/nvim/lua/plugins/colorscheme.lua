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
      flavour = os.getenv("appearance") == "light" and "latte" or "mocha",
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
      color_overrides = {
        mocha = {
          base = "#171717",
          mantle = "#101010",
          crust = "#0C0C0C",
        },
      },
      custom_highlights = function(colors)
        local utils = require("catppuccin.utils.colors")
        local tint = function(tint)
          return utils.blend(tint, colors.base, 0.2)
        end

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
          -- cmp
          --
          PmenuSel = { bg = colors.mantle, fg = "NONE" },
          Pmenu = { fg = colors.text, bg = colors.crust },

          CmpItemAbbrDeprecated = { fg = colors.overlay0, bg = "NONE", style = { "strikethrough" } },
          CmpItemAbbrMatch = { fg = colors.yellow, bg = "NONE", style = { "bold" } },
          CmpItemAbbrMatchFuzzy = { fg = colors.yellow, bg = "NONE", style = { "bold" } },
          CmpItemMenu = { fg = colors.lavender, bg = "NONE", style = { "italic" } },

          CmpItemKindField = { fg = colors.rosewater, bg = tint(colors.rosewater) },
          CmpItemKindProperty = { fg = colors.rosewater, bg = tint(colors.rosewater) },
          CmpItemKindEvent = { fg = colors.rosewater, bg = tint(colors.rosewater) },

          CmpItemKindText = { fg = colors.text, bg = tint(colors.text) },
          CmpItemKindModule = { fg = colors.text, bg = tint(colors.text) },
          CmpItemKindVariable = { fg = colors.text, bg = tint(colors.text) },
          CmpItemKindFile = { fg = colors.text, bg = tint(colors.text) },
          CmpItemKindUnit = { fg = colors.text, bg = tint(colors.text) },
          CmpItemKindValue = { fg = colors.text, bg = tint(colors.text) },

          CmpItemKindEnum = { fg = colors.yellow, bg = tint(colors.yellow) },
          CmpItemKindReference = { fg = colors.yellow, bg = tint(colors.yellow) },
          CmpItemKindClass = { fg = colors.yellow, bg = tint(colors.yellow) },
          CmpItemKindFolder = { fg = colors.yellow, bg = tint(colors.yellow) },
          CmpItemKindEnumMember = { fg = colors.yellow, bg = tint(colors.yellow) },
          CmpItemKindInterface = { fg = colors.yellow, bg = tint(colors.yellow) },

          CmpItemKindKeyword = { fg = colors.mauve, bg = tint(colors.mauve) },

          CmpItemKindConstant = { fg = colors.peach, bg = tint(colors.peach) },

          CmpItemKindConstructor = { fg = colors.lavender, bg = tint(colors.lavender) },

          CmpItemKindFunction = { fg = colors.blue, bg = tint(colors.blue) },
          CmpItemKindMethod = { fg = colors.blue, bg = tint(colors.blue) },

          CmpItemKindStruct = { fg = colors.teal, bg = tint(colors.teal) },
          CmpItemKindOperator = { fg = colors.teal, bg = tint(colors.teal) },

          CmpItemKindSnippet = { fg = colors.flamingo, bg = tint(colors.flamingo) },

          CmpItemKindColor = { fg = colors.pink, bg = tint(colors.pink) },
          CmpItemKindTypeParameter = { fg = colors.maroon, bg = tint(colors.maroon) },
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
