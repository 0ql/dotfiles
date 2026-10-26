-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Buffer navigation (mirrors <S-l>/<S-h>)
map("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Next Buffer" })
map("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })

-- Delete to black hole register (never clobbers yank register)
map("n", "d", '"_d', { desc = "Delete (no yank)" })
map("v", "d", '"_d', { desc = "Delete (no yank)" })

-- Escape aliases: kj / jk in insert and terminal mode
vim.cmd([[
  inoremap kj <C-\><C-n>
  inoremap jk <C-\><C-n>
  tnoremap kj <C-\><C-n>
  tnoremap jk <C-\><C-n>
]])

-- q exits visual mode (instead of entering Ex / macro record)
map("x", "q", "<Esc>", { desc = "Exit Visual Mode" })

-- :TZ  →  open a terminal running zsh
vim.api.nvim_create_user_command("TZ", "term zsh", {})
