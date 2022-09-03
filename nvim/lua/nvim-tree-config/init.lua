require("nvim-tree").setup({
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  actions = {
    open_file = {
      resize_window = false
    },
    expand_all = {
      max_folder_discovery = 300,
      exclude = { ".git" },
    },
  },
})
