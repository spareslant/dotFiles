-- color selections: https://www.canva.com/colors/color-wheel/
vim.o.background = 'dark'
require("ayu").setup({
  mirage = false,
  overrides = {
    -- Comment = { fg = "#9e926f" },
    Comment = { fg = "#f9f29b" },
    LineNr = { fg = "#5081c0" },
    Visual = { bg = "#5a4e39" },
    CursorLine = { bg = "#2e2e2e" },
    IncSearch = { bg = '#FFFFFF', fg = '#0e110b' },
  },
})
require("ayu").colorscheme()
