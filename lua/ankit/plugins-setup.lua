-- set termguicolors = true
-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- packer installing package

	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

	use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme
	use("folke/tokyonight.nvim") -- colorscheme : tokyonight
	use({ "catppuccin/nvim", as = "catppuccin" }) -- colorscheme : catppuccin
	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

	use("szw/vim-maximizer") -- maximizes and restores current window

	-- essential plugins
	use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
	use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	-- commenting with gc
	use("numToStr/Comment.nvim")

	-- file explorer
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})

	-- statusline
	use("nvim-lualine/lualine.nvim")

	--fuzzy finding
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers

	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	----------------====================================================================---------------------------

	-- bufferline provides tabs in neovim, tabs in vim are called buffers :)
	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })

	-- smooth scroll
	use("karb94/neoscroll.nvim")

	-- nvim colorizer
	use("norcalli/nvim-colorizer.lua")

	-- for initial page to be designed neovim

	use({
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
	})

	-- to show the progress of downloads and notifications
	use("rcarriga/nvim-notify")
	use("j-hui/fidget.nvim")

	---------------------=============================================================================-------------------

	use("junegunn/fzf") -- fuzzy finder to search through docs
	use("junegunn/fzf.vim") -- fuzzy finder to search through docs
	use("airblade/vim-rooter") -- helps fuzzy finder to search through git files too.

	use("tpope/vim-commentary") -- comment plugin : useful for commenting
	-- for commenting with respect to the file type

	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-file-browser.nvim" })

	-- markdown-preview.nvim : markdown preview plugin
	use({ "iamcco/markdown-preview.nvim" })

	use("hrsh7th/cmp-cmdline") -- completions for '/' search and command mode based on current buffer
	use("hrsh7th/cmp-nvim-lua")

	use("ray-x/lsp_signature.nvim") -- show function signature when you type

	use("BurntSushi/ripgrep") -- line-oriented search tool that recursively searches the current directory for a regex pattern.

	use("nvim-pack/nvim-spectre") -- a search panel for neovim

	--debugger DAP nvim
	use("mfussenegger/nvim-dap")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

	-- formatting & linting
	use("kana/vim-operator-user") -- formatter pre-requisite package for vim-clangd package.
	use("rhysd/vim-clang-format") -- formatter for c/c++

	-- preettier for nvim lsp
	use("MunifTanjim/prettier.nvim")

	use("tpope/vim-fugitive") -- vim plugin for Git

	use("farmergreg/vim-lastplace") --Intelligently reopen files at your last edit position in Vim

	-- With VimWiki, you can:

	-- Organize notes and ideas
	-- Manage to-do lists
	-- Write documentation
	-- Maintain a diary
	-- Export everything to HTML

	use("vimwiki/vimwiki") -- Personal Wiki for Vim

	use("tpope/vim-eunuch") -- Vim sugar for the UNIX shell commands that need it the most

	use("tpope/vim-sleuth") -- Heurestically set buffer options

	-- Toggleterm.nvim => to toggle between terminal and nvim mainly
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup()
		end,
	})

	-- Plugin for adding annotations feature
	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup({})
		end,
		requires = "nvim-treesitter/nvim-treesitter",
	})

	-- plugin for C/C++ language support
	use("vim-jp/vim-cpp")
	--	use("dense-analysis/ale")

	use({
		requires = { "nvim-treesitter/nvim-treesitter" },
		"Badhi/nvim-treesitter-cpp-tools",
	})

	use("neoclide/coc.nvim")

	use("jiangmiao/auto-pairs")

	-- Plugin for a collection of language packs for Vim
	use("sheerun/vim-polyglot")

	-- Adding transparency effect to nvim --------------

	use("xiyaowong/nvim-transparent")

	------------------------------------------------------

	-----------------------------
	use("mattn/emmet-vim") --a vim plug-in which provides support for expanding abbreviations similar to emmet.

	-- -- package for ChatGPT
	-- use({
	-- 	"jackMort/ChatGPT.nvim",
	-- 	config = function()
	-- 		require("chatgpt").setup({
	-- 			-- optional configuration
	-- 		})
	-- 	end,
	-- 	requires = {
	-- 		"MunifTanjim/nui.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 	},
	-- })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
