lvim.leader = ";"
lvim.colorscheme = "gruvbox"

lvim.plugins = {
	{ "ellisonleao/gruvbox.nvim" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
	{ "0ql/google_search.nvim", requires = 'MunifTanjim/nui.nvim' }
}

lvim.transparent_window = true
vim.opt.cursorline = false
vim.opt.expandtab = false -- convert tabs to spaces
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false

lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["d"] = '"_d'
lvim.keys.visual_mode["d"] = '"_d'

vim.cmd [[
  au BufRead,BufNewFile *.astro set filetype=astro
  au BufRead,BufNewFile *.rasi set filetype=css
  au BufRead,BufNewFile *.pamm set filetype=markdown
  au BufRead,BufNewFile *.gohtml set filetype=html
  au BufRead,BufNewFile *.md LvimToggleFormatOnSave
  inoremap kj <C-\><C-n>
  inoremap jk <C-\><C-n>
  tnoremap jk <C-\><C-n>
  tnoremap kj <C-\><C-n>
	command! TZ term zsh
]]
