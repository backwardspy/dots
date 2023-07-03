require("flash").setup({
  search = {
    mode = function(str)
      return "\\<" .. str
    end
  }
})
