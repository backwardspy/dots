return {
  {
    "nvim-cmp",
    dependencies = {
      {
        "https://github.com/petertriho/cmp-git",
        config = true,
      },
      "onsails/lspkind.nvim",
    },
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-y>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      })

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "git" },
      }))

      opts.window = {
        completion = {
          winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
          col_offset = -3,
          side_padding = 0,
        },
      }

      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local fmt = require("lspkind").cmp_format({
            mode = "symbol",
            maxwidth = 50,
          })(entry, vim_item)

          -- room to breathe
          fmt.kind = fmt.kind .. " "

          return fmt
        end,
      }
    end,
  },
}
