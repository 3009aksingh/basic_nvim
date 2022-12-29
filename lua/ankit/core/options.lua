local opt = vim.opt --for conciseness

-- line numbers
opt.relativenumber = false
opt.number = true

-- tabs & indentation
opt.tabstop = 4
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true -- Do smart indenting, ex. auto-tab {}, [], etc.
opt.smarttab = true -- Extension of smartindent
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.ruler = false -- Don't show line number and column on the default bar
opt.wrap = false -- Disable word wrapping
opt.cmdheight = 1 -- Width of command menu
opt.pumheight = 10 -- Pop-up-menu height
opt.signcolumn = "yes" -- Always display the sign bar (gutter)
opt.showtabline = 2 -- Always show tabs
opt.cursorline = true -- Highlight current column
opt.scrolloff = 8 -- No. of lines to show above and below vh
opt.sidescrolloff = 8 -- No. of lines to show on the left and right
opt.shell = "kitty" -- Set the default shell to fish shell
opt.mouse = "a" -- Enable mouse support
opt.hlsearch = true -- Highlight search results
opt.timeoutlen = 500 -- Time to wait for a map to timeout
opt.undofile = true -- Enable presistent undo
opt.updatetime = 300 -- Faster completion

-- cursor line
opt.cursorline = true

-- appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")
