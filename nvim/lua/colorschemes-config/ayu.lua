-- color selections: https://www.canva.com/colors/color-wheel/
vim.o.background = 'dark'
require("ayu").setup({
  mirage = false,
  overrides = {
    Comment = { fg = "#9e926f" },
    LineNr = { fg = "#5081c0" },
    Visual = { bg = "#5a4e39" },
    CursorLine = { bg = "#2e2e2e" },
    IncSearch = { bg = '#FFFFFF', fg = '#0e110b' },
  },
})
require("ayu").colorscheme()

require("lualine").setup({
  options = {
    -- component_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    theme = "ayu_mirage",
  },
})
