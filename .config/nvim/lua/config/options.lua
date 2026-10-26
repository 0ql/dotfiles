-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"
--
-- Indentation: keep real tabs (expandtab = false), width 2
vim.opt.expandtab = false -- do NOT convert tabs to spaces
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- UI
vim.opt.cursorline = false
vim.opt.wrap = false

-- Transparent background (mirrors lvim.transparent_window = true)
-- gruvbox.nvim handles this via its own option (see plugins/colorscheme.lua),
-- but we also clear backgrounds after any colorscheme loads as a fallback.
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local groups = {
      "Normal",
      "NormalNC",
      "NormalFloat",
      "SignColumn",
      "NeoTreeNormal",
      "NeoTreeNormalNC",
      "TelescopeNormal",
      "TelescopeBorder",
      "BufferLineFill",
    }
    for _, g in ipairs(groups) do
      vim.api.nvim_set_hl(0, g, { bg = "none", ctermbg = "none" })
    end
  end,
})
