return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'kyazdani42/nvim-web-devicons'	
	use 'EdenEast/nightfox.nvim'
	use 'kyazdani42/nvim-tree.lua'
	use 'rcarriga/nvim-notify'
	use 'akinsho/bufferline.nvim'
	use 'nvim-lualine/lualine.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'lewis6991/gitsigns.nvim'
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'nvim-telescope/telescope.nvim'
	use { 'sindrets/diffview.nvim'}
	use 'lukas-reineke/indent-blankline.nvim'
	use 'folke/which-key.nvim'
	use 'windwp/nvim-autopairs'
	use 'numToStr/Comment.nvim'
	use 'norcalli/nvim-colorizer.lua'

	-- LSP configs
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'L3MON4D3/LuaSnip'
	use 'onsails/lspkind-nvim'
end)
