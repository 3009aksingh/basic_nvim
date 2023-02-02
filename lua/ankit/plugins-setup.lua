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
	use("JoosepAlviste/palenightfall.nvim")
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

	--indentline
	use("lukas-reineke/indent-blankline.nvim")

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
	-- enhanced lsp uis
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("lspsaga").setup({})
		end,
	})

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
	--	use("rcarriga/nvim-notify")
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
	use("Pocco81/DAPInstall.nvim")

	use({
		"gelguy/wilder.nvim",
		config = function()
			-- config goes here
		end,
	})

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

	--  WARNING: dense-analysis plugins brings unnecessary warning in C/C++ code.

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

	-- Highlight, list and search todo comments in your projects
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	--  A pretty diagnostics, references, telescope results,
	--  quickfix and location list to help you solve all the
	--  trouble your code is causing.
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- Live server for automating the reloading of web pages after editing.
	use("manzeloth/live-server")

	-- Highly experimental plugin that completely replaces the UI for
	-- messages, cmdline and the popupmenu
	-- use({
	-- 	"folke/noice.nvim",
	-- 	-- config = function()
	-- 	-- require("noice").setup({
	-- 	-- 	-- add any options here
	-- 	-- })
	-- 	-- end,
	-- 	requires = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	},
	-- })
	--
	-- Display a popup with possible keybindings of the command you started typing
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	--  Allowing you to jump anywhere in a document with as few keystrokes as possible
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	--	require("packer").use({ "mhartington/formatter.nvim" })

	-- plugin for automatically highlighting other uses of the word
	-- under the cursor using either LSP, Tree-sitter, or regex matching.
	-- use("RRethy/vim-illuminate")

	-- Neovim setup for init.lua and plugin development with full signature help,
	-- docs and completion for the nvim lua API.
	use("folke/neodev.nvim")

	-- Peek lines just when you intend
	use("nacro90/numb.nvim")

	-- The goal of nvim-bqf is to make Neovim's quickfix window better.
	use({ "kevinhwang91/nvim-bqf" })

	-- Make Ranger running in a floating window to communicate with Neovim via RPC
	use("kevinhwang91/rnvimr")

	-- Edit and review GitHub issues and pull requests from the comfort of your favorite editor
	use({
		"pwntester/octo.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("octo").setup()
		end,
	})

	-- required for below package Gist
	use("mattn/webapi-vim")

	-- Vim plugin for Gist
	use("mattn/vim-gist") -- TODO: need to configure it when needed

	-- Rainbow brackets customization plugin
	use("p00f/nvim-ts-rainbow")

	-- superior project management solution for neovim.
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- package for ChatGPT
	use({
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup({
				-- optional configuration
			})
		end,
		requires = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	})

	---== Few more Color schemes ==----

	use("EdenEast/nightfox.nvim") -- just another colorscheme ;)
	use("Yazeed1s/oh-lucy.nvim")
	use("arzg/vim-colors-xcode")
	use("sam4llis/nvim-tundra")

	use({
		"olivercederborg/poimandres.nvim",
		config = function()
			require("poimandres").setup({
				-- leave this setup function empty for default config
				-- or refer to the configuration section
				-- for configuration options
			})
		end,
	})

	use("Yazeed1s/minimal.nvim")

	-- Packer
	use("olimorris/onedarkpro.nvim")

	use({
		"ray-x/starry.nvim",
		setup = function()
			-- see example setup below
			vim.g.starry_italic_comments = true
		end,
	})
	-- use({
	-- 	"rose-pine/neovim",
	-- 	as = "rose-pine",
	-- 	config = function()
	-- 		vim.cmd("colorscheme rose-pine")
	-- 	end,
	-- })
	-- use({
	-- 	"projekt0n/github-nvim-theme",
	-- 	config = function()
	-- 		require("github-theme").setup({
	-- 			-- ...
	-- 		})
	-- 	end,
	-- })

	-- Using Packer:
	use("Mofiqul/dracula.nvim")
	use("dracula/vim")
	-- Screensaver
	-- use({
	-- 	"folke/drop.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("drop").setup()
	-- 	end,
	-- })

	use("katawful/kat.nvim")

	use({ "kartikp10/noctis.nvim", requires = { "rktjmp/lush.nvim" } })

	-- Using Packer
	use("navarasu/onedark.nvim")

	-- If you are using Packer
	use("shaunsingh/moonlight.nvim")

	-----------====================Colorscheme ended================----------------

	-- winbar plugin to provide a bar which resembles the location of file we are working : eg. lua > ankit > plugins-setup.lua > packer.startup
	use({
		"utilyre/barbecue.nvim",
		requires = {
			"neovim/nvim-lspconfig",
			"smiteshp/nvim-navic",
			"kyazdani42/nvim-web-devicons", -- optional
		},
		config = function()
			require("barbecue").setup()
		end,
	})

	-- competitive programmer helpful plugins
	use({ -- TODO: need to understand how to use it
		"xeluxee/competitest.nvim",
		requires = "MunifTanjim/nui.nvim",
		config = function()
			require("competitest").setup()
		end,
	})

	use("p00f/cphelper.nvim") -- TODO: need to understand about how to use it

	-- Clean and elegant distraction-free writing for NeoVim
	use("Pocco81/true-zen.nvim")

	use("dstein64/vim-startuptime")

	-- Note taking plugin which uses the feature of node and trees. TODO: need to learn the implementation
	-- https://youtu.be/UWSOGoHqkv4
	use({
		"phaazon/mind.nvim",
		branch = "v2.2",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("mind").setup()
		end,
	})

	-- Improves the UI
	use("stevearc/dressing.nvim")

	-- Extra syntax and highlight for nerdtree files
	use("tiagofumo/vim-nerdtree-syntax-highlight")

	-- Emoji/Unicode Icons Theme for Vim and Neovim with support for 40+ plugins and 380+ filetypes
	-- use("adelarsq/vim-emoji-icon-theme")

	-- A collection of LS_COLORS definitions; needs your contribution!
	use("trapd00r/LS_COLORS")

	-- Scrollbar
	use("petertriho/nvim-scrollbar")
	use({
		"kevinhwang91/nvim-hlslens",
		config = function()
			-- require('hlslens').setup() is not required
			require("scrollbar.handlers.search").setup({
				-- hlslens config overrides
			})
		end,
	})

	use({
		"nvim-zh/colorful-winsep.nvim",
		config = function()
			require("colorful-winsep").setup()
		end,
	})

	use({
		"ghillb/cybu.nvim",
		branch = "main", -- timely updates
		-- branch = "v1.x", -- won't receive breaking changes
		requires = { "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" }, -- optional for icon support
		config = function()
			local ok, cybu = pcall(require, "cybu")
			if not ok then
				return
			end
			cybu.setup()
			vim.keymap.set("n", "K", "<Plug>(CybuPrev)")
			vim.keymap.set("n", "J", "<Plug>(CybuNext)")
			vim.keymap.set({ "n", "v" }, "<c-s-tab>", "<plug>(CybuLastusedPrev)")
			vim.keymap.set({ "n", "v" }, "<c-tab>", "<plug>(CybuLastusedNext)")
		end,
	})

	use({ "is0n/jaq-nvim" })

	use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })

	use({
		"stevearc/aerial.nvim",
		config = function()
			require("aerial").setup()
		end,
	})

	use({
		"saecki/crates.nvim",
		tag = "v0.3.0",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	})

	use("simrat39/symbols-outline.nvim")

	use("DaikyXendo/nvim-material-icon")

	use({
		"mrjones2014/legendary.nvim",
		-- sqlite is only needed if you want to use frecency sorting
		-- requires = 'kkharji/sqlite.lua'
	})

	use("echasnovski/mini.animate")

	-- To create image of code
	-- use({
	-- 	"narutoxy/silicon.lua",
	-- 	requires = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("silicon").setup({})
	-- 	end,
	-- })

	use("doums/dmap.nvim")

	use({
		"ThePrimeagen/refactoring.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	})

	use("jinh0/eyeliner.nvim")

	-- Is using a standard Neovim install, i.e. built from source or using a
	-- provided appimage.

	use("lewis6991/impatient.nvim") -- Speeds up the startup of neovim

	--use("elihunter173/dirbuf.nvim") --edit your filesystem like you edit text

	if packer_bootstrap then
		require("packer").sync()
	end
end)
