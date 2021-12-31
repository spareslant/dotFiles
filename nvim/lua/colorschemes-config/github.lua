-- Lua
require('github-theme').setup({
  theme_style = "dark_default",
  sidebars = {"qf", "vista_kind", "terminal", "packer"},
})
require("lualine").setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    theme = "github",
  },
})
