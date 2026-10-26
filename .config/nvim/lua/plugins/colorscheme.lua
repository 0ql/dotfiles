return {
  -- Add gruvbox
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      transparent_mode = true, -- mirrors lvim.transparent_window = true
    },
  },

  -- Tell LazyVim to use gruvbox instead of its default (tokyonight)
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
