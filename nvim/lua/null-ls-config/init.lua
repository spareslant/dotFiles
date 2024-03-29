local null_ls = require("null-ls")

-- register any number of sources simultaneously
local sources = {
  null_ls.builtins.formatting.prettier,
  -- null_ls.builtins.diagnostics.write_good,
  -- null_ls.builtins.code_actions.gitsigns,
  -- null_ls.builtins.formatting.rustfmt,
  -- null_ls.builtins.formatting.shellharden,
  -- null_ls.builtins.formatting.stylua.with({
  --   extra_args = { "--indent-type=Spaces", "--indent-width=2", },
  -- }),
  -- null_ls.builtins.formatting.terraform_fmt,
}

null_ls.setup({ sources = sources })
