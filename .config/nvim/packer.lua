-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
    use('ThePrimeagen/git-worktree.nvim')

	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use('nvim-treesitter/nvim-treesitter-context')
    use("vrischmann/tree-sitter-templ")
	use('theprimeagen/harpoon')
	-- use({
        -- 'rose-pine/neovim',
        -- as = 'rose-pine',
        -- config = function()
            -- vim.cmd('colorscheme rose-pine')
        -- end
    -- })
    use('EdenEast/nightfox.nvim')
	use('tpope/vim-fugitive')
    use('vim-airline/vim-airline')
    use('vim-airline/vim-airline-themes')

    use('mfussenegger/nvim-lint')

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},         -- Required
			{'hrsh7th/cmp-nvim-lsp'},     -- Required
			{'hrsh7th/cmp-buffer'},       -- Optional
			{'hrsh7th/cmp-path'},         -- Optional
			-- {'saadparwaiz1/cmp_luasnip'}, -- Optional. Removed because it is annoying and always completes things I do not want
			{'hrsh7th/cmp-nvim-lua'},     -- Optional

			-- Snippets
			{'L3MON4D3/LuaSnip'},             -- Required
			-- {'rafamadriz/friendly-snippets'}, -- Optional
		}
	}
    use {
        "zbirenbaum/copilot.lua" ,
        -- cmd="Copilot",
        -- event="InsertEnter",
        config= function()
            require("copilot").setup({
                panel = {
                    auto_refresh = true,
                },
                suggestion = {
                    auto_trigger = true,
                }
                -- filetypes = {
                    -- ["*"] = true,
                -- }
            })
        end,
    }
end)