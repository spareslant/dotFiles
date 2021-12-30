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
	use("folke/tokyonight.nvim") -- quite variations in colors for syntax
	use("marko-cerovac/material.nvim") -- quite variations in colors for syntax
	-- use("Mofiqul/vscode.nvim")
	-- use("navarasu/onedark.nvim") -- quite variations in colors for syntax
	-- use({ "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } })

	-- utilities
	use("kyazdani42/nvim-tree.lua")
	use("rcarriga/nvim-notify")
	use("nvim-telescope/telescope.nvim")
	use("nvim-lualine/lualine.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("romgrk/barbar.nvim")
	use("voldikss/vim-floaterm")
	use("ellisonleao/glow.nvim")
	use("jamessan/vim-gnupg")

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

	-- LSP configs
	use("neovim/nvim-lspconfig")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("saadparwaiz1/cmp_luasnip")
	use("L3MON4D3/LuaSnip")
	use("onsails/lspkind-nvim")
	use("folke/lsp-colors.nvim")
	use("jose-elias-alvarez/null-ls.nvim")
end)
