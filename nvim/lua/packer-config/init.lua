return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'kyazdani42/nvim-web-devicons'	
	use 'EdenEast/nightfox.nvim'
	use 'kyazdani42/nvim-tree.lua'
	use 'rcarriga/nvim-notify'
	use 'romgrk/barbar.nvim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- LSP configs
	use 'nvim-lualine/lualine.nvim'
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use 'onsails/lspkind-nvim'
end)
