-- require("tokyonight").setup({
-- })

-- vim.cmd[[colorscheme tokyonight-night]]
--
-- tokyonight.lua
local M = {}

function M.setup()
  local status_ok, _ = pcall(require, "tokyonight")
  if not status_ok then
    return
  end

  tokyonight.setup {
    -- Your Configuration
  }
  vim.cmd [[ colorscheme tokyonight ]]
end

return M

-- Other file

-- require "configs.tokyonight".setup()
