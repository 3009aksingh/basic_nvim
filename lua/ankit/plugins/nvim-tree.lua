-- -- import nvim-tree plugin safely
-- local setup, nvimtree = pcall(require, "nvim-tree")
-- if not setup then
-- 	return
-- end
--
-- -- recommended settings from nvim-tree documentation
--
-- -- change color for arrows in tree to light blue
-- vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])
--
-- -- configure nvim-tree
-- nvimtree.setup({
-- 	-- change folder arrow icons
-- 	renderer = {
-- 		icons = {
-- 			glyphs = {
-- 				folder = {
-- 					arrow_closed = "", -- arrow when folder is closed
-- 					arrow_open = "", -- arrow when folder is open
-- 				},
-- 			},
-- 		},
-- 		-- indent_markers = {
-- 		-- 	enable = true,
-- 		-- 	icons = {
-- 		-- 		corner = "└ ",
-- 		-- 		edge = "│ ",
-- 		-- 		none = "  ",
-- 		-- 	},
-- 		-- },
-- 	},
-- 	-- disable window_picker for
-- 	-- explorer to work well with
-- 	-- window splits
-- 	actions = {
-- 		open_file = {
-- 			window_picker = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
--
-- 	-- 	git = {
-- 	-- 		ignore = false,
-- 	-- 	},
-- })
--
--
--
-- ------------------------------------------------------------------------------------------
-- ------------------------------------------------------------------------------------------------------
--
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	renderer = {
		root_folder_modifier = ":t",
		indent_markers = {
			enable = true,
			icons = {
				edge = "│",
				item = "├",
				corner = "└",
				none = " ",
			},
		},
		icons = {
			show = {
				folder_arrow = false,
			},
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_open = "",
					arrow_closed = "",
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					untracked = "U",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	view = {
		width = 30,
		side = "left",
		mappings = {
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "h", cb = tree_cb("close_node") },
				{ key = "v", cb = tree_cb("vsplit") },
			},
		},
	},
})
