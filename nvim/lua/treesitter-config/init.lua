require("nvim-treesitter.configs").setup({
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    "lua",
    "python",
    "javascript",
    "rust",
    "ruby",
    "bash",
    "go",
    "json",
    "yaml",
    "typescript",
    "make",
    "terraform",
    "vim",
    "json",
    "yaml",
    "hcl",
    "helm",
    "tmux",
    "vim",
    "latex",
    "scala",
    "make",
    "markdown",
    "markdown_inline",
    "html",
    "csv",
    "java",
  },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    additional_vim_regex_highlighting = false,
  },
})
