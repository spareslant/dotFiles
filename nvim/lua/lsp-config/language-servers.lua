util = require("lspconfig/util")

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
local signs = { Error = "󰅚", Warn = "", Hint = "󰌶", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  -- virtual_text = true,
  virtual_text = {
    prefix = '●',
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = false,
  float = { border = "rounded" },
})

local signature_setup = require("lsp_signature").setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded",
  },
})

require("lspconfig.ui.windows").default_options.border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  -- Use a sharp border with `FloatBorder` highlights
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  -- Use a sharp border with `FloatBorder` highlights
  border = "rounded",
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)

  require("lsp_signature").on_attach(signature_setup, bufnr)
end

-- https://github.com/ray-x/lsp_signature.nvim/blob/master/tests/init_paq.lua
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" },
}

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require("lspconfig")["pyright"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
})
require("lspconfig")["ts_ls"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
})
require("lspconfig")["terraformls"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
})
require("lspconfig")["bashls"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
})
require("lspconfig")["ansiblels"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
})
require("lspconfig")["gopls"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

-- https://levelup.gitconnected.com/a-step-by-step-guide-to-configuring-lsp-in-neovim-for-coding-in-next-js-a052f500da2
require("lspconfig")["lua_ls"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'use' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
})

-- Use following modeline at the the top of yaml doc that you want to use for k8s
-- # yaml-language-server: $schema=https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.25.0/all.json
require("lspconfig")["yamlls"].setup({
  on_attach = on_attach,
  flags = lsp_flags,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemas = { kubernetes = "*.yaml" },
      format = { enable = true },
      hover = true,
      validate = true,
      completion = true,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemaDownload = { enable = true },
    },
  },
})

-- configured by rust-tools plugin
-- require("lspconfig")["rust_analyzer"].setup({
--   on_attach = on_attach,
--   flags = lsp_flags,
--   capabilities = capabilities,
--   -- Server-specific settings...
--   settings = {
--     ["rust-analyzer"] = {},
--   },
-- })
