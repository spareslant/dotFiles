return require("packer").startup(function()
  -- nvim package manager
  use("wbthomason/packer.nvim")

  -- common library
  use("nvim-lua/plenary.nvim")

  -- icons and colors
  use("norcalli/nvim-colorizer.lua")
  use("kyazdani42/nvim-web-devicons")

  -- colorschemes
  -- use("EdenEast/nightfox.nvim")
  -- use({ "catppuccin/nvim", as = "catppuccin" })
  -- use("rmehri01/onenord.nvim")
  -- use("projekt0n/github-nvim-theme")
  -- use({ "rose-pine/neovim", as = "rose-pine" })
  -- use("folke/tokyonight.nvim") -- quite variations in colors for syntax
  -- use("marko-cerovac/material.nvim") -- quite variations in colors for syntax
  -- use("Mofiqul/vscode.nvim")
  -- use("navarasu/onedark.nvim") -- quite variations in colors for syntax
  -- use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })
  use("Shatur/neovim-ayu")

  -- utilities
  use("kyazdani42/nvim-tree.lua")
  use("rcarriga/nvim-notify")
  use("nvim-telescope/telescope.nvim")
  -- use("nvim-lualine/lualine.nvim")
  use("tamton-aquib/staline.nvim")
  use({ "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" })
  use("lukas-reineke/indent-blankline.nvim")
  -- use("romgrk/barbar.nvim")
  -- use {'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons'}
  use({ "noib3/nvim-cokeline", requires = "kyazdani42/nvim-web-devicons" })
  use({ "famiu/bufdelete.nvim" }) -- required till the time cokeline fixes closing buffers
  use("voldikss/vim-floaterm")
  use("ellisonleao/glow.nvim")
  use("jamessan/vim-gnupg")
  use("luukvbaal/nnn.nvim")
  use("uga-rosa/ccc.nvim")
  use("sunjon/Shade.nvim")

  -- Code related
  use("lewis6991/gitsigns.nvim")
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  use({ "sindrets/diffview.nvim" })
  use("windwp/nvim-autopairs")
  use("numToStr/Comment.nvim")
  use("andymass/vim-matchup")
  use("folke/trouble.nvim")
  use("saltstack/salt-vim")
  use("lepture/vim-jinja")
  use("towolf/vim-helm")
  use("ekalinin/Dockerfile.vim")
  use("kdheepak/lazygit.nvim")
  -- use({"danymat/neogen", requires = "nvim-treesitter/nvim-treesitter"})

  -- LSP configs
  use("neovim/nvim-lspconfig") -- Language Server Configurations
  use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in language server client
  use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
  use("hrsh7th/cmp-path") -- nvim-cmp source for filesystem paths
  use("hrsh7th/cmp-cmdline") -- nvim-cmp source for vim's cmdline
  use("hrsh7th/nvim-cmp") -- A completion engine plugin
  use("saadparwaiz1/cmp_luasnip")
  use("L3MON4D3/LuaSnip")
  use("onsails/lspkind-nvim")
  use("folke/lsp-colors.nvim")
  use("jose-elias-alvarez/null-ls.nvim")
  use("ColinKennedy/toggle-lsp-diagnostics.nvim")
  use("ray-x/lsp_signature.nvim")
  use("simrat39/rust-tools.nvim")
  use("j-hui/fidget.nvim")
end)
