vim.g.vscode_style = "dark"
vim.cmd([[colorscheme vscode]])
require("lualine").setup({
  options = {
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    theme = "vscode",
  },
})
