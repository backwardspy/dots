return {
    {
        "alpha-nvim",
        opts = function(_, opts)
          local header = require("ascii").art.text.neovim.sharp
          -- remove (empty) first and last lines
          table.remove(header, 1)
          table.remove(header, #header)

          local lines = {}
          for i, line in ipairs(header) do
            table.insert(lines, {
                type = "text",
                val = line,
                opts = {
                    hl = "DashboardHeader" .. i,
                    position = "center",
                }
            })
          end
          opts.section.header.type = "group"
          opts.section.header.val = lines
          opts.section.header.opts.position = "center"
        end,
        dependencies = { "MaximilianLloyd/ascii.nvim" }
    }
}
